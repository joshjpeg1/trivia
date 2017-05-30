/**
 * Represents a question in a trivia game.
 */
public class Question {
  private final int id;
  private final String question;
  private final String[] answers;
  private final int answerIndex;
  private PImage img;
  
  /**
   * Constructs a new {@code Question} object.
   *
   * @param id             unique identifier for question
   * @param question       the question being asked
   * @param answers        all answers to the question
   * @param answerIndex    the index of the correct answer
   * @throws IllegalArgumentException if the question or answers array are null,
   *         or if the answers array contains a null
   */
  public Question(int id, String question, String[] answers,
                  int answerIndex, String imgUrl) throws IllegalArgumentException {
    if (question == null || imgUrl == null) {
      throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
    }
    if (Utils.arrIsOrContainsNull(answers)) {
      throw new IllegalArgumentException("Answers array contains uninitialized arguments.");
    }
    this.id = id;
    this.question = question;
    this.answers = answers;
    this.answerIndex = answerIndex;
    this.img = loadImage(imgUrl);
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    } else if (!(o instanceof Question)) {
      return false;
    }
    return this.id == ((Question) o).id;
  }
  
  @Override
  public int hashCode() {
    return this.id;
  }
  
  @Override
  public String toString() {
    String str = this.id + "\n" + this.question + "\n";
    for (int i = 0; i < this.answers.length; i++) {
      str += (i + 1) + ((i == answerIndex) ? " (CORRECT)" : "")
          + ": " + this.answers[i] + "\n";
    }
    return str;
  }
  
  /**
   * Returns true if the given index is the same as the correct answer's index.
   *
   * @param chosenIndex     the index chosen by the user
   * @return true if the indices match, false otherwise
   */
  public boolean correctChoice(int chosenIndex) {
    return this.answerIndex == chosenIndex;
  }
}