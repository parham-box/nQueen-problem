int N = 8;

void setup(){
  size(1000, 1000); //size of the window
  background(255);//setting white background
  Board b = new Board(8);
  b.drawBoard();
  
}
