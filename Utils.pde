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
}