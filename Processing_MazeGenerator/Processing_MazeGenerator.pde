/**
* from this Wikipedia article 
* https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
*/

Maze currentMaze;
final CellColor pathCellColor = new CellColor(0, 255, 255, 100);
final CellColor visitedCellColor = new CellColor(255, 0, 255, 100);
float cell_size = 10;
int iteration = 0;

Generator mazeGenerator;
Solver solver;

void setup() {
    size (1700, 1000);
    
    currentMaze = new Maze();
    mazeGenerator = new Generator_BackTracker();
    solver = new RandomSolver();
    
    println("Maze genrated : " + currentMaze.cols + "x" + currentMaze.rows + "(" + (currentMaze.rows * currentMaze.cols) + " cells)");
}

void draw() {
    
    background(255);
    mazeGenerator.generate(currentMaze);
    
    solver.solve(currentMaze);
    
    currentMaze.showGrid(); 
    
    save("maze"+ (iteration++) +".jpg");
    
    if(iteration >= 1) {
        noLoop(); 
    }
}