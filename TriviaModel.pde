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
    this.gameState = /*GameState.PLAYING;*/GameState.MENU;
    JSONArray categ = loadJSONArray(fileName);
    this.categories = new ArrayList<JSONObject>();
    for (int i = 0; i < categ.size(); i++) {
      this.categories.add(categ.getJSONObject(i));
    }
    this.view = new TriviaView(this.categories);
  }
  
  /**
   * Initializes the questions array to an array of {@code Question}
   * objects, containing information from the JSON file.
   *
   * @param fileName      the name of the JSON file of questions
   */
  private void initQuestions(String category) {
    JSONArray arr = null;
    for (JSONObject o : this.categories) {
      if (o.getString("title").equals(category)) {
        arr = o.getJSONArray("questions");
      }
    }
    if (arr != null) {
      this.questions = new Question[arr.size()];
      for (int i = 0; i < arr.size(); i++) {
        JSONObject obj = arr.getJSONObject(i);
        JSONArray a = obj.getJSONArray("answers");
        String[] answers = new String[a.size()];
        for (int j = 0; j < a.size(); j++) {
          answers[j] = a.getString(j);
        }
        this.questions[i] = new Question(i, obj.getString("question"),
            answers, obj.getInt("correct"), obj.getString("image"));
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
    this.view.display(this.gameState);
  }
  
  public void update() {
    switch (gameState) {
      case MENU:
        startGame(view.getCategory());
        break;
      default:
        break;
    }
  }
  
  private void startGame(String category) {
    if (category != null) {
      if (category.equals("Exit")) {
        System.exit(0);
      } else {
        System.out.println(category);
        initQuestions(category);
      }
    }
  }
}