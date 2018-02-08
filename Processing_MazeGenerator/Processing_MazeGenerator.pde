/**
 * from this Wikipedia article 
 * https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
 */

Maze maze;
final CellColor pathCellColor = new CellColor(0, 255, 255, 100);
final CellColor visitedCellColor = new CellColor(255, 0, 255, 100);
float cell_size = 10;
int iteration = 0;

void setup() {
  size (1300, 1000);

  maze = new Maze();
  
  print("Maze genrated : " + maze.rows + "x" + maze.cols + "(" + (maze.rows * maze.cols) + " cells)");
}

void draw() {
  
  background(255);
  maze.generate_BackTraker();
  
  //solve_random(maze);
  
  solve_recursive(maze);
  maze.showGrid();  //<>//

  save("maze"+ (iteration++) +".jpg");
  
  if(iteration >= 1) {
     noLoop(); 
  }
}