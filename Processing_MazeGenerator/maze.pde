
class Maze {

    Cell[][] grid;
    boolean isGenerated;
    int cols, rows;
    
    Maze() {
        
        rows = floor(height / cell_size);
        cols = floor(width / cell_size);
        
        grid = new Cell[rows][cols];
        
        reset();
    }

    void reset() {
        for (int i = 0; i< rows; i++) {
            for (int j = 0; j< cols; j++) {
                grid[i][j] = new Cell(i, j);
            }
        }
        
        isGenerated = false; //<>//
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

///////////////////////////////////////////////////////////////////////////////////////
////                            BACKTRACKER                                          //
///////////////////////////////////////////////////////////////////////////////////////

    public void generate_BackTracker() {
    
        println("Begin generation with recursive backtracker");
    
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
    
        visitedCells[current.i][current.j] = true;
    
        while(!isGenerated) {
            if (isThereCellNotVisited(visitedCells)) {
                choosen = getRandomUnvisitedNeighbourg(current.i, current.j, visitedCells);
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
                isGenerated = true;
            }
        }
    } // generate_BackTraker

    private boolean isThereCellNotVisited(boolean[][] visitedCells) {
        for (int i = 0; i< rows; i++) {
            for (int j = 0; j< cols; j++) {
                if (!visitedCells[i][j])
                    return true;
            }
        }
        return false;
    }

    private Cell getRandomUnvisitedNeighbourg(int x, int y, boolean[][] visitedCells) {
        Cell[] neighbourg = new Cell[4];
        
        if(x > 0) {
            neighbourg[TOP] = grid[x-1][y];
        } else  {
            neighbourg[TOP] = null;
        }
        
        if(x < rows - 1) {
            neighbourg[BOTTOM] = grid[x+1][y];
        } else {
            neighbourg[BOTTOM] = null;
        }
        
        if(y < cols - 1) {
            neighbourg[RIGHT] = grid[x][y + 1];
        } else {
            neighbourg[RIGHT] = null;
        }
        
        if(y > 0) {
            neighbourg[LEFT] = grid[x][y - 1];
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

///////////////////////////////////////////////////////////////////////////////////////
////                            PRIM                                                 //
///////////////////////////////////////////////////////////////////////////////////////

    public void generate_PrimAlgo() {
    
        println("Begin generation with prim's algorithm");
        
        reset();
        
        CellWithSet[][] cellSets = new CellWithSet[rows][cols];
        
        for (int i = 0; i< rows; i++) {
            for (int j = 0; j< cols; j++) {
                cellSets[i][j] = new CellWithSet(grid[i][j]);
            }
        }
        
        // initialize first row
        for (int j = 0; j < cols; j++) {
            cellSets[0][j].setNumber = new Integer(j);
        }
        
        // for all others rows 
        for (int i = 0; i< rows ; i++) {
            setSets(cellSets, i);
            manageLinearSet(cellSets, i);
            linkToNextLine(cellSets, i);
        }
        
        // do last row
        for (int j = 0; j< cols; j++) {
            cellSets[0][j].cell.walls[LEFT] = false;
            cellSets[0][j].cell.walls[RIGHT] = false;
        }
        
        ////////////////////////////////////////////////////// TO REMOVE
        textSize(cell_size);
        fill(0, 0, 0);
        for (int i = 0; i< rows; i++) {
            for (int j = 0; j< cols; j++) {
                CellWithSet current = cellSets[i][j];
                //text(current.setNumber+"", current.cell.x * cell_size, current.cell.y * cell_size);
            }
        }
        //////////////////////////////////////////////////////
        
        isGenerated = true;
        println("Generation with prim's algorithm done");
    }

    private class CellWithSet {
        Integer setNumber;
        Cell cell;
        
        CellWithSet(Cell celll) {
            setNumber = null;
            cell = celll;
        }
    }

    void manageLinearSet(CellWithSet[][] cellSets, int i) {
        
        for(int j = 0; j< cols; j++) {
        
            CellWithSet currentCell = cellSets[i][j];
            
            // 0 => left, 1 => right, 2 => no change
            int changeStatus = int(random(2));
            switch(changeStatus) {
            case 0: // change set to left
                if(j > 0) {
                    CellWithSet leftCell = cellSets[i][j - 1];
                    if(leftCell.setNumber != currentCell.setNumber) {
                        currentCell.setNumber = leftCell.setNumber;
                        leftCell.cell.walls[RIGHT] = false;
                        currentCell.cell.walls[LEFT] = false;
                    }
                }
                break;
            case 1:// change set to left
                if(j > 0) {
                    CellWithSet rightCell = cellSets[i][j - 1];
                    if(rightCell.setNumber != currentCell.setNumber) {
                        currentCell.setNumber = rightCell.setNumber;
                        rightCell.cell.walls[LEFT] = false;
                        currentCell.cell.walls[RIGHT] = false;
                    }
                }
                break;
            }        
        }      
    }

    void setSets(CellWithSet[][] cellSets, int i) {
    
        int setNumber = -1;
        for(int j = 0; j< cols; j++) {
            if(cellSets[i][j].setNumber != null && cellSets[i][j].setNumber > setNumber) {
                setNumber = cellSets[i][j].setNumber;
            }
        }
    
    
    
        for(int j = 0; j< cols; j++) {
            CellWithSet currentCell = cellSets[i][j];
            
            if(currentCell.setNumber == null){
                setNumber++;
                currentCell.setNumber = new Integer(setNumber);
            }
        }
    }

    void linkToNextLine(CellWithSet[][] cellSets, int i) {
        
        // dont need to link to the next ine if there is not 
        if(i == rows - 1) {
            return;
        }
    
        ArrayList<Integer> setDone = new ArrayList<Integer>();
        
        for(int j = 0; j< cols; j++){
            CellWithSet currentCell = cellSets[i][j];
            CellWithSet bottomCell = cellSets[i + 1][j];
            
            if(!setDone.contains(currentCell.setNumber)) {
                setDone.add(currentCell.setNumber);
                
                currentCell.cell.walls[BOTTOM] = false;
                bottomCell.cell.walls[TOP] = false;
                
                bottomCell.setNumber = currentCell.setNumber;
            }
        }
    }   
}