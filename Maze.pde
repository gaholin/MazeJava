import java.util.Stack;

ArrayList<Cell> grid;
int cols, rows;
int w = 20;
int lineWeight = 3;
Cell current;
Stack<Cell> stack;
boolean done = false;
Cell first, last;

void setup() {
  size(400, 400);
  cols = floor(width / w);
  rows = floor(height / w);
  grid = new ArrayList<Cell>();
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid.add(new Cell(i, j));
    }
  }
  stack = new Stack<Cell>();
  first = grid.get(0);
  current = first;
  current.setDistance(0);
  //frameRate(5);
}

void draw() {
  background(51);
  for (Cell cell : grid) {
    cell.show();
  }
  if (done) {
    first.startColor();
    last.goalColor();
    return ;
  }
  current.visited = true;
  Cell next = current.checkNeighbors(grid);
  if (next != null) {
    // STEP 1
    next.visited = true;
    
    // STEP 2: recursive backtracker
    stack.push(current);
    
    // STEP 3
    current.removeWall(next);
    current.highlight();
    next.setDistance(current.distance + 1);
    
    // STEP 4
    current = next;
  } else if (stack.size() > 0) {
    current = stack.pop();
  } else {
    done = true;
    int maxDistance = 0;
    int x = 0;
    int y = 0;
    for (Cell cell : grid) {
      if (cell.distance > maxDistance) {
        x = cell.i;
        y = cell.j;
        maxDistance = cell.distance;
      }
    }
    println("last("+Integer.toString(x)+","+Integer.toString(y));
    last = grid.get(x + y * cols);
  }
}
