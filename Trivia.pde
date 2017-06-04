/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Trivia
 * @description  A trivia game.
 * @version      0.1
 */

private TriviaController controller;

/**
 * Sets up the program.
 * To change the questions asked, simply change the file name string
 * passed to the controller.
 */
void setup() {
  size(1000, 600);
  controller = new TriviaController("moviequotes.json");
}

/**
 * Draws the current state of the game.
 */
void draw() {
  controller.display();
}

/**
 * Handles a key pressed when the program is running.
 */
void keyPressed() {
  controller.keyHandler();
}

/**
 * Handles a mouse press when the program is running.
 */
void mousePressed() {
  controller.mouseHandler();
}