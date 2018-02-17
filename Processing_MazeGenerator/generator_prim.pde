class Generator_Prim implements Generator{
    
    private class CellWithSet {
        int setNumber;
        Cell cell;
        
        CellWithSet(Cell celll) {
            this.setNumber = -1;
            this.cell = celll;
        }
    }
    
    void generate(Maze maze) {

        println("Begin generation with prim's algorithm");
        
        maze.reset();
        
        // Init cells 
        CellWithSet[][] cellSets = new CellWithSet[maze.rows][maze.cols];
        
        for (int i = 0; i< maze.rows; i++) {
            for (int j = 0; j< maze.cols; j++) {
                cellSets[i][j] = new CellWithSet(maze.grid[i][j]);
            }
        }
        
        // Init the set of the first row
        for (int j = 0; j < maze.cols; j++) {
            cellSets[0][j].setNumber = j+1;
        }
        
        // Generate the maze
        for (int i = 0; i< maze.rows ; i++) {
            setSets(maze, cellSets, i);
            manageLinearSet(maze, cellSets, i);
            linkToNextLine(maze, cellSets, i);
        }
        
        // Remove wall from last row
        for (int j = 0; j< maze.cols; j++) {
            if(j > 0)
                cellSets[maze.rows - 1][j].cell.walls[LEFT] = false;
            if(j < maze.cols - 1)
                cellSets[maze.rows - 1][j].cell.walls[RIGHT] = false;
        }
        
        maze.isGenerated = true;
        println("Generation with prim's algorithm done");
    }
    
    void setSets(Maze maze, CellWithSet[][] cellSets, int i) {
    
        int setNumber = -1;
        for(int j = 0; j< maze.cols; j++) {
            if(cellSets[i][j].setNumber != -1 && cellSets[i][j].setNumber > setNumber) {
                setNumber = cellSets[i][j].setNumber;
            }
        }
    
        for(int j = 0; j< maze.cols; j++) {
            CellWithSet currentCell = cellSets[i][j];
            
            if(currentCell.setNumber == -1) {
                setNumber++;
                currentCell.setNumber = setNumber;
            }
        }
    }

    void manageLinearSet(Maze maze, CellWithSet[][] cellSets, int i) {
        
        for(int j = 0; j < maze.cols; j++) {
        
            CellWithSet currentCell = cellSets[i][j];
            
            // 0 => left, 1 => right, 2 => no change
            int randomRatio = 2; 
            int changeStatus = int(random(randomRatio));
            if(changeStatus > (randomRatio / 2)) {
                if(j > 0) {// change set to left
                    CellWithSet leftCell = cellSets[i][j - 1];
                    if(leftCell.setNumber != currentCell.setNumber) {
                        currentCell.setNumber = leftCell.setNumber;
                        leftCell.cell.walls[RIGHT] = false;
                        currentCell.cell.walls[LEFT] = false;
                    }
                }
            }else {
                if(j < (maze.cols - 1)) { // change set to right
                    CellWithSet rightCell = cellSets[i][j + 1];
                    if(rightCell.setNumber != currentCell.setNumber) {
                        currentCell.setNumber = rightCell.setNumber;
                        rightCell.cell.walls[LEFT] = false;
                        currentCell.cell.walls[RIGHT] = false;
                    }
                }
            }        
        }      
    }

    void linkToNextLine(Maze maze, CellWithSet[][] cellSets, int i) {
        
        // dont need to link to the next ine if there is not 
        if(i >= maze.rows - 1) {
            return;
        }
        
        HashMap<Integer, ArrayList<CellWithSet>> setToCells = new HashMap<Integer, ArrayList<CellWithSet>>();
        
        // Build the list of cells mapped to there set number
        for(int j = 0; j< maze.cols; j++) {
            CellWithSet currentCell = cellSets[i][j];
            ArrayList<CellWithSet> list = setToCells.get(currentCell.setNumber);
            if(list == null) {
                list = new ArrayList<CellWithSet>();
            }
            
            list.add(currentCell);
            
            setToCells.put(currentCell.setNumber, list);
        }
        
        
        for(ArrayList<CellWithSet> setList : setToCells.values()) {
            int cellIndex = int(random(setList.size()));
            
            CellWithSet currentCell = setList.get(cellIndex);
            CellWithSet bottomCell = cellSets[i + 1][currentCell.cell.j];
            
            currentCell.cell.walls[BOTTOM] = false;
            bottomCell.cell.walls[TOP] = false;
            
            bottomCell.setNumber = currentCell.setNumber;
        }
    }   
}