/**
 * A utilities class for drawing functions.
 */
public final class DrawUtils {
  /**
   * Draws a gradient in the specified space using the given colors.
   * 
   * @param x      the starting x-position
   * @param y      the starting y-position
   * @param w      the width of the gradient
   * @param h      the height of the gradient
   * @param top    the top color
   * @param bot    the bottom color
   * @throws IllegalArgumentException if x, y, w, or h are negative
   */
  public void gradient(int x, int y, float w, float h, color top, color bot)
                       throws IllegalArgumentException {
    if (x < 0 || y < 0 || w < 0 || h < 0) {
      throw new IllegalArgumentException("Cannot get gradient from "
          + "negative parameters.");
    }
    noFill();
    for (int i = y; i <= y + h; i++) {
      float inter = map(i, y, y + h, 0, 1);
      color c = lerpColor(top, bot, inter);
      stroke(c);
      line(x, i, x + w, i);
    }
  }
  
  /**
   * Draws a gradient in the specified space using the given colors.
   * 
   * @param str         the string to be wrapped
   * @param maxWidth    the max width of the new string
   * @param textSize    the width at which the text will be displayed
   * @return the wrapped string
   * @throws IllegalArgumentException if str is uninitialized, or if the
   * maxWidth or textSize are negative
   */
  public String wrapText(String str, int maxWidth, int textSize)
                        throws IllegalArgumentException {
    if (str == null) {
      throw new IllegalArgumentException("Cannot wrap uninitialized text.");
    } else if (maxWidth < 0 || textSize < 0) {
      throw new IllegalArgumentException("Cannot wrap from negative parameters.");
    }
    textSize(textSize);
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
}