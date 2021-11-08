import java.util.Random;
//the number of queens
int n = 8;
//number of runs
int numberOfRuns = 1000;
Board b;
//the array for each cells heuristic value
private int[][] nextH = new int[n][n];
//the result of each run
int[] status = new int[numberOfRuns];
//number of steps at each run
int[] steps = new int[numberOfRuns];
int counter;
int i1 =0;
void setup() {
  size(1000, 1000); //size of the window
  background(255);//setting white background
  //intialize the values of status and steps
  for (int i =0; i< steps.length; i++) {
    status[i] = 0;
    steps[i] = 0;
  }
  //the algorithm, runs numberOfRuns time, eg 1000
  for (int i =0; i< steps.length; i++) {
    //a new board with random queen positions
    b = new Board(n);
    b.drawBoard(steps[i1]);
    //while its not local maxima or win the game
    while (true) {
      //calculate next step if everything is ok
      if (status[i1] ==0) {
        b = calculateNextStep(b);
        b.drawBoard(steps[i1]);
        println(steps[i1]);
      } else if (status[i1] == 1) { // if won break
        println("won");
        break;
      } else if (status[i1] == -1) { // if local maxima break
        println("local max");
        break;
      }
    }
    counter++;
    i1++;
  }
  
  //println(b.toString());
  int win_count = 0;
  int win_avg = 0;
  int lose_count = 0;
  int lose_avg = 0;
  //calculate the win and lose rate, and their average
  for (int i =0; i< steps.length; i++) {
    if (status[i] == 1) {
      win_count++;
      win_avg += steps[i];
    } else if (status[i] == -1) {
      lose_count++;
      lose_avg += steps[i];
    }
  }
  println("Won " + win_count+ " of ", steps.length+"with average of:"+ win_avg/win_count);
  println("Local Max " + lose_count+ " of ", steps.length+" with average of:"+ lose_avg/lose_count);
}
//the empry draw function
void draw() {
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      //the code to run only one board, not numberOfRuns times, work with UP arrow key 
      if (status[0] ==0) {
        b = calculateNextStep(b);
        b.drawBoard(steps[0]);
        println(steps[0]);
      } else if (status[0] == 1) {
        println("won");
        //brek;
      } else if (status[0] == -1) {
        println("local max");
      }
    }
  }
}
//calculate next step from the current board 
public Board calculateNextStep(Board current) {
  //get the current board
  int[][] cells = current.getBoard();
  //its not a local max at the start
  boolean isLocalMax = false;
  //we have not win at the start
  boolean win = false;
  //if it is not a loacl maxima and not win
  if (!isLocalMax && !win) {
    //for all the cells
    for (int i =0; i < cells.length; i++) {
      int[] temp = cells[i];
      int[][] c = cells;
      //move a queen in 'c' to a new position
      for (int j = 0; j < cells.length; j++) {
        c[i] = new int[cells.length];
        for (int x =0; x < cells.length; x++) {
          c[i][x] = 0;
        }
        c[i][j] = 1;
        // create a new board with the cells of 'c' and get the heuristic value for the board with a single queen in a new position
        nextH[i][j] = new Board(c).h;
      }
      c[i] = temp;
    }
    //print the values of h for each cell if the queen from that row was there
    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        print(nextH[i][j]+ " ");
      }
      println();
    }
    //steepest acsent hill clibming
    //find the cell with minimum value of h, in other word, find the cell that goes further up the hill
    int ii = 0;
    int jj = 0;
    int val = 0;
    int min = current.h;
    //find the minimum of heuristics in the board
    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        if (nextH[i][j] < min) {
          min = nextH[i][j];
          val = min;
          ii = i;
          jj = j;
        }
      }
    }
    println("min: "+min + " h:" + current.h);
    if (min == current.h) {
      //if the h value is local maxima, change status
      println("local max");
      isLocalMax = true;
      status[counter] = -1;
      return current;
    } else {
      if (min == 0) {
        //if we can win, win
        println("win");
        win = true;
        status[counter] = 1;
      }
      Board best = current;
      //change the position of the queen to the best place
      for (int i =0; i < cells.length; i++) {
        if (i == ii) {
          for (int x =0; x < cells.length; x++) {
            best.cells[i][x] = 0;
          }

          best.cells[i][jj] = 1;
        }
      }
      //calculate h
      best.calculateH();
      //add a step
      steps[counter]++;
      //return the new best state
      return best;
    }
  }

  return null;
}
