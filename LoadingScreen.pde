/**
 * Represents a loading screen to be used while the game is
 * parsing JSON data.
 */
public class LoadingScreen {
  private final PFont loadingFont;
  private int timer;
  private int dots;
  
  /**
   * Constructs a new {@code LoadingScreen} object.
   */
  LoadingScreen() {
    this.loadingFont = loadFont("bold.vlw");
    this.timer = millis();
    this.dots = 0;
  }
  
  /**
   * Displays the current state of the loading screen.
   */
  void display() {
    background(255);
    fill(0);
    textFont(loadingFont);
    textAlign(LEFT, BOTTOM);
    textSize(50);
    text(getLoadingText(), 50, height - 50);
    textSize(20);
    text(getSecondaryText(), 50, height - 105);
  }
  
  /**
   * Gets the "LOADING" text for the loading screen.
   * Adds dots to the end every 500ms to indicate
   * to the user the program is still running.
   */
  private String getLoadingText() {
    if (millis() - timer >= 500) {
      dots = (dots + 1) % 10;
      timer = millis();
    }
    String text = "LOADING";
    for (int i = 0; i < dots; i++) {
      text += ".";
    }
    return text;
  }
  
  /**
   * Gets the secondary text for the loading screen, that
   * lets the user know there are processes running.
   */
  private String getSecondaryText() {
    if (millis() > 40000) {
      return "Finishing up";
    } else if (millis() > 34000) {
      return "Back to checking answers";
    } else if (millis() > 30000) {
      return "Taking a quick water cooler break";
    } else if (millis() > 25000) {
      return "Double-checking answers";
    } else if (millis() > 15000) {
      return "Gathering questions";
    } else if (millis() > 8000) {
      return "Decoding computer speak";
    } else if (millis() > 1000){
      return "Dusting off systems";
    }
    return "";
  }
}