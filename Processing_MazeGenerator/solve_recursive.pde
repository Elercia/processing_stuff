
void solve_recursive(Maze maze) {
  
  boolean[][] visitedCells = new boolean[maze.rows][maze.cols];
  
  ArrayList<Cell> path = new ArrayList<Cell>();
  
  for (int i = 0; i< maze.rows; i++) {
    for (int j = 0; j< maze.cols; j++) {
      visitedCells[i][j] = false;
    }
  }
  
  path = solve_recursive_recursive(0, 0, visitedCells, path, maze.rows - 1, maze.cols - 1);
  
  if(path != null) {
    println("solve_recursive done");
    
    for(Cell cell : path) {
       cell.cellColor = pathCellColor;
    }
    
  } else {
    println("solve_recursive impossible");
  }
}

ArrayList<Cell> solve_recursive_recursive(int x, int y, boolean[][] visitedCells, ArrayList<Cell> path, int xDest, int yDest) {
  
  Cell current = maze.grid[x][y];
  ArrayList<Cell> pathTmp = null;
  
  visitedCells[x][y] = true;
  current.cellColor = visitedCellColor;
  
  if(path != null) {
    path.add(current);
  }
  
  if(x == xDest && y == yDest) {
      return path;
  }
  
  if(y > 0 && !current.walls[TOP] && !visitedCells[x][y-1]) {
    pathTmp = solve_recursive_recursive(x, y - 1, visitedCells, path, xDest, yDest);
    
    if(solve_recursive_containLastCell(xDest, yDest, pathTmp)) {
       return pathTmp; 
    }
  }
  
  if(x < maze.rows && !current.walls[RIGHT] && !visitedCells[x + 1][y]) {
    pathTmp = solve_recursive_recursive(x + 1, y, visitedCells, path, xDest, yDest);
    if(solve_recursive_containLastCell(xDest, yDest, pathTmp)) {
       return pathTmp; 
    }
  }
    
  if(x > 0 && !current.walls[LEFT] && !visitedCells[x - 1][y]) {
    pathTmp = solve_recursive_recursive(x - 1, y, visitedCells, path, xDest, yDest);
    if(solve_recursive_containLastCell(xDest, yDest, pathTmp)) {
       return pathTmp; 
    }
  }
  
  if(y < maze.rows && !current.walls[BOTTOM] && !visitedCells[x][y+1]) {
    pathTmp = solve_recursive_recursive(x, y + 1, visitedCells, path, xDest, yDest);
    if(solve_recursive_containLastCell(xDest, yDest, pathTmp)) {
       return pathTmp; 
    }
  }
  
  return null;
}

boolean solve_recursive_containLastCell(int xDest, int yDest, ArrayList<Cell> path) {
  
  if(path == null) {
     return false; 
  }
  
  for(Cell cell : path) {
      if(cell.x == xDest && cell.y == yDest) {
        return true; 
      }
  }
  return false;
}