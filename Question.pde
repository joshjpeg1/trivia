/**
 * Represents a question in a trivia game.
 */
public class Question {
  private final int id;
  private final String question;
  private final String[] answers;
  private final int answerIndex;
  
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
                  int answerIndex) throws IllegalArgumentException {
    if (question == null || answers == null) {
      throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
    }
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == null) {
        throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
      }
    }
    this.id = id;
    this.question = question;
    this.answers = answers;
    this.answerIndex = answerIndex;
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    } else if (!(o instanceof Question)) {
      return false;
    }
    Question that = (Question) o;
    if (this.answers.length != that.answers.length) {
      return false;
    }
    for (int i = 0; i < answers.length; i++) {
      if (!this.answers[i].contains(that.answers[i])) {
        return false;
      }
    }
    return this.id == that.id
        && this.question.equals(that.question)
        && this.answerIndex == that.answerIndex;
  }
  
  @Override
  public int hashCode() {
    return this.id;
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