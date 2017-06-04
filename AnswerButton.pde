public class AnswerButton extends Button {
  private Answer answer;
  private final color hoverColor;
  private final color correctColor;
  private final color wrongColor;
  private ButtonState state;
  
  public AnswerButton(int x, int y, float w, float h, Answer answer)
                      throws IllegalArgumentException {
    super(x, y, w, h, color(255), color(255), color(0), "", 20);
    this.hoverColor = color(#EDEDED);
    this.correctColor = color(#37CE8F);
    this.wrongColor = color(#EF7676);
    this.init(answer);
  }
  
  public void init(Answer answer) {
    if (answer == null) {
      throw new IllegalArgumentException();
    }
    this.answer = answer;
    this.text = this.answer.toString();
    this.displayText = this.wrapText(this.text, (int) w);
    this.state = ButtonState.NONE;
  }
  
  @Override
  public void display() {
    textSize(textSize);
    textAlign(CENTER, CENTER);
    this.state = this.updateState();
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
  
  private ButtonState updateState() {
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