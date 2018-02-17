

class RecursiveSolver implements Solver {

    private boolean[][] visitedCells;
    
    public void solve(Maze maze) {
        
        visitedCells = new boolean[maze.rows][maze.cols];
        for (int i = 0; i< maze.rows; i++) {
            for (int j = 0; j< maze.cols; j++) {
                visitedCells[i][j] = false;
            }
        } 
    
        ArrayList<Cell> path = new ArrayList<Cell>();
        
        path = recursive(maze, 0, 0, path, maze.rows - 1, maze.cols - 1);
        
        if(path != null) {
            println("solve_recursive done");
            
            for (int i = 0; i< maze.rows; i++) {
                for (int j = 0; j< maze.cols; j++) {
                    if(visitedCells[i][j]) {
                        maze.grid[i][j].cellColor = visitedCellColor;
                    }
                }
            }
            
            for(Cell cell : path) {
                cell.cellColor = pathCellColor;
            }
        
        } else {
            println("solve_recursive impossible");
        }
    } // solve 
    
    private ArrayList<Cell> recursive(Maze maze, int x, int y, ArrayList<Cell> path, int xDest, int yDest) {
    
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
        
        // Check BOTTOM
        if(x < maze.rows - 1 && !current.walls[BOTTOM] && !visitedCells[x + 1][y]) {
            pathTmp = recursive(maze, x + 1, y, path, xDest, yDest);
            if(containLastCell(xDest, yDest, pathTmp)) {
                return pathTmp; 
            }
        }
        
        // Check TOP
        if(x > 0 && !current.walls[TOP] && !visitedCells[x - 1][y]) {
            pathTmp = recursive(maze, x - 1, y, path, xDest, yDest);
            
            if(containLastCell(xDest, yDest, pathTmp)) {
                return pathTmp; 
            }
        }
        
        // Check RIGHT
        if(y < maze.cols - 1 && !current.walls[RIGHT] && !visitedCells[x][y + 1]) {
            pathTmp = recursive(maze, x, y + 1, path, xDest, yDest);
            if(containLastCell(xDest, yDest, pathTmp)) {
                return pathTmp; 
            }
        }
        
        // Check LEFT
        if(y > 0  && !current.walls[LEFT] && !visitedCells[x][y - 1]) {
            pathTmp = recursive(maze, x, y - 1, path, xDest, yDest);
            if(containLastCell(xDest, yDest, pathTmp)) {
                return pathTmp; 
            }
        }    
        
        return null;
    } // recusive
    
    private boolean containLastCell(int xDest, int yDest, ArrayList<Cell> path) {
    
        if(path == null) {
            return false; 
        }
        
        for(Cell cell : path) {
            if(cell.i == xDest && cell.j == yDest) {
                return true; 
            }
        }
        
        return false;
    } // containLastCell
}