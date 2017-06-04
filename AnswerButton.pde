/**
 * Represents a button for an answer to a trivia question.
 */
public class AnswerButton extends Button {
  private Answer answer;
  private final color hoverColor;
  private final color correctColor;
  private final color wrongColor;
  private ButtonState state;
  
  /**
   * Constructs a {@code AnswerButton} object.
   *
   * @param x         the starting x-coordinate
   * @param y         the starting y-coordinate
   * @param w         the width of the button
   * @param h         the height of the button
   * @param answer    the answer the button represents
   * @throws IllegalArgumentException if the given answer is uninitialized
   */
  public AnswerButton(int x, int y, float w, float h, Answer answer)
                      throws IllegalArgumentException {
    super(x, y, w, h, color(255), color(255), color(0), "", 20);
    this.hoverColor = color(#EDEDED);
    this.correctColor = color(#37CE8F);
    this.wrongColor = color(#EF7676);
    if (answer == null) {
      throw new IllegalArgumentException();
    }
    this.answer = answer;
    this.text = this.answer.toString();
    this.displayText = this.draw.wrapText(this.text, (int) this.w, this.textSize);
    this.state = ButtonState.NONE;
  }
  
  @Override
  public void display() {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    this.state = this.getState();
    switch (this.state) {
      case HOVER:
        fill(this.hoverColor);
        break;
      case CORRECT:
        fill(this.correctColor);
        break;
      case WRONG:
        fill(this.wrongColor);
        break;
      default:
        stroke(this.hoverColor);
        fill(this.bg1);
    }
    rect(this.x, this.y, this.w, this.h);
    if (this.state.equals(ButtonState.CORRECT)
        || this.state.equals(ButtonState.WRONG)) {
      fill(255);
    } else {
      fill(fill);
    }
    noStroke();
    text(this.displayText, this.x + (this.w / 2), this.y + (this.h / 2));
  }
  
  /**
   * Gets the current state of the button.
   *
   * @return the current state of the button
   */
  private ButtonState getState() {
    if (this.state.equals(ButtonState.CORRECT)
        || this.state.equals(ButtonState.WRONG)) {
      return this.state;
    }
    if (this.hover()) {
      if (mousePressed) {
        return ((answer.isCorrect()) ? ButtonState.CORRECT : ButtonState.WRONG);
      }
      return ButtonState.HOVER;
    }
    return ButtonState.NONE;
  }
  
  
  
}