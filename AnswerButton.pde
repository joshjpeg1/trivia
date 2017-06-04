public class AnswerButton extends Button {
  private Answer answer;
  private final color hoverColor;
  private final color correctColor;
  private final color wrongColor;
  private ButtonState state;
  
  public AnswerButton(int x, int y, float w, float h, Answer answer) {
    super(x, y, w, h, color(255), color(255), color(0), answer.toString(), 20);
    this.hoverColor = color(#EDEDED);
    this.correctColor = color(#37CE8F);
    this.wrongColor = color(#EF7676);
    this.answer = answer;
    this.state = ButtonState.NONE;
  }
  
  public void reset(Answer answer) {
    if (answer == null) {
      throw new IllegalArgumentException();
    }
    this.answer = answer;
    this.text = this.wrapText(text, (int) w);
    this.state = ButtonState.NONE;
  }
  
  @Override
  public void display() {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    this.state = checkState();
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
    text(text, this.x + (this.w / 2), this.y + (this.h / 2));
  }
  
  private ButtonState checkState() {
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