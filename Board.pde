import java.util.Random;

class Board {
  private int n;
  private int h;
  private int[][] cells;
  Board(int n) {
    this.n = n;
    this.cells = new int[n][n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cells[i][j] = 0;
      }
    }
    generateRandomQueens(n);
  }
  public void generateRandomQueens(int size) {
    Random rand = new Random();
    for (int i = 0; i < size; i++) {
      cells[i][rand.nextInt(size - 1)] = 1;
    }
  }
  public void drawBoard() {
    //println(this.toString());
    int a = round(height/n);
    for (int x = 0; x <n; x++) {
      for (int y = 0; y <n; y++) {
        if (cells[x][y] == 1) {
          fill(0);
          rect(round(y*a)+a/4, round(x*a)+a/4, a/2, a/2);
        }
        stroke(0);
        line(round(y*a), 0, round(y*a), height);
      }
      stroke(0);
      line(0, round(x*a), width, round(x*a));
    }
  }
  public ArrayList<Integer> getQueenPositions() {
    ArrayList<Integer> pos = new ArrayList<Integer>();
    for (int i = 0; i < cells.length; i++) {
      pos.add(getColumn(i));
    }
    return pos;
  }

  public void calculateH() {
  }



  @Override
    public String toString() {
    String b = "";
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        if (cells[i][j] == 0) {
          b += " * ";
        } else {
          b += " Q ";
        }
      }
      b += "\n";
    }
    return b;
  }
}
