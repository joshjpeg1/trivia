public class Button {
  private final int x;
  private final int y;
  private final float w;
  private final float h;
  private final String text;
  private final int textSize;
  private final color bg1;
  private final color bg2;
  private final color fill;
  
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
    this.text = text;
    this.textSize = textSize;
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
    text(text, this.x + (this.w / 2), this.y + (this.h / 2));
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
  
  @Override
  public String toString() {
    return text;
  }
  
  public boolean hover() {
    return (mouseX >= x && mouseX <= w + x)
        && (mouseY >= y && mouseY <= h + y);
  }
  
}