
class Maze {
  
    Cell[][] grid;
    boolean isGenerated;
    int cols, rows;
    
    Maze() {
      
      cols = floor(height / cell_size);
      rows = floor(width / cell_size);
      
      grid = new Cell[rows][cols];
      
      reset();
    }
    
    void reset() {
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          grid[i][j] = new Cell(i, j);
        }
      }
      
      isGenerated = false;
    }
    
    void showGrid() {
      
      grid[0][0].cellColor = new CellColor(255, 0, 0, 255);
      grid[rows - 1][cols - 1].cellColor = new CellColor(0, 255, 0, 255);
    
        for (int i = 0; i< rows; i++) {
          for (int j = 0; j< cols; j++) {
            grid[i][j].show();
          }
        }
    }
    
    void resetColor() {
    
        for (int i = 0; i< rows; i++) {
          for (int j = 0; j< cols; j++) {
            grid[i][j].cellColor = null;
          }
        }
    }
    
    void generate_BackTraker() {
      
      println("Begin generation");
      
      reset();
      
      ArrayList<Cell> stack = new ArrayList<Cell>();
      
      Cell current;
      Cell choosen;
      
      current = grid[0][0];
      boolean[][] visitedCells = new boolean[rows][cols];
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          visitedCells[i][j] = false;
        }
      }
     
      visitedCells[current.x][current.y] = true;
      
      while(!isGenerated) {
        if (checkAllCell(visitedCells)) {
          choosen = getRandomNeighbourg(current.x, current.y, visitedCells);
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
    
            visitedCells[choosen.x][choosen.y] = true;
            current = choosen;
          } else if (stack.size()>0) {
            current = stack.get(stack.size()-1);
            stack.remove(stack.size()-1);
          }
        } else {
          println("Finished generation");
          isGenerated = true;
        }
      }
    }
    
    boolean checkAllCell(boolean[][] visitedCells) {
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          if (!visitedCells[i][j])
            return true;
          }
        }
      return false;
    }
    
    Cell getRandomNeighbourg(int x, int y, boolean[][] visitedCells) {
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
  
      for (Cell tmp : neighbourg) {
        if (tmp != null && !visitedCells[tmp.x][tmp.y]) {
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