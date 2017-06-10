/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Trivia
 * @description  A trivia game.
 * @version      1.0
 */

private TriviaModel model;
private boolean loading;
private LoadingScreen loadingScreen;

/**
 * Sets up the program.
 * Starts parsing the JSON data in a separate thread.
 */
void setup() {
  size(1000, 600);
  loading = true;
  loadingScreen = new LoadingScreen();
  Thread parseJson = new Thread(new Runnable() {
    public void run() {
      model = new TriviaModel("questions.json");
      loading = false;
    }
  });
  parseJson.setDaemon(true);
  parseJson.start();
}

/**
 * Draws the current state of the game.
 * If JSON data is still being parsed, the loading
 * screen is displayed instead.
 */
void draw() {
  if (!loading) {
    model.display();
  } else {
    loadingScreen.display();
  }
}

/**
 * Handles a mouse press when the program is running.
 */
void mousePressed() {
  if (!loading) {
    model.update();
  }
}

/**
 * Handles a mouse drag (press and move) when the program is running.
 */
void mouseDragged() {
  if (!loading) {
    model.update();
  }
}