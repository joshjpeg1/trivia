import java.util.Map;
import java.util.List;

/**
 * Represents the model for a trivia game.
 */
public class TriviaModel {
  private int score;
  private TriviaView view;
  private Question[] questions;
  private GameState gameState;
  private Map<String, Question[]> categories;
  private int currentQuestion = 0;
  private int timer;
  private static final int REVEAL_WAIT = 2000;
  
  /**
   * Constructs a new {@code TriviaModel} object.
   *
   * @param fileName      the name of the JSON file of questions
   * @throws IllegalArgumentException if the given file name is uninitialized,
   * does not point to a JSON file, or if the JSON file is formatted incorrectly
   */
  public TriviaModel(String fileName) throws IllegalArgumentException {
    if (fileName == null) {
      throw new IllegalArgumentException("Cannot read file name");
    }
    this.categories = new HashMap<String, Question[]>();
    this.score = 0;
    this.gameState = GameState.MENU;
    JSONArray allCateg = loadJSONArray(fileName);
    for (int i = 0; i < allCateg.size(); i++) {
      JSONObject question = allCateg.getJSONObject(i);
      String title = question.getString("title");
      Question[] categQuestions;
      categQuestions = initQuestions(question);
      this.categories.put(title, categQuestions);
    }
    this.view = new TriviaView(this.categories);
    this.timer = 0;
  }
  
  /**
   * Creates an array of Question objects using the given JSON data
   * about a category.
   *
   * @param category   a category of trivia retrieved from a JSON file
   * @return an array of Question objects with data from the given JSON object
   * @throws IllegalArgumentException if the given JSON object is formatted
   * incorrectly
   */
  private Question[] initQuestions(JSONObject category)
      throws IllegalArgumentException {
    JSONArray arr = null;
    JSONArray topGrad = null;
    JSONArray botGrad = null;
    Question[] categQuestions;
    arr = category.getJSONArray("questions");
    topGrad = category.getJSONObject("gradient").getJSONArray("top");
    botGrad = category.getJSONObject("gradient").getJSONArray("bot");
    if (arr == null || topGrad == null || botGrad == null) {
      throw new IllegalArgumentException("Invalid JSON Data.");
    }
    Gradient gradient = new Gradient(color(topGrad.getInt(0), 
        topGrad.getInt(1), topGrad.getInt(2)),
        color(botGrad.getInt(0), botGrad.getInt(1), botGrad.getInt(2)));
    categQuestions = new Question[arr.size()];
    for (int i = 0; i < arr.size(); i++) {
      JSONObject obj = arr.getJSONObject(i);
      JSONArray a = obj.getJSONArray("answers");
      String[] answers = new String[a.size()];
      for (int j = 0; j < a.size(); j++) {
        answers[j] = a.getString(j);
      }
      categQuestions[i] = new Question(i, obj.getString("question"),
          answers, obj.getInt("correct"), obj.getString("image"),
          obj.getString("reveal"), gradient);
    }
    return categQuestions;
  }
  
  /**
   * Calls the view to display the current game state.
   */
  public void display() {
    this.view.display(this.gameState, this.score, this.currentQuestion);
    if (this.gameState.equals(GameState.REVEAL)) {
      if (millis() - this.timer >= REVEAL_WAIT) {
        this.nextQuestion();
      }
    } else if (this.gameState.equals(GameState.WAIT_FOR_RELEASE)) {
      if (!mousePressed) {
        this.gameState = GameState.PLAYING;
      }
    }
  }
  
  /**
   * Updates the screen if a mouse has been pressed, based on
   * the current game state.
   */
  public void update() {
    switch (gameState) {
      case MENU:
        this.menuUpdate(view.getCategory());
        break;
      case PLAYING:
        this.playingUpdate();
        break;
      case OVER:
        this.overUpdate(view.getOverAction());
        break;
      default:
        break;
    }
  }
  
  /**
   * Helper to the update method. If a category is clicked, the model
   * will start the game with that category's questions. If the exit
   * button is clicked, the game will exit.
   *
   * @param category   the String representation of the category pressed
   */
  private void menuUpdate(String category) {
    if (category != null) {
      if (category.equals("Exit")) {
        System.exit(0);
      } else {
        this.questions = this.categories.get(category);
        this.currentQuestion = 0;
        this.nextQuestion();
      }
    }
  }
  
  /**
   * Helper to the update method. Updates the playing screen and game
   * state to reveal the answer if an answer was chosen.
   */
  private void playingUpdate() {
    if (this.timer == 0) {
      this.display();
      Answer ans = this.view.answerChosen();
      if (ans != null) {
        this.score += Utils.boolToInt(ans.isCorrect());
        this.gameState = GameState.REVEAL;
        this.timer = millis();
      }
    }
  }
  
  /**
   * Helper to the update method. If the menu button was pressed,
   * returns the user to the main menu. If the replay button was pressed,
   * restarts the game.
   *
   * @param action   the String representation of the action pressed
   */
  private void overUpdate(String action) {
    if (action != null) {
      if (action.equals("Menu")) {
        this.gameState = GameState.MENU;
      } else if (action.equals("Replay")) {
        this.currentQuestion = 0;
        this.score = 0;
        this.nextQuestion();
      }
    }
  }
  
  /**
   * Advances to the next question after an answer was chosen
   * for the current question.
   * If there are no more questions, changes game state to game over.
   */
  private void nextQuestion() {
    if (currentQuestion == this.questions.length) {
      this.gameState = GameState.OVER;
      return;
    }
    this.gameState = GameState.WAIT_FOR_RELEASE;
    this.timer = 0;
    this.currentQuestion++;
    this.view.nextQuestion(this.questions[currentQuestion - 1]);
  }
}