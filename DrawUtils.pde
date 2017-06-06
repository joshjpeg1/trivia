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
  
  // fits an image to the desired dimensions
  public PImage fitImage(PImage img, int maxWidth, int maxHeight) {
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
  
  // fits an image to the desired dimensions
  public PImage coverImage(PImage img, int desWidth, int desHeight) {
    img = fitImage(img, desWidth, desHeight);
    int imgWidth = img.width;
    int imgHeight = img.height;
    if (imgWidth < desWidth && imgWidth > 0) {
      float scaleRatio = float(desWidth) / float(imgWidth);
      imgWidth = desWidth;
      imgHeight = int(imgHeight * scaleRatio);
    }
    if (imgHeight < desHeight && imgHeight > 0) {
      float scaleRatio = float(desHeight) / float(imgHeight);
      imgHeight = desHeight;
      imgWidth = int(imgWidth * scaleRatio);
    }
    img.resize(imgWidth, imgHeight);
    return img;
  }
}