/**
* from this Wikipedia article 
* https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
*/

Maze maze;
final CellColor pathCellColor = new CellColor(0, 255, 255, 100);
final CellColor visitedCellColor = new CellColor(255, 0, 255, 100);
float cell_size = 10;
int iteration = 0; 
Solver solver;

void setup() {
    size (1700, 1000);
    
    maze = new Maze();
    solver = new RecursiveSolver();
    
    println("Maze genrated : " + maze.cols + "x" + maze.rows + "(" + (maze.rows * maze.cols) + " cells)");
}

void draw() {
    
    background(255);
    maze.generate_BackTracker();
    
    solver.solve(maze);
    
    maze.showGrid();  //<>//
    
    save("maze"+ (iteration++) +".jpg");
    
    if(iteration >= 1) {
        noLoop(); 
    }
}