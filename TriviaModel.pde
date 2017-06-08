/**
 * Represents the model for a trivia game.
 */
public class TriviaModel {
  private int score;
  private TriviaView view;
  private Question[] questions;
  private GameState gameState;
  private ArrayList<JSONObject> categories;
  private int currentQuestion = 0;
  private int timer;
  private static final int REVEAL_WAIT = 1000;
  
  /**
   * Constructs a new {@code TriviaModel} object.
   *
   * @param fileName      the name of the JSON file of questions
   */
  public TriviaModel(String fileName) {
    if (fileName == null) {
      throw new IllegalArgumentException("Cannot read fileName");
    }
    
    this.score = 0;
    this.gameState = GameState.MENU;
    JSONArray categ = loadJSONArray(fileName);
    this.categories = new ArrayList<JSONObject>();
    for (int i = 0; i < categ.size(); i++) {
      this.categories.add(categ.getJSONObject(i));
    }
    this.view = new TriviaView(this.categories);
    this.timer = 0;
  }
  
  /**
   * Initializes the questions array to an array of {@code Question}
   * objects, containing information from the JSON file.
   *
   * @param fileName      the name of the JSON file of questions
   */
  private void initQuestions(String category) {
    JSONArray arr = null;
    JSONArray topGrad = null;
    JSONArray botGrad = null;
    for (JSONObject o : this.categories) {
      if (o.getString("title").equals(category)) {
        arr = o.getJSONArray("questions");
        topGrad = o.getJSONObject("gradient").getJSONArray("top");
        botGrad = o.getJSONObject("gradient").getJSONArray("bot");
      }
    }
    if (arr != null) {
      Gradient gradient = new Gradient(color(topGrad.getInt(0), 
          topGrad.getInt(1), topGrad.getInt(2)),
          color(botGrad.getInt(0), botGrad.getInt(1), botGrad.getInt(2)));
      this.questions = new Question[arr.size()];
      for (int i = 0; i < arr.size(); i++) {
        JSONObject obj = arr.getJSONObject(i);
        JSONArray a = obj.getJSONArray("answers");
        String[] answers = new String[a.size()];
        for (int j = 0; j < a.size(); j++) {
          answers[j] = a.getString(j);
        }
        System.out.println(obj);
        this.questions[i] = new Question(i, obj.getString("question"),
            answers, obj.getInt("correct"), obj.getString("image"),
            obj.getString("reveal"), gradient);
      }
      this.gameState = GameState.PLAYING;
      this.currentQuestion = 1;
      this.view.nextQuestion(this.questions[currentQuestion - 1]);
    }
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
    }
  }
  
  public void update() {
    switch (gameState) {
      case MENU:
        menuUpdate(view.getCategory());
        break;
      case PLAYING:
        playingUpdate();
        break;
      default:
        break;
    }
  }
  
  /**
   * Helper to the update method. If a category is clicked, the model
   * will start the game with that category's questions. If the exit
   * button is clicked, the game will exit.
   */
  private void menuUpdate(String category) {
    if (category != null) {
      if (category.equals("Exit")) {
        System.exit(0);
      } else {
        System.out.println(category);
        initQuestions(category);
      }
    }
  }
  
  /**
   * Helper to the update method. Advances to the next question after
   * an answer was chosen for the current question.
   */
  private void playingUpdate() {
    this.display();
    Answer ans = this.view.answerChosen();
    if (ans != null) {
      if (ans.isCorrect()) {
        this.score++;
      }
      this.gameState = GameState.REVEAL;
      this.timer = millis();
    }
  }
  
  private void nextQuestion() {
    if (currentQuestion == this.questions.length) {
      this.gameState = GameState.OVER;
      return;
    }
    this.gameState = GameState.PLAYING;
    this.timer = 0;
    this.currentQuestion++;
    this.view.nextQuestion(this.questions[currentQuestion - 1]);
  }
}