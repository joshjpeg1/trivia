/**
 * Represents the controller for a trivia game.
 */
public class TriviaController {
  private TriviaModel model;
  
  /**
   * Constructs a new {@code TriviaController} object.
   *
   * @param fileName      the name of the JSON file of questions
   */
  public TriviaController(String fileName) {
    this.model = new TriviaModel(fileName);
  }
  
  /**
   * Calls the model to display the current game state.
   */
  public void display() {
    this.model.display();
  }
  
  /**
   * Handles a mouse press when the program is running.
   */
  public void mouseHandler() {
    model.update();
  }
}