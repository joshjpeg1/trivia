/**
 * Represents a button with a basic hover state.
 */
public class Button {
  protected final int x;
  protected final int y;
  protected final float w;
  protected final float h;
  protected String text;
  protected String displayText;
  protected final int textSize;
  protected final color bg1;
  protected final color bg2;
  protected final color fill;
  protected final DrawUtils draw = new DrawUtils();
  
  /**
   * Constructs a {@code Button} object.
   *
   * @param x          the starting x-coordinate
   * @param y          the starting y-coordinate
   * @param w          the width of the button
   * @param h          the height of the button
   * @param bg1        the top color of the button gradient
   * @param bg2        the bottom color of the button gradient
   * @param fill       the fill color of the text
   * @param text       the (unformatted) text to be displayed in the button
   * @param textSize   the size of the text in the button
   * @throws IllegalArgumentException if the x, y, w, h, or textSize values are
   * negative or if the given text is uninitialized
   */
  public Button(int x, int y, float w, float h, color bg1, color bg2,
                color fill, String text, int textSize)
                throws IllegalArgumentException {
    if (x < 0 || y < 0 || w < 0 || h < 0 || textSize < 0 || text == null) {
      throw new IllegalArgumentException("Cannot pass negative or "
          + "uninitialized values.");
    }
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.textSize = textSize;
    this.text = text;
    this.displayText = this.draw.wrapText(this.text, (int) this.w, this.textSize);
    this.bg1 = bg1;
    this.bg2 = bg2;
    this.fill = fill;
  }
  
  @Override
  public String toString() {
    return text;
  }
  
  /**
   * Displays the button on the sketch.
   */
  public void display() {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    if (this.bg1 == this.bg2) {
      noStroke();
      fill(this.bg1);
      rect(this.x, this.y, this.w, this.h);
    } else {
      draw.gradient(this.x, this.y, this.w, this.h, this.bg1, this.bg2);
    }
    fill(fill);
    text(this.displayText, this.x + (this.w / 2), this.y + (this.h / 2));
  }
  
  /**
   * Checks if the mouse is hovering the button.
   *
   * @return true if the mouse is hovering, false otherwise
   */
  public boolean hover() {
    return (mouseX >= x && mouseX <= w + x)
        && (mouseY >= y && mouseY <= h + y);
  }
  
}