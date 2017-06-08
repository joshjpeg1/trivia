/**
 * Represents a button with a basic hover state.
 */
public class ScreenElem {
  protected final int x;
  protected final int y;
  protected final float w;
  protected final float h;
  protected String text;
  protected String displayText;
  protected final int textSize;
  protected final Gradient bg;
  protected final color fill;
  protected final DrawUtils draw = new DrawUtils();
  
  /**
   * Constructs a {@code Button} object.
   *
   * @param x          the starting x-coordinate
   * @param y          the starting y-coordinate
   * @param w          the width of the button
   * @param h          the height of the button
   * @param bg         the background gradient of the button
   * @param fill       the fill color of the text
   * @param text       the (unformatted) text to be displayed in the button
   * @param textSize   the size of the text in the button
   * @throws IllegalArgumentException if the x, y, w, h, or textSize values are
   * negative or if the given text is uninitialized
   */
  public ScreenElem(int x, int y, float w, float h, Gradient bg,
                color fill, String text, int textSize)
                throws IllegalArgumentException {
    if (x < 0 || y < 0 || w < 0 || h < 0 || bg == null || textSize < 0 || text == null) {
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
    this.bg = bg;
    this.fill = fill;
  }
  
  @Override
  public String toString() {
    return text;
  }
  
  /**
   * Displays the button on the sketch.
   */
  public void display(boolean noHover, boolean reveal) {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    if (this.bg.flat()) {
      noStroke();
      fill(this.bg.getTop());
      rect(this.x, this.y, this.w, this.h);
    } else {
      this.bg.display(this.x, this.y, this.w, this.h);
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
    int padX = (this.w > 100) ? ((int) this.w / 20) : 0;
    int padY = (this.h > 100) ? ((int) this.h / 20) : 0;
    return (mouseX >= (x + padX) && mouseX <= (w + x - padX))
        && (mouseY >= (y + padY) && mouseY <= (h + y - padY));
  }
  
}