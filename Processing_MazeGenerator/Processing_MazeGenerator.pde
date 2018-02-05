/**
 * from this Wikipedia article 
 * https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
 */

float cell_size = 10;
Cell[][] grid;
Cell current;
Cell choosen;

ArrayList<Cell> stack;

int cols, rows;

void setup() {
  size (1300, 1000);
  cols = floor(height / cell_size);
  rows = floor(width / cell_size);
  grid = new Cell[rows][cols];

  stack = new ArrayList<Cell>();

  for (int i = 0; i< rows; i++) {
    for (int j = 0; j< cols; j++) {
      grid[i][j] = new Cell(i, j);
    }
  }

  current = grid[0][0];
  current.visited = true;
}

void draw() {
  background(255);
  //println(frameRate);
  for (int i = 0; i< rows; i++) {
    for (int j = 0; j< cols; j++) {
      grid[i][j].show();
    }
  }
  for (int y = 0; y < 100; y++)
  {
    if (checkAllCell()) {
      choosen = current.getRandomNeighbourg();
      if (choosen != null) {//if the current cells have neighbourg that have not been visited
        stack.add(choosen);
        //remove the wall between the two cells

        if (choosen.x < current.x) {//left
          choosen.walls[RIGHT]=false;
          current.walls[LEFT]=false;
        } else if (choosen.x > current.x) {//right
          choosen.walls[LEFT]=false;
          current.walls[RIGHT]=false;
        } else if (choosen.y < current.y) {//top
          choosen.walls[BOTTOM]=false;
          current.walls[TOP]=false;
        } else if (choosen.y > current.y) {//top
          choosen.walls[TOP]=false;
          current.walls[BOTTOM]=false;
        }

        choosen.visited = true;
        current = choosen;
      } else if (stack.size()>0) {
        current = stack.get(stack.size()-1);
        stack.remove(stack.size()-1);
      }
    } else {
      background(255);
      for (int i = 0; i< rows; i++) {
        for (int j = 0; j< cols; j++) {
          grid[i][j].visited = false;
          grid[i][j].show();
        }
      }
      save("result.jpg");
      println("Finished");
      noLoop();
    }
  }
}

boolean checkAllCell() {
  for (int i = 0; i< rows; i++) {
    for (int j = 0; j< cols; j++) {
      if (!grid[i][j].visited)
        return true;
    }
  }
  return false;
}