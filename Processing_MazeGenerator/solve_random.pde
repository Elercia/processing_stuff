
class RandomSolver implements Solver {

    public void solve(Maze maze) {
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
        visitedCells[current.i][current.j] = true;
        
        while (current != dest) {
        
            current = getRandomCell(current.i, current.j, maze, visitedCells);
            
            if(current == null) {
                if(path.size() == 0) {
                    print("Random solve impossible\n");
                    return;
                }
                
                current = path.get(path.size()-1);
                path.remove(path.size()-1);
            } else {
                current.cellColor = visitedCellColor; 
                path.add(current);
                visitedCells[current.i][current.j] = true;
            }
        }
        
        println("Random solve done");
        println("size:"+path.size());
        
        
        for(Cell cell : path) {
            cell.cellColor = pathCellColor; 
        }
    } // solve
    
    private Cell getRandomCell(int x, int y, Maze maze, boolean[][] visitedCells) {
    
        Cell[] neighbourg = new Cell[4];
        neighbourg[TOP] = null;
        neighbourg[RIGHT] = null;
        neighbourg[LEFT] = null;
        neighbourg[BOTTOM] = null;
        
        Cell current = maze.grid[x][y];
        
        // TOP
        if(x > 0 && !current.walls[TOP]) { //<>//
            neighbourg[TOP] = maze.grid[x - 1][y];
        } else {
            neighbourg[TOP] = null;
        }
        
        // BOTTOM
        if(x < maze.rows - 1 && !current.walls[BOTTOM]) {
            neighbourg[BOTTOM] = maze.grid[x + 1][y];
        } else {
            neighbourg[BOTTOM] = null;
        }
        
        // LEFT
        if(y > 0 && !current.walls[LEFT]) {
            neighbourg[LEFT] = maze.grid[x][y-1];
        } else {
            neighbourg[LEFT] = null;
        }      
        
        // RIGHT
        if(y < maze.cols - 1 && !current.walls[RIGHT]) {
            neighbourg[RIGHT] = maze.grid[x][y + 1];
        } else {
            neighbourg[RIGHT] = null;
        }
        
        boolean found = false;
        ArrayList<Cell> ret = new ArrayList<Cell>(); //<>//
        
        for (Cell tmp : neighbourg) {
            if (tmp != null && !visitedCells[tmp.i][tmp.j]) {
                ret.add(tmp);
                found = true;
            }
        }
        
        if (!found) {
            return null;
        } else {
            int randIndex = floor(random(0, ret.size()));
            return ret.get(randIndex);
        }
    }
}