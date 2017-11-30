#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define NUM 1000

int main(int argc, char** argv) {
    // create base string to compare
    char* pString = (char*)malloc(NUM * sizeof(char));
    // create string to compare
    char* myString = (char*)malloc(NUM * sizeof(char));

    // ok, let's read from screen our 2 screen
    scanf("%s%s", pString, myString);

    // pIndex is the index of character in pString
    int pIndex = 0;
    // myIndex is the index of character in myString
    int mIndex = 0;
    // found will record the position of myString when matched pString
    int found = 0;
    while (pString[pIndex] != '\0'){
        while (myString[mIndex] != '\0'){
          if (myString[mIndex] == pString[pIndex]){
            mIndex++;
            pIndex++;
          } else break;
        }
      if (mIndex == strlen(myString)) found = pIndex;
      mIndex = 0;
      pIndex++;
    }

    // print the position of last found myString in pString
    printf("%d", found);
    return 0;
}