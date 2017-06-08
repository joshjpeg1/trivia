/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Trivia
 * @description  A trivia game.
 * @version      0.1
 */

private TriviaModel model;

/**
 * Sets up the program.
 */
void setup() {
  size(1000, 600);
  model = new TriviaModel("questions.json");
}

/**
 * Draws the current state of the game.
 */
void draw() {
  model.display();
}

/**
 * Handles a mouse press when the program is running.
 */
void mousePressed() {
  model.update();
}

/**
 * Handles a mouse drag (press and move) when the program is running.
 */
void mouseDragged() {
  model.update();
}