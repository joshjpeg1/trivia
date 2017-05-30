/**
 * Represents the model for a trivia game.
 */
public class TriviaModel {
  private int score;
  private TriviaView view;
  
  /**
   * Constructs a new {@code TriviaModel} object.
   */
  public TriviaModel() {
    this.view = new TriviaView();
    this.score = 0;
  }
  
  /**
   * Calls the view to display the current game state.
   */
  public void display() {
    this.view.display();
  }
}