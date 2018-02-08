
class CellColor {
   int r, v, b, alpha;
   
   CellColor(int r, int v, int b) {
       this.r = r;
       this.v = v;
       this.b = b;
       this.alpha = 255;
   }
   
   CellColor(int r, int v, int b, int alpha) {
       this(r, v, b);
       this.alpha = alpha;
   }
}

int TOP =0, 
  BOTTOM=1, 
  LEFT=2, 
  RIGHT=3;

class Cell {
  int x;
  int y;

  CellColor cellColor;
  boolean[] walls = new boolean[4];


  Cell( int x, int y) {
    this.x = x;
    this.y = y;

    walls[TOP] = true;
    walls[BOTTOM] = true;
    walls[LEFT] = true;
    walls[RIGHT] = true;
    
    cellColor = null;
  }

  void show() {
    float i = x * cell_size;
    float j = y * cell_size;

    stroke(0);
    if (walls[TOP])
      line(i, j, i+cell_size, j);
    if (walls[BOTTOM])
      line(i, j+cell_size, i+cell_size, j+cell_size);
    if (walls[LEFT])
      line(i, j, i, j+cell_size);
    if (walls[RIGHT])
      line(i+cell_size, j, i+cell_size, j+cell_size);

    if (cellColor != null) {
      noStroke();
      fill(cellColor.r, cellColor.v, cellColor.b, cellColor.alpha);
      rect(i, j, cell_size, cell_size);
    }
  }
}