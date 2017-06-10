/**
 * Represents the different states that a game can be in.
 */
public enum GameState {
  MENU,               // Main menu
  WAIT_FOR_RELEASE,   // Waiting for user to release mouse button
  PLAYING,            // Answering a question
  REVEAL,             // True answer is revealed
  OVER;               // Game over
}