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
  
  public Button(int x, int y, float w, float h, color bg1, color bg2,
                color fill, String text, int textSize)
                throws IllegalArgumentException {
    if (x < 0 || y < 0 || w < 0 || h < 0 || textSize < 0 || text == null) {
      throw new IllegalArgumentException("Cannot pass null or uninitialized values.");
    }
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.textSize = textSize;
    this.text = text;
    this.displayText = this.wrapText(this.text, (int) w);
    this.bg1 = bg1;
    this.bg2 = bg2;
    this.fill = fill;
  }
  
  public void display() {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    if (this.bg1 == this.bg2) {
      noStroke();
      fill(this.bg1);
      rect(this.x, this.y, this.w, this.h);
    } else {
      drawGradient();
    }
    fill(fill);
    text(this.displayText, this.x + (this.w / 2), this.y + (this.h / 2));
  }
  
  private void drawGradient() {
    noFill();
    for (int i = this.y; i <= this.y + this.h; i++) {
      float inter = map(i, this.y, this.y + this.h, 0, 1);
      color c = lerpColor(this.bg1, this.bg2, inter);
      stroke(c);
      line(this.x, i, this.x + this.w, i);
    }
  }
  
  // wraps text within a given width by adding new lines
  // breaks only at spaces in sentences
  protected String wrapText(String str, int maxWidth) {
    textSize(this.textSize);
    maxWidth -= 20; // padding
    if (str.length() > 2) {
      while (textWidth(str) > maxWidth) {
        String wrappedLine = "";
        while (textWidth(str) > maxWidth || (str.length() > 0 && str.charAt(str.length() - 1) != ' ')) {
          wrappedLine = str.charAt(str.length() - 1) + wrappedLine;
          str = str.substring(0, str.length() - 1);
        }
        if (str.length() == 0) {
          return wrappedLine;
        }
        str += "\n" + wrappedLine;
      }
    }
    return str;
  }
  
  @Override
  public String toString() {
    return text;
  }
  
  public boolean hover() {
    return (mouseX >= x && mouseX <= w + x)
        && (mouseY >= y && mouseY <= h + y);
  }
  
}