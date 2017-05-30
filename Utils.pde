/**
 * A utilities class for static functions.
 */
public static final class Utils {
  /**
   * Checks if a given array is or contains uninitialized values.
   *
   * @param arr    the array to check
   * @return true if the array is or contains null, false otherwise
   */
  public static <K> boolean arrIsOrContainsNull(K[] arr) {
    if (arr == null) {
      return true;
    }
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] == null) {
        return true;
      }
    }
    return false;
  }
  
  /**
   * Constructs a string representation of an array.
   *
   * @param arr    the array to be represented
   * @return a string representation of the given array, or
   *         an empty string if the array is or contains null
   */
  public static <K> String arrToString(K[] arr) {
    String str = "";
    if (!arrIsOrContainsNull(arr)) {
      for (int i = 0; i < arr.length; i++) {
        str += arr[i].toString();
        if (i < arr.length - 1) {
          str += "\n";
        }
      }
    }
    return str;
  }
}