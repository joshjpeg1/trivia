/**
 * Represents a gradient.
 */
public final class Gradient {
  private final color top;
  private final color bot;
  
  /**
   * Constructs a new {@code Gradient} object.
   *
   * @param top    the top color
   * @param bot    the bottom color
   */
  public Gradient(color top, color bot) {
    this.top = top;
    this.bot = bot;
  }
  
  /**
   * Checks if the gradient is flat (one whole color).
   *
   * @return true if flat, false otherwise
   */
  public boolean flat() {
    return this.top == this.bot;
  }
  
  /**
   * Gets the top color of the gradient.
   *
   * @return the top color
   */
  public color getTop() {
    return this.top;
  }
  
  /**
   * Draws a gradient in the specified space.
   * 
   * @param x      the starting x-position
   * @param y      the starting y-position
   * @param w      the width of the gradient
   * @param h      the height of the gradient
   * @throws IllegalArgumentException if x, y, w, or h are negative
   */
  public void display(int x, int y, float w, float h)
                      throws IllegalArgumentException {
    if (x < 0 || y < 0 || w < 0 || h < 0) {
      throw new IllegalArgumentException("Cannot get gradient from "
          + "negative parameters.");
    }
    noFill();
    for (int i = y; i <= y + h; i++) {
      float inter = map(i, y, y + h, 0, 1);
      color c = lerpColor(this.top, this.bot, inter);
      stroke(c);
      line(x, i, x + w, i);
    }
  }
}