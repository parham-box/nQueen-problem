int N = 8;

void setup() {
  size(1000, 1000); //size of the window
  background(255);//setting white background
  Board b = new Board(4);

  //hillClimbing(b);
    b.drawBoard();
  b.calculateNextStep();
}


public void hillClimbing(Board board) {
  boolean isLocalMax = false, continueSearch = true;
  Board currentBoard = new Board(board.getBoard()); // copy of the board
  int iterations = 0;
  int globalMax = 0;

  while (continueSearch) {
    if (currentBoard.h == 0) { // check if the board configuration is the goal board
      System.out.println("=================Solution Found=================" + "\nNumber of iterations: "
        + iterations + "\nEvaluation Function: " + currentBoard.h
        + "\nBoard Configuration:\n" + currentBoard.toString());
      continueSearch = false;
      break;
    } else {
      for (int i = 0; i < currentBoard.getBoard().length; i++) {
        Board bestSuccessor = generateSuccessor(currentBoard, i);
        if (bestSuccessor.h < currentBoard.h) {
          currentBoard = bestSuccessor;
          iterations++;
          isLocalMax = false;
        } else {
          isLocalMax = true;
        }
      }

      if (isLocalMax) {
        System.out.println(
          "=================Local Maximum Encoutered=================" + "\nNumber of iterations: "
          + iterations + "\nEvaluation Function: " + currentBoard.h
          + "\nLocal Maximum Board Configuration:\n" + currentBoard.toString());
          currentBoard.drawBoard();
        continueSearch = false;
        break;
      }
    }
  }
}
public Board generateSuccessor(Board board, int row) {
  ArrayList<Board> children = new ArrayList<Board>();
  Board bestChild;

  for (int col = 0; col < board.getBoard().length; col++) {
    if (board.getBoard()[row][col] != 1) { // the element is not a queen
      int child[][] = new int[board.getBoard().length][board.getBoard().length];
      child[row][col] = 1; // move queen to this column

      for (int i = 0; i < child.length; i++) {
        if (i != row) {
          child[i] = board.getBoard()[i];
        }
      }
      children.add(new Board(child)); // create board object from the generated new board
      // add successor to children list
    }
  }

  bestChild = children.get(0);

  for (int z = 1; z < children.size(); z++) {
    int bestEv = bestChild.h;
    int nextEv = children.get(z).h;

    if (nextEv < bestEv) {
      bestChild = children.get(z);
    } else if (nextEv == bestEv) {
      Random rand = new Random();
      int choose = (int) (rand.nextInt(2));
      if (choose == 1) {
        bestChild = children.get(z);
      }
    }
  }

  return bestChild;
}
