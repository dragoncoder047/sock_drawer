Painter p = new Painter();
for (int i = 0; i < 99; i++) {
  while (p.isOnBucket()) p.takePaint();
  if (!p.isOnPaint() && p.getY() > -1) p.paint("magenta");
  if (!p.canMove()) {
    p.turnLeft();
    if (!p.canMove()) {
      p.turnLeft();
      p.turnLeft();
      if (!p.canMove()) p.turnLeft();
    }
    if (!p.canMove()) {
      p.turnLeft();
      p.turnLeft();
    }
  }
  p.move();
}
