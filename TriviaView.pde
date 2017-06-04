import java.util.Arrays;
/**
 * Represents the view for a trivia game.
 */
public class TriviaView {
  private final PFont bold = loadFont("bold.vlw");
  private final color white = color(255);
  private final color black = color(0);
  
  private final ArrayList<Button> menu;
  private ArrayList<AnswerButton> playing;
  
  public TriviaView() {
    // MENU
    int w = 340; //width
    int h = 170; //height
    int p = 40; //padding
    menu = new ArrayList(Arrays.asList(new Button(130, 140, w, h, color(#9655FF), color(#568FEB), white, "Movie Quotes", 40),
           new Button(130 + w + p, 140, w, h, color(#5596FF), color(#37EDDF), white, "Name That\nPokémon", 40),
           new Button(130, 140 + h + p, w, h, color(#F55A8F), color(#EAB34C), white, "State Capitals", 40),
           new Button(130 + w + p, 140 + h + p, w, h, color(#2EF0A6), color(#B4EF79), white, "Harry Potter", 40),
           new Button(width - 50, 20, 30, 20, white, white, color(#656565), "Exit", 20)));
   // PLAYING
   playing = new ArrayList<AnswerButton>();
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
  
  private void displayMenu() {
    textFont(bold);
    textSize(60);
    textAlign(LEFT, BOTTOM);
    fill(black);
    text("Trivia", 130, 120);
    boolean hovering = false;
    for (Button b : menu) {
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
  
  private void displayPlaying() {
    return;
  }
  
  private void displayOver() {
    return;
  }
}