public class AnswerButton extends Button {
  private final color hoverColor;
  private final color correctColor;
  private final color wrongColor;
  
  public AnswerButton(int x, int y, float w, float h, String text) {
    super(x, y, w, h, color(255), color(255), color(0), text, 40);
    this.hoverColor = color(#EDEDED);
    this.correctColor = color(#37CE8F);
    this.wrongColor = color(#EF7676);
  }
}