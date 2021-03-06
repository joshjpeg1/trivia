/**
 * Represents a question in a trivia game.
 */
public class Question {
  private final String category;
  private final int id;
  private final String question;
  private final Answer[] answers;
  private final PImage img;
  private final PImage revealImg;
  private final Gradient gradient;
  
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
  public Question(String category, int id, String question, String[] answers,
                  int answerIndex, String imgUrl, String revealUrl, 
                  Gradient gradient) throws IllegalArgumentException {
    if (category == null || question == null || imgUrl == null || revealUrl == null
        || Utils.arrIsOrContainsNull(answers) || gradient == null) {
      throw new IllegalArgumentException("Cannot pass uninitialized arguments.");
    }
    this.category = category;
    this.id = id;
    this.question = question;
    this.answers = new Answer[answers.length];
    for (int i = 0; i < answers.length; i++) {
      this.answers[i] = new Answer((this.id * 100) + i, answers[i], i == answerIndex);
    }
    this.img = loadImage(imgUrl);
    this.revealImg = loadImage(revealUrl);
    this.gradient = gradient;
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
    return this.question;
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
  
  /**
   * Gets the answers to this question.
   *
   * @return an array of the answers to this question
   */
  public Answer[] getAnswers() {
    return this.answers;
  }
  
  /**
   * Gets the gradient of this question.
   *
   * @return this question's gradient
   */
  public Gradient getGradient() {
    return this.gradient;
  }
  
  /**
   * Gets the image that goes along with this question.
   *
   * @return this question's image
   */
  public PImage getImage() {
    return this.img;
  }
  
  /**
   * Gets the image that appears after a question is answered.
   *
   * @return this question's reveal image
   */
  public PImage getRevealImage() {
    return this.revealImg;
  }
  
  /**
   * Gets the category this question is a part of.
   *
   * @return this question's category
   */
  public String getCategory() {
    return this.category;
  }
}