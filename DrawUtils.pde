/**
 * A utilities class for drawing functions.
 */
public final class DrawUtils {
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
  
  /**
   * Fits the given image to the desired dimensions.
   * 
   * @param img         the image to be fitted
   * @param maxWidth    the maximum width of the image
   * @param maxHeight   the maximum height of the image
   * @return the fitted image
   * @throws IllegalArgumentException if img is uninitialized, or if the
   * maxWidth or maxHeight are negative
   */
  public PImage fitImage(PImage img, int maxWidth, int maxHeight) throws IllegalArgumentException {
    if (img == null || maxWidth < 0 || maxHeight < 0) {
      throw new IllegalArgumentException("Cannot use uninitialized images or negative dimensions.");
    }
    int imgWidth = img.width;
    int imgHeight = img.height;
    // scales an image's height in order to fit the max width
    if (imgWidth > maxWidth && imgWidth > 0) {
      float scaleRatio = float(maxWidth) / float(imgWidth);
      imgWidth = maxWidth;
      imgHeight = int(imgHeight * scaleRatio);
    }
    // scales an image's width in order to fit the max height
    if (imgHeight > maxHeight && imgHeight > 0) {
      float scaleRatio = float(maxHeight) / float(imgHeight);
      imgHeight = maxHeight;
      imgWidth = int(imgWidth * scaleRatio);
    }
    // resizes the image to the new width and height
    img.resize(imgWidth, imgHeight);
    return img;
  }
  
  /**
   * Covers the given image over the desired dimensions.
   * 
   * @param img         the image to be covered
   * @param minWidth    the minimum width of the image
   * @param minHeight   the minimum height of the image
   * @return the covered image
   * @throws IllegalArgumentException if img is uninitialized, or if the
   * minWidth or minHeight are negative
   */
  public PImage coverImage(PImage img, int minWidth, int minHeight) throws IllegalArgumentException {
    img = fitImage(img, minWidth, minHeight);
    int imgWidth = img.width;
    int imgHeight = img.height;
    if (imgWidth < minWidth && imgWidth > 0) {
      float scaleRatio = float(minWidth) / float(imgWidth);
      imgWidth = minWidth;
      imgHeight = int(imgHeight * scaleRatio);
    }
    if (imgHeight < minHeight && imgHeight > 0) {
      float scaleRatio = float(minHeight) / float(imgHeight);
      imgHeight = minHeight;
      imgWidth = int(imgWidth * scaleRatio);
    }
    img.resize(imgWidth, imgHeight);
    return img;
  }
}