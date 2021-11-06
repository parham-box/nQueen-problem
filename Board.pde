import java.util.Random;

class Board {
  private int n;
  private int h;
  private int[][] cells;
  private int[][] nextH;
  public Board(int[][] b) {
    this.cells = b;
    n = cells.length;
    nextH = new int[n][n];
    //children = new Board[n][n];
    ev();
  }

  Board(int n) {
    this.n = n;
    this.cells = new int[n][n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cells[i][j] = 0;
      }
    }
    nextH = new int[n][n];
    //children = new Board[n][n];
    generateRandomQueens(n);
    ev();
    println(h);
  }
  public int[][] getBoard() {
    return cells;
  }

  public void generateRandomQueens(int size) {
    Random rand = new Random();
    for (int i = 0; i < size; i++) {
      cells[i][rand.nextInt(size - 1)] = 1;
    }
  }
  public void calculateNextStep() {


    for (int i =0; i < cells.length; i++) {
      int[] temp = cells[i];
      int[][] c = cells;

      for (int j = 0; j < cells.length; j++) {
        c[i] = new int[cells.length];
        for (int x =0; x < cells.length; x++) {
          c[i][x] = 0;
        }
        c[i][j] = 1;
        //children[i][j] = new Board(c);
        nextH[i][j] = new Board(c).h;
      }
      c[i] = temp;
    }
    int ii = 0;
    int jj = 0;
    int min = h;
    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        if (nextH[i][j] < min) {
          min = nextH[i][j];
          ii = i;
          jj = j;
        }
      }
    }
    Board best = this;

    for (int i =0; i < cells.length; i++) {
      if (i == ii) {
        for (int x =0; x < cells.length; x++) {
          best.cells[i][x] = 0;
        }

        best.cells[i][jj] = 1;
      }
    }

    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        print(nextH[i][j]+ " ");
      }
      println();
    }
    println(ii+ " "+jj);
    println(best.toString());
  }
  public void calculateH() {
  }
  public int ev() {
    h = 0;
    ArrayList<Integer> pos = getQueenPositions();

    for (int i = 0; i < cells.length - 1; i++) {
      h += countSafe(pos, i);
    }

    return h;
  }

  public int countSafe(ArrayList<Integer> pos, int row) {
    int count = 0;

    for (int i = row; i < cells.length - 1; i++) {
      if (pos.get(row) == pos.get(i + 1)) { // check if same column
        count++;
      }

      if ((pos.get(row) + row) == (pos.get(i + 1) + (i + 1))) { // check diagonal
        count++;
      }

      if ((pos.get(row) - row) == (pos.get(i + 1) - (i + 1))) { // check diagonal
        count++;
      }
    }
    return count;
  }

  public ArrayList<Integer> getQueenPositions() {
    ArrayList<Integer> pos = new ArrayList<Integer>();
    for (int i = 0; i < cells.length; i++) {
      pos.add(getColumn(i));
    }
    return pos;
  }
  public int getColumn(int row) {
    int index = 0;
    for (int i = 0; i < cells.length; i++) {
      if (cells[row][i] == 1) {
        index = i;
      }
    }

    return index;
  }



  public void drawBoard() {
    int a = round(height/cells.length);
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
