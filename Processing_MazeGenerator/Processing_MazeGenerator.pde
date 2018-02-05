/**
 * from this Wikipedia article 
 * https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
 */

Maze maze;
float cell_size = 10;

void setup() {
  size (1300, 1000);
  
  maze = new Maze();
  
  maze.generate();
  save("maze.jpg");
}

void draw() {
  
  background(255);
  maze.resetColor();
  maze.showGrid();
  
  random_solve(maze);
  delay(1000);
}