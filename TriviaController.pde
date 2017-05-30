/**
 * Represents the controller for a trivia game.
 */
public class TriviaController {
  private TriviaModel model;
  
  /**
   * Constructs a new {@code TriviaController} object.
   */
  public TriviaController() {
    this.model = new TriviaModel();
  }
  
  /**
   * Calls the model to display the current game state.
   */
  public void display() {
    this.model.display();
  }
  
  /**
   * Handles a key press when the program is running.
   */
  public void keyHandler() {
    return;
  }
  
  /**
   * Handles a mouse press when the program is running.
   */
  public void mouseHandler() {
    return;
  }
}