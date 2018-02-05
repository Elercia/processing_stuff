
int TOP =0, 
  BOTTOM=1, 
  LEFT=2, 
  RIGHT=3;


class Cell {
  int x;
  int y;

  boolean visited = false;
  boolean[] walls = new boolean[4];


  Cell( int x, int y) {
    this.x = x;
    this.y = y;

    walls[TOP] = true;
    walls[BOTTOM] = true;
    walls[LEFT] = true;
    walls[RIGHT] = true;
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

    if (visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(i, j, cell_size, cell_size);
    }
  }

  Cell getRandomNeighbourg() {
    Cell[] neighbourg = new Cell[4];

    try {
      neighbourg[TOP] = grid[x][y-1];
    }
    catch(Exception e) {
      neighbourg[TOP] = null;
    }
    try {
      neighbourg[RIGHT] = grid[x+1][y];
    }
    catch(Exception e) {
      neighbourg[RIGHT] = null;
    }
    try {
      neighbourg[LEFT] = grid[x-1][y];
    }
    catch(Exception e) {
      neighbourg[LEFT] = null;
    }
    try {
      neighbourg[BOTTOM] = grid[x][y+1];
    }
    catch(Exception e) {
      neighbourg[BOTTOM] = null;
    }

    boolean found = false;
    ArrayList<Cell> ret = new ArrayList<Cell>();

    for (Cell tmp : neighbourg)
    {
      if (tmp != null && !tmp.visited) {
        ret.add(tmp);
        found = true;
      }
    }

    if (!found) {
      return null;
    } else {
      return ret.get(floor(random(0, ret.size())));
    }
  }
}