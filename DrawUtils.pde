public class DrawUtils {
  private void gradient(int x, int y, float w, float h, color bg1, color bg2)
                        throws IllegalArgumentException{
    if (x < 0 || y < 0 || w < 0 || h < 0) {
      throw new IllegalArgumentException("Cannot get gradient from "
          + "negative parameters.");
    }
    noFill();
    for (int i = y; i <= y + h; i++) {
      float inter = map(i, y, y + h, 0, 1);
      color c = lerpColor(bg1, bg2, inter);
      stroke(c);
      line(x, i, x + w, i);
    }
  }
}