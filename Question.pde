/**
 * Represents a question in a trivia game.
 */
public class Question {
  private final int id;
  private final String question;
  private final Answer[] answers;
  private final PImage img;
  
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
    if (question == null || imgUrl == null || Utils.arrIsOrContainsNull(answers)) {
      throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
    }
    this.id = id;
    this.question = question;
    this.answers = new Answer[answers.length];
    for (int i = 0; i < answers.length; i++) {
      this.answers[i] = new Answer((this.id * 100) + i, answers[i], i == answerIndex);
    }
    this.img = loadImage(imgUrl);
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    } else if (!(o instanceof Question)) {
      return false;
    }
    return this.id == ((Question) o).id
      && this.question == ((Question) o).question;
  }
  
  @Override
  public int hashCode() {
    return this.id;
  }
  
  @Override
  public String toString() {
    String str = this.id + "\n" + this.question + "\n";
    str += Utils.arrToString(this.answers) + "\n";
    return str;
  }
  
  /**
   * Returns true if the given index is the same as the correct answer's index.
   *
   * @param chosenIndex     the index chosen by the user
   * @return true if the indices match, false otherwise (or if index is too large/small)
   */
  public boolean correctChoice(int chosenIndex) {
    try {
      return this.answers[chosenIndex].isCorrect();
    } catch (IndexOutOfBoundsException e) {
      return false;
    }
  }
  
  public Answer[] getAnswers() {
    return this.answers;
  }
}