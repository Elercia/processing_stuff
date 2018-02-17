
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

///////////////////////////////////////////////////////////////////////////////////////
////                            PRIM                                                 //
/////////////////////////////////////////////////////////////////////////////////////// //<>//
}