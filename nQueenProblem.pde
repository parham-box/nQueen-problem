int n = 8;
Board b;
private int[][] nextH = new int[n][n];
int[] status = new int[1000];
int[] steps = new int[1000];
int counter;
int i1 =0;
void setup() {
  size(1000, 1000); //size of the window
  background(255);//setting white background
  for (int i =0; i< steps.length; i++) {
    status[i] = 0;
    steps[i] = 0;
  }
      for (int i =0; i< steps.length; i++) {
        b = new Board(n);
        b.drawBoard(steps[i1]);

        while (true) {
          if (status[i1] ==0) {
            b = calculateNextStep(b);
            b.drawBoard(steps[i1]);
            println(steps[i1]);
          } else if (status[i1] == 1) {
            println("won");
            break;
          } else if (status[i1] == -1) {
            println("local max");
            break;
          }
        }
        counter++;
        i1++;
      }
  //hillClimbing(b);
  //println(b.toString());
  int win_count = 0;
  int win_avg = 0;
    int lose_count = 0;
  int lose_avg = 0;
    for(int i =0; i< steps.length; i++){
    if(status[i] == 1){
      win_count++;
      win_avg += steps[i];
    }else if(status[i] == -1){
            lose_count++;
      lose_avg += steps[i];
    }
  }
  println("Won " + win_count+ " of ",steps.length+"with average of:"+ win_avg/win_count);
  println("Local Max " + lose_count+ " of ",steps.length+"with average of:"+ lose_avg/lose_count);
}
void draw() {
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
    }
  }
}



public Board calculateNextStep(Board current) {
  int[][] cells = current.getBoard();
  boolean isLocalMax = false;
  boolean win = false;
  if (!isLocalMax && !win) {
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
    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        print(nextH[i][j]+ " ");
      }
      println();
    }
    int ii = 0;
    int jj = 0;
    int min = current.h;
    for (int i =0; i < cells.length; i++) {
      for (int j = 0; j < cells.length; j++) {
        if (nextH[i][j] < min) {
          min = nextH[i][j];
          ii = i;
          jj = j;
        }
      }
    }
    println("min: "+min + " h:" + current.h);
    if (min == current.h) {
      println("local max");
      isLocalMax = true;
      status[counter] = -1;
      return current;
    } else {
      if (min == 0) {
        println("win");
        win = true;
        status[counter] = 1;
      }
      Board best = current;

      for (int i =0; i < cells.length; i++) {
        if (i == ii) {
          for (int x =0; x < cells.length; x++) {
            best.cells[i][x] = 0;
          }

          best.cells[i][jj] = 1;
        }
      }

      //println(ii+ " "+jj);
      //println(best.toString());
      best.ev();
      steps[counter]++;
      return best;
    }
  }

  return null;
}
