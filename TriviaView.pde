import java.util.Arrays;
/**
 * Represents the view for a trivia game.
 */
public class TriviaView {
  private final PFont bold = loadFont("bold.vlw");
  private final PFont medium = loadFont("medium.vlw");
  private final color white = color(255);
  private final color black = color(0);
  private final DrawUtils draw = new DrawUtils();
  
  private final ArrayList<ScreenElem> menu;
  private ArrayList<AnswerButton> playing;
  private ScreenElem question;
  private PImage image;
  
  /**
   * Constructs a new {@code TriviaView} object.
   *
   * @param categories    a list of the JSON data for the different categories
   */
  public TriviaView(ArrayList<JSONObject> categories) throws IllegalArgumentException {
    this.menu = this.initMenu(categories);
    this.playing = new ArrayList<AnswerButton>();
    this.question = null;
    this.image = null;
  }
  
  /**
   * Initializes and creates all of the menu buttons.
   *
   * @param categories    a list of the JSON data for the different categories
   */
  private ArrayList<ScreenElem> initMenu(ArrayList<JSONObject> categories) 
      throws IllegalArgumentException {
    if (categories == null || categories.contains(null)) {
      throw new IllegalArgumentException("Cannot use given list.");
    }
    int w = 340; // width
    int h = 170; // height
    int p = 40;  // padding
    ArrayList<ScreenElem> menu = new ArrayList<ScreenElem>();
    for (int i = 0; i < categories.size(); i++) {
      JSONObject category = categories.get(i);
      String title = category.getString("title");
      JSONArray top = category.getJSONObject("gradient").getJSONArray("top");
      JSONArray bot = category.getJSONObject("gradient").getJSONArray("bot");
      color topColor = color(top.getInt(0), top.getInt(1), top.getInt(2));
      color botColor = color(bot.getInt(0), bot.getInt(1), bot.getInt(2));
      menu.add(new ScreenElem(130 + (Utils.boolToInt(i % 2 != 0) * (w + p)),
                          140 + (Utils.boolToInt(i >= 2) * (h + p)),
                          w, h, new Gradient(topColor, botColor), white, title, 40));
    }
    menu.add(new ScreenElem(width - 50, 20, 30, 20, new Gradient(white, white),
        color(#656565), "Exit", 20));
    return menu;
  }
  
  /**
   * Displays the current game state.
   */
  public void display(GameState gameState) {
    if (gameState == null) {
      throw new IllegalArgumentException("Cannot pass null GameState.");
    }
    background(white);
    noStroke();
    smooth();
    switch (gameState) {
      case MENU:
        displayMenu();
        break;
      case REVEAL:
      case PLAYING:
        displayPlaying(gameState);
        break;
      case OVER:
        displayOver();
        break;
      default:
        break;
    }
  }
  
  /**
   * Displays the menu.
   */
  private void displayMenu() {
    textFont(bold);
    textSize(60);
    textAlign(LEFT, BOTTOM);
    fill(black);
    text("Trivia", 130, 120);
    boolean hovering = false;
    for (ScreenElem b : menu) {
      b.display();
      if (b.hover()) {
        hovering = true;
      }
    }
    if (hovering) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
  
  /**
   * Displays the current question.
   */
  private void displayPlaying(GameState gameState) {
    // TODO
    // REMOVE HOVER STATES AND ABILITY TO CLICK MORE THAN ONE DURING REVEAL STAGE
    // REVEAL INCORRECT/CORRECT ONE
    boolean hovering = false;
    image(this.image, 0, 300);
    textFont(bold);
    this.question.display();
    textFont(medium);
    for (AnswerButton b : playing) {
      b.display();
      if (b.hover()) {
        hovering = true;
      }
    }
    if (gameState.equals(GameState.PLAYING)) {
      if (hovering) {
        cursor(HAND);
      } else {
        cursor(ARROW);
      }
    }
  }
  
  /**
   * Displays the game over state.
   */
  private void displayOver() {
    return;
  }
  
  /**
   * Gets the category, or exit button, clicked in the
   * main menu, or null if nothing has been clicked.
   *
   * @return the String representation of the button, or null
   * if no button has been clicked
   */
  public String getCategory() {
    for (ScreenElem b : menu) {
      if (b.hover()) {
        return b.toString();
      }
    }
    return null;
  }
  
  /**
   * Changes the view and buttons to the given question.
   *
   * @throws IllegalArgumentException if the given question is uninitialized
   */
  public void nextQuestion(Question question) throws IllegalArgumentException {
    if (question == null) {
      throw new IllegalArgumentException("Cannot display uninitialized question.");
    }
    Answer[] answers = question.getAnswers();
    this.playing = new ArrayList<AnswerButton>();
    textFont(medium);
    for (int i = 0; i < answers.length; i++) {
      this.playing.add(new AnswerButton(400 + (Utils.boolToInt(i % 2 != 0) * 300),
                                        (Utils.boolToInt(i >= 2) * 300),
                                        300, 300, answers[i]));
    }
    textFont(bold);
    this.question = new ScreenElem(0, 0, 400, 300, question.getGradient(),
        white, question.toString(), 40);
    this.image = draw.coverImage(question.getImage(), 400, 300);
  }
  
  /**
   * Checks if an answer was chosen to the current question.
   *
   * @return true if an answer was chosen, false otherwise
   */
  private Answer answerChosen() {
    for (AnswerButton a : this.playing) {
      if (a.getState().equals(ButtonState.CORRECT) || a.getState().equals(ButtonState.WRONG)) {
        return a.getAnswer();
      }
    }
    // TODO
    // Change boolean to return the answer if chosen, or null if not
    // if null, that means answer has not been chosen
    // if answer is correct, add 1 to score in model
    // if answer is false, don't mutate score
    return null;
  }
}