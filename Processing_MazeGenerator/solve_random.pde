
void random_solve(Maze maze) {
  
  ArrayList<Cell> path =  new ArrayList<Cell>();
  
  boolean[][] visitedCells = new boolean[maze.rows][maze.cols];
  
  for (int i = 0; i< maze.rows; i++) {
    for (int j = 0; j< maze.cols; j++) {
      visitedCells[i][j] = false;
    }
  }
  
  Cell current = maze.grid[0][0];
  final Cell dest = maze.grid[maze.rows - 1][maze.cols - 1];
  
  path.add(current);
  visitedCells[current.x][current.y] = true;
  
  while (current != dest) {
    
    current = getRandomCell(current.x, current.y, maze, visitedCells);
    
    if(current == null) {
      if(path.size() == 0) {
          print("Random solve impossible\n");
          return;
      }
      current = path.get(path.size()-1);
      path.remove(path.size()-1);
    } else {
      path.add(current);
      visitedCells[current.x][current.y] = true;
    }
  }
  
  print("Random solve done\n"); //<>//
  
  for(Cell cell : path) {
     cell.cellColor = new CellColor(0, 255, 255, 100); 
     cell.show();
  }
}

Cell getRandomCell(int x, int y, Maze maze, boolean[][] visitedCells) {
  
  Cell[] neighbourg = new Cell[4];
  neighbourg[TOP] = null;
  neighbourg[RIGHT] = null;
  neighbourg[LEFT] = null;
  neighbourg[BOTTOM] = null;
  
  Cell current = maze.grid[x][y];
  
  try {
    if(!current.walls[TOP]) {
      neighbourg[TOP] = maze.grid[x][y-1];
    }
  }
  catch(Exception e) {
    neighbourg[TOP] = null;
  }
  try {
    if(!current.walls[RIGHT]) {
      neighbourg[RIGHT] = maze.grid[x+1][y];
    }
  }
  catch(Exception e) {
    neighbourg[RIGHT] = null;
  }
  try {
    if(!current.walls[LEFT]) {
      neighbourg[LEFT] = maze.grid[x-1][y];
    }
  }
  catch(Exception e) {
    neighbourg[LEFT] = null;
  }
  try {
    if(!current.walls[BOTTOM]) {
      neighbourg[BOTTOM] = maze.grid[x][y+1];
    }
  }
  catch(Exception e) {
    neighbourg[BOTTOM] = null;
  }

  boolean found = false;
  ArrayList<Cell> ret = new ArrayList<Cell>();

  for (Cell tmp : neighbourg)
  {
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