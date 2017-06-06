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
  
  public TriviaView(ArrayList<JSONObject> categories) {
    // MENU
    int w = 340; //width
    int h = 170; //height
    int p = 40; //padding
    this.menu = new ArrayList<ScreenElem>();
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
    this.menu.add(new ScreenElem(width - 50, 20, 30, 20, new Gradient(white, white),
        color(#656565), "Exit", 20));
    // PLAYING
    this.playing = new ArrayList<AnswerButton>();
    this.question = null;
    this.image = null;
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
      case PLAYING:
        displayPlaying();
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
  private void displayPlaying() {
    textFont(medium);
    boolean hovering = false;
    image(this.image, 0, 300);
    this.question.display();
    for (AnswerButton b : playing) {
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
    for (int i = 0; i < answers.length; i++) {
      this.playing.add(new AnswerButton(400 + (Utils.boolToInt(i % 2 != 0) * 300),
                                        (Utils.boolToInt(i >= 2) * 300),
                                        300, 300, answers[i]));
    }
    this.question = new ScreenElem(0, 0, 400, 300, question.getGradient(),
        white, question.toString(), 40);
    this.image = draw.coverImage(question.getImage(), 400, 300);
  }
  
  /**
   * Checks if an answer was chosen to the current question.
   *
   * @return true if an answer was chosen, false otherwise
   */
  private boolean answerChosen() {
    // TODO
    // Change boolean to return the answer if chosen, or null if not
    // if null, that means answer has not been chosen
    // if answer is correct, add 1 to score in model
    // if answer is false, don't mutate score
    return true;
  }
}