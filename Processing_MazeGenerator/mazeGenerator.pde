
class Maze {
  
    Cell[][] grid;
    boolean isGenerated;
    int cols, rows;
    
    Maze() {
      
      isGenerated = false;
      cols = floor(height / cell_size);
      rows = floor(width / cell_size);
      grid = new Cell[rows][cols];
      
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          grid[i][j] = new Cell(i, j);
        }
      }
    }
    
    void showGrid() {
    
        for (int i = 0; i< rows; i++) {
          for (int j = 0; j< cols; j++) {
            grid[i][j].show();
          }
        }
    }
    
    void generate() {
      
      println("Begin generation");
      
      ArrayList<Cell> stack = new ArrayList<Cell>();
      
      Cell current;
      Cell choosen;
      
      current = grid[0][0];
      current.visited = true;
      
      while(!isGenerated) {
        if (checkAllCell()) {
          choosen = getRandomNeighbourg(current.x, current.y);
          if (choosen != null) {//if the current cells have neighbourg that have not been visited
            stack.add(choosen);
            //remove the wall between the two cells
    
            if (choosen.x < current.x) {//left
              choosen.walls[RIGHT]=false;
              current.walls[LEFT]=false;
            } else if (choosen.x > current.x) {//right
              choosen.walls[LEFT]=false;
              current.walls[RIGHT]=false;
            } else if (choosen.y < current.y) {//top
              choosen.walls[BOTTOM]=false;
              current.walls[TOP]=false;
            } else if (choosen.y > current.y) {//top
              choosen.walls[TOP]=false;
              current.walls[BOTTOM]=false;
            }
    
            choosen.visited = true;
            current = choosen;
          } else if (stack.size()>0) {
            current = stack.get(stack.size()-1);
            stack.remove(stack.size()-1);
          }
        } else {
          for (int i = 0; i< rows; i++) {
            for (int j = 0; j< cols; j++) {
              grid[i][j].visited = false;
            }
          }
          println("Finished generation");
          isGenerated = true;
        }
      }
    }
    
    boolean checkAllCell() {
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          if (!grid[i][j].visited)
            return true;
          }
        }
      return false;
    }
    
    Cell getRandomNeighbourg(int x, int y) {
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