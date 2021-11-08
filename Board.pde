import java.util.Random;

class Board {
  //the number of queens on the board
  private int n;
  //the heuristic value for the board
  private int h;
  //cells of the board
  private int[][] cells;
  //constructor with the cells position
  public Board(int[][] b) {
    this.cells = b;
    n = cells.length;
    //calculate the value of heuristic
    calculateH();
  }
  //overload constructor by placing queens in a random place
  Board(int n) {
    this.n = n;
    this.cells = new int[n][n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cells[i][j] = 0;
      }
    }
    //generate the random queens on the board
    generateRandomQueens(n);
    //calculate the value of heuristic
    calculateH();
    println(h);
  }
  //get the cells
  public int[][] getBoard() {
    return cells;
  }
  //use Java.util.random to create a random place for each queen
  //each row has one queen and the column is randomly generated
  public void generateRandomQueens(int size) {
    Random rand = new Random();
    for (int i = 0; i < size; i++) {
      cells[i][rand.nextInt(size - 1)] = 1;
    }
  }
  //calculate the value of h
  public int calculateH() {
    h = 0;
    //get positions of all queens
    ArrayList<Integer> pos = getQueenPositions();
    for (int i = 0; i < cells.length - 1; i++) {
      //for each queen, check how many pairs it can attack, and add it to the total value of heuristic for that state
      h += countAttackingPair(pos, i);
    }

    return h;
  }
  //count the number of queens that a queen in a specific row can attack to
  public int countAttackingPair(ArrayList<Integer> pos, int row) {
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
  //return the position of all of the queens in the board
  public ArrayList<Integer> getQueenPositions() {
    ArrayList<Integer> pos = new ArrayList<Integer>();
    for (int i = 0; i < cells.length; i++) {
      //for each row, find which column of that row has a queen, and add it to array list
      pos.add(getColumn(i));
    }
    return pos;
  }
  //return which column of a inputted row has a queen on it
  public int getColumn(int row) {
    int index = 0;
    for (int i = 0; i < cells.length; i++) {
      //if there is a queen on a cell of the board, the value of that cell is 1, if there is nothing on the board, the value is 0
      if (cells[row][i] == 1) {
        index = i;
      }
    }
    return index;
  }
  //draw the board on the window
  public void drawBoard(int steps) {
    background(255);
    int a = round(height/n);
    for (int x = 0; x <n; x++) {
      for (int y = 0; y <n; y++) {
        if (cells[x][y] == 1) {
          fill(0);
          //draw queens as a black rectangle
          rect(round(y*a)+a/4, round(x*a)+a/4, a/2, a/2);
        }
        stroke(0);
        line(round(y*a), 0, round(y*a), height);
      }
      stroke(0);
      line(0, round(x*a), width, round(x*a));
    }
    fill(0);
    text("Steps: "+steps, 10, 15);
  }
  //override toString function for easier printing
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
