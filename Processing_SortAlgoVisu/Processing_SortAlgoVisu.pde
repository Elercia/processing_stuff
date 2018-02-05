//<>// //<>//
int[] array;
int numberOfElements = 1000;
int minValue, maxValue;
int n;
boolean fin = false;

int CurrentIndex = 0;

int count  =0;
void setup() {

  array = new int[numberOfElements];
  maxValue = 500;
  minValue = 0;

  for (int i = 0; i< numberOfElements; i++) {
    //array[i] = floor(random(minValue, maxValue));
    array[i] = (numberOfElements - i) % maxValue ;
  }
  n = array.length;
  size(1000, 1000);
}

void draw() {
  count++;
  background(255);
  stroke(0);

  if (!fin) {
    Bubblesort();
    
  }
  println(count);
  //delay(100);
}


void Bubblesort() {
  boolean swapped;
  
  try {
    do {
      swapped = false;
      for (int i = 1; i < n-1; i++) {
        CurrentIndex = i;
        if (array[i-1] > array[i]) {
          int tmp = array[i-1];
          array[i-1] = array[i];
          array[i] = tmp;

          swapped = true;
        }
        printIt();
      }
      
      n = n - 1;
    } while (!swapped);
  }
  catch(Exception e) {
    fin=  true;
  }
}

void printIt() {
  for (int i =0; i< numberOfElements; i++) {
    if (i == CurrentIndex) {
      stroke(255, 0, 0);
      strokeWeight(1.5);
    } else {
      stroke(0);
    }
    line(i, height/2, i, (height/2)-array[i]);
  }
}

void quickSort() {
  quiksort2(0, array.length);
}

void quiksort2(int first, int last) {
}