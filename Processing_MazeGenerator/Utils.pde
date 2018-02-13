
class CellColor {
    int r, v, b, alpha;
    
    CellColor(int r, int v, int b) {
        this.r = r;
        this.v = v;
        this.b = b;
        this.alpha = 255;
    }
    
    CellColor(int r, int v, int b, int alpha) {
        this(r, v, b);
        this.alpha = alpha;
    }
}

int TOP =0, 
BOTTOM=1, 
LEFT=2, 
RIGHT=3;

class Cell {
    public int i;
    public int j;
    
    public CellColor cellColor;
    public boolean[] walls = new boolean[4];


    Cell( int i, int j) {
        this.i = i;
        this.j = j;
        
        walls[TOP] = true;
        walls[BOTTOM] = true;
        walls[LEFT] = true;
        walls[RIGHT] = true;
        
        cellColor = null;
    }

    void show() {
        float x = j * cell_size;
        float y = i * cell_size;
        
        stroke(0);
        if (walls[TOP])
            line(x, y, x+cell_size, y);
        if (walls[BOTTOM])
            line(x, y+cell_size, x+cell_size, y+cell_size);
        if (walls[LEFT])
            line(x, y, x, y+cell_size);
        if (walls[RIGHT])
            line(x+cell_size, y, x+cell_size, y+cell_size);
         
        textSize(cell_size/2);
        fill(0, 0, 0);
        //text(i+""+j, x, y);   
        
        if (cellColor != null) {
            noStroke();
            fill(cellColor.r, cellColor.v, cellColor.b, cellColor.alpha);
            rect(x, y, cell_size, cell_size);
        }
    }
}

interface Solver {
    void solve(Maze maze); 
}