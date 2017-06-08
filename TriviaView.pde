import java.util.Arrays;
/**
 * Represents the view for a trivia game.
 */
public class TriviaView {
  private final PFont bold = loadFont("bold.vlw");
  private final PFont medium = loadFont("medium.vlw");
  private final color white = color(255);
  private final color black = color(0);
  private final color gray = color(120);
  private final DrawUtils draw = new DrawUtils();
  
  private final ArrayList<ScreenElem> menu;
  private ArrayList<AnswerButton> playing;
  private ArrayList<ScreenElem> over;
  private ScreenElem question;
  private PImage image;
  
  /**
   * Constructs a new {@code TriviaView} object.
   *
   * @param categories   a map of category titles and the array of Questions
   *                     in that category
   */
  public TriviaView(Map<String, Question[]> categories) throws IllegalArgumentException {
    this.menu = this.initMenu(categories);
    this.playing = new ArrayList<AnswerButton>();
    this.over = this.initOver();
    this.question = null;
    this.image = null;
  }
  
  /**
   * Initializes and creates all of the menu elements, including category and
   * exit buttons.
   *
   * @param categories   a map of category titles and the array of Questions
   *                     in that category
   * @return a list of all of the menu elements
   */
  private ArrayList<ScreenElem> initMenu(Map<String, Question[]> categories) 
      throws IllegalArgumentException {
    if (categories == null) {
      throw new IllegalArgumentException("Cannot use given list.");
    }
    int w = 340; // width
    int h = 170; // height
    int p = 40;  // padding
    ArrayList<ScreenElem> menu = new ArrayList<ScreenElem>();
    int index = 0;
    for (String s : categories.keySet()) {
      String title = s;
      Gradient gradient = categories.get(title)[0].getGradient();
      menu.add(new ScreenElem(130 + (Utils.boolToInt(index % 2 != 0) * (w + p)),
                          140 + (Utils.boolToInt(index >= 2) * (h + p)),
                          w, h, gradient, white, title, 40));
      index++;
    }
    menu.add(new ScreenElem(width - 50, 20, 30, 20, new Gradient(white, white),
        color(#656565), "Exit", 20));
    return menu;
  }
  
  /**
   * Initializes and creates the buttons for the game over screen. Adds a null to the
   * beginning of the list, which is later replaced with the category image when
   * a game is initialized.
   *
   * @return a list of the elements on the game over screen
   */
  private ArrayList<ScreenElem> initOver() {
    ArrayList<ScreenElem> over = new ArrayList<ScreenElem>();
    over.add(null);
    int p = 30;
    over.add(new ScreenElem(width - 70, 20, 50, 20, new Gradient(white, white),
        color(#656565), "Replay", 20));
    over.add(new ScreenElem(width - 70, 20 + p, 50, 20, new Gradient(white, white),
        color(#656565), "Menu", 20));
    return over;
  }
  
  /**
   * Displays the current game state.
   *
   * @param gameState         the current state of the game
   * @param score             the user's current score in the game
   * @param currentQuestion   the current question number
   */
  public void display(GameState gameState, int score, int currentQuestion) {
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
      case WAIT_FOR_RELEASE:
      case PLAYING:
        displayPlaying(gameState);
        break;
      case OVER:
        displayOver(score, currentQuestion);
        break;
      default:
        break;
    }
  }
  
  /**
   * Displays the main menu.
   */
  private void displayMenu() {
    textFont(bold);
    textSize(60);
    textAlign(LEFT, BOTTOM);
    fill(black);
    text("Trivia", 130, 120);
    boolean hovering = false;
    for (ScreenElem b : menu) {
      b.display(false, false);
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
   *
   * @param gameState   the current state of the game, used to check if it's
   *                    time to reveal the answers or if the computer is
   *                    waiting for the user to release the mouse
   */
  private void displayPlaying(GameState gameState) {
    boolean hovering = false;
    image(this.image, 0, 300);
    textFont(bold);
    this.question.display(false, false);
    textFont(medium);
    for (AnswerButton b : playing) {
      b.display(gameState.equals(GameState.WAIT_FOR_RELEASE),
          gameState.equals(GameState.REVEAL));
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
    } else {
      cursor(ARROW);
    }
  }
  
  /**
   * Displays the game over state.
   *
   * @param score            the user's score after answering the questions
   * @param totalQuestions   the total amount of questions in this round
   */
  private void displayOver(int score, int totalQuestions) {
    fill(black);
    textAlign(LEFT, BOTTOM);
    textFont(bold);
    textSize(60);
    String scoreText = Integer.toString(score);
    text(scoreText, 30, height - 250);
    fill(gray);
    text("/" + totalQuestions, 30 + textWidth(scoreText), height - 250);
    textFont(medium);
    textSize(40);
    fill(black);
    text("You scored", 30, height - 310);
    textFont(bold);
    boolean hovering = false;
    for (ScreenElem b : this.over) {
      b.display(false, false);
      if (b.hover() && this.over.indexOf(b) > 0) {
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
    if (this.over.get(0) == null) {
      this.over.set(0, new ScreenElem(30, height - 230, 400, 200, question.getGradient(),
          white, question.toString(), 40));
    }
  }
  
  /**
   * Checks if an answer was chosen to the current question, and if so,
   * returns the Answer object related to it.
   *
   * @return the answer chosen on the screen, or null if no answer has
   * been chosen yet
   */
  public Answer answerChosen() {
    for (AnswerButton a : this.playing) {
      if (a.getState(false).equals(ButtonState.CORRECT) || a.getState(false).equals(ButtonState.WRONG)) {
        return a.getAnswer();
      }
    }
    return null;
  }
  
  /**
   * Gets the element that was clicked on the game over screen.
   *
   * @return the String representation of the element clicked,
   * or null if nothing was clicked
   */
  public String getOverAction() {
    for (ScreenElem b : this.over) {
      if (b.hover()) {
        return b.toString();
      }
    }
    return null;
  }
}