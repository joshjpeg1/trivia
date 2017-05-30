/**
 * Represents the model for a trivia game.
 */
public class TriviaModel {
  private int score;
  private TriviaView view;
  private Question[] questions;
  
  /**
   * Constructs a new {@code TriviaModel} object.
   *
   * @param fileName      the name of the JSON file of questions
   */
  public TriviaModel(String fileName) {
    if (fileName == null) {
      throw new IllegalArgumentException("Cannot read fileName");
    }
    this.view = new TriviaView();
    this.score = 0;
    initQuestions(fileName);
  }
  
  /**
   * Initializes the questions array to an array of {@code Question}
   * objects, containing information from the JSON file.
   *
   * @param fileName      the name of the JSON file of questions
   */
  private void initQuestions(String fileName) {
    JSONArray arr = loadJSONObject(fileName).getJSONArray("questions");
    this.questions = new Question[arr.size()];
    for (int i = 0; i < arr.size(); i++) {
      JSONObject obj = arr.getJSONObject(i);
      JSONArray a = obj.getJSONArray("answers");
      String[] answers = new String[a.size()];
      for (int j = 0; j < a.size(); j++) {
        answers[j] = a.getString(j);
      }
      this.questions[i] = new Question(i, obj.getString("question"),
          answers, obj.getInt("correct"));
    }
  }
  
  /**
   * Calls the view to display the current game state.
   */
  public void display() {
    this.view.display();
  }
}