
class Cell {
  int i;
  int j;
  int distance;
  boolean[] walls; //top, right, bottom, left;
  boolean visited = false;
  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    this.walls = new boolean[]{true, true, true, true};
    if (i==0 && j==0) {
      visited = true;
    }
  }
  
  void setDistance(int distance) {
    this.distance = distance;
  }
  
  int index(int i, int j) {
    if (i < 0 || j < 0 || i >= cols || j >= rows) {
      return -1;
    }
    return i + j * cols;
  }
  
  Cell checkNeighbors(ArrayList<Cell> grid) {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
    int[][]offsets = new int[][] {{0, -1}, {1, 0}, {0, 1}, {-1, 0}};
    for (int k = 0; k < offsets.length; k++) {
      int offset = index(this.i + offsets[k][0], this.j + offsets[k][1]);
      if (offset == -1) {
        continue;
      }
      //println("" + Integer.toString(rows) + "," + Integer.toString(cols));
      //println(Integer.toString(this.i + offsets[k][0]) + "," + Integer.toString(this.j + offsets[k][1]));
      Cell neighbor = grid.get(offset);
      if (!neighbor.visited) {
        neighbors.add(neighbor);
      }
    }
    
    /*
    Cell top = grid.get(index(i, j - 1));
    Cell rgiht = grid.get(index(i + 1, j));
    Cell botttom = grid.get(index(i, j + 1));
    Cell left = grid.get(index(i - 1, j));
    if (top != null && !top.visited) {
      neighbors.add(top);
    }
    if (rgiht != null && !rgiht.visited) {
      neighbors.add(rgiht);
    }
    if (botttom != null && !botttom.visited) {
      neighbors.add(botttom);
    }
    if (left != null && !left.visited) {
      neighbors.add(left);
    }
    */
    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }
  }
  
  void removeWall(Cell b) {
    int x = this.i - b.i;
    if (x == 1) {
      this.walls[3] = false;
      b.walls[1] = false;
    } else if (x == -1) {
      this.walls[1] = false;
      b.walls[3] = false;
    }
    int y = this.j - b.j;
    if (y == 1) {
      this.walls[0] = false;
      b.walls[2] = false;
    } else if (y == -1) {
      this.walls[2] = false;
      b.walls[0] = false;
    }
  } 
  
  void highlight() {
    int x = this.i * w;
    int y = this.j * w;
    
    noStroke();
    fill(0, 0, 255, 100);
    rect(x, y, w, w);
  }
  
  void startColor() {
    int x = this.i * w;
    int y = this.j * w;
    noStroke();
    fill(0, 0, 255, 255); // RGBA
    rect(x + lineWeight, y + lineWeight, w - 2 * lineWeight, w - 2 * lineWeight);
  }
  
  void goalColor() {
    int x = this.i * w;
    int y = this.j * w;
    noStroke();
    fill(255, 0, 0, 255); // RGBA
    rect(x + lineWeight, y + lineWeight, w - 2 * lineWeight, w - 2 * lineWeight);
  }
  
  void show() {
    int x = this.i * w;
    int y = this.j * w;
    stroke(255);
    strokeWeight(lineWeight);
    if (this.walls[0]) { // top
      line(x, y, x+w, y);
    }
    if (this.walls[1]) { // right
      line(x+w, y, x+w, y+w);
    }
    if (this.walls[2]) { // bottom
      line(x+w, y+w, x, y+w);
    }
    if (this.walls[3]) {
      line(x, y, x, y+w);
    }
    if (this.visited) {
      //noFill();
      noStroke();
      fill(255, 0, 255, 100);
      rect(x, y, w, w);
    }
  }
}
