
class Generator_BackTracker implements Generator{
    
    void generate(Maze maze) {
   
        println("Begin generation with recursive backtracker");
    
        maze.reset();
    
        ArrayList<Cell> stack = new ArrayList<Cell>();
        
        Cell current;
        Cell choosen;
        
        current = maze.grid[0][0];
        boolean[][] visitedCells = new boolean[maze.rows][maze.cols];
        for (int i = 0; i< maze.rows; i++) {
            for (int j = 0; j< maze.cols; j++) {
                visitedCells[i][j] = false;
            }
        }
    
        visitedCells[current.i][current.j] = true;
    
        while(!maze.isGenerated) {
            if (isThereCellNotVisited(maze, visitedCells)) {
                choosen = getRandomUnvisitedNeighbourg(maze, current.i, current.j, visitedCells);
                if (choosen != null) {//if the current cells have neighbourg that have not been visited
                    stack.add(choosen);
                    //remove the wall between the two cells
                
                    if (choosen.i < current.i) {// TOP
                        choosen.walls[BOTTOM]=false;
                        current.walls[TOP]=false;
                    } else if (choosen.i > current.i) {// BOTTOM
                        choosen.walls[TOP]=false;
                        current.walls[BOTTOM]=false;
                    } else if (choosen.j < current.j) {// LEFT
                        choosen.walls[RIGHT]=false;
                        current.walls[LEFT]=false;
                    } else if (choosen.j > current.j) {// RIGHT
                        choosen.walls[LEFT]=false;
                        current.walls[RIGHT]=false;
                    }
                
                    visitedCells[choosen.i][choosen.j] = true;
                    current = choosen;
                } else if (stack.size()>0) {
                    current = stack.get(stack.size()-1);
                    stack.remove(stack.size()-1);
                }
            } else {
                println("Finished generation");
                maze.isGenerated = true;
            }
        }
    } // generate_BackTraker

    private boolean isThereCellNotVisited(Maze maze, boolean[][] visitedCells) {
        for (int i = 0; i< maze.rows; i++) {
            for (int j = 0; j< maze.cols; j++) {
                if (!visitedCells[i][j])
                    return true;
            }
        }
        return false;
    }

    private Cell getRandomUnvisitedNeighbourg(Maze maze, int x, int y, boolean[][] visitedCells) {
        Cell[] neighbourg = new Cell[4];
        
        if(x > 0) {
            neighbourg[TOP] = maze.grid[x-1][y];
        } else  {
            neighbourg[TOP] = null;
        }
        
        if(x < maze.rows - 1) {
            neighbourg[BOTTOM] = maze.grid[x+1][y];
        } else {
            neighbourg[BOTTOM] = null;
        }
        
        if(y < maze.cols - 1) {
            neighbourg[RIGHT] = maze.grid[x][y + 1];
        } else {
            neighbourg[RIGHT] = null;
        }
        
        if(y > 0) {
            neighbourg[LEFT] = maze.grid[x][y - 1];
        } else {
            neighbourg[LEFT] = null;
        }

        
        boolean found = false;
        ArrayList<Cell> ret = new ArrayList<Cell>();
        
        for (Cell tmp : neighbourg) {
            if (tmp != null && !visitedCells[tmp.i][tmp.j]) {
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