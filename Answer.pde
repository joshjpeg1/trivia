/**
 * Represents an answer in a trivia game.
 */
public class Answer {
  private final int id;
  private final String answer;
  private final boolean correct;
  
  /**
   * Constructs a new {@code Question} object.
   *
   * @param id           unique identifier for answer
   * @param answer       the answer itself
   * @param correct      true if the answer is correct, false otherwise
   * @throws IllegalArgumentException if the given answer is null
   */
  public Answer(int id, String answer, boolean correct) throws IllegalArgumentException {
    if (answer == null) {
      throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
    }
    this.id = id;
    this.answer = answer;
    this.correct = correct;
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    } else if (!(o instanceof Answer)) {
      return false;
    }
    Answer that = (Answer) o;
    return this.id == that.id
      && this.answer.equals(that.answer)
      && this.correct == that.correct;
  }
  
  @Override
  public int hashCode() {
    return id;
  }
  
  @Override
  public String toString() {
    return this.answer;
  }
  
  /**
   * Checks if this answer is correct.
   *
   * @return true if correct, false otherwise
   */
  public boolean isCorrect() {
    return this.correct;
  }
}