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
      // traversal the pString character, and each time, compare with myString
        while (myString[mIndex] != '\0'){
          // if myString character matched pString character
          // increase index of both
          // till the end of myString
          // if not reaching the end, which means unmatched, reset myString index and increase pString index
          if (myString[mIndex] == pString[pIndex]){
            mIndex++;
            pIndex++;
          } else {
            pIndex++;
            break;
          }
        }
        // after checking match, if mIndex equals to myString length
        // which means matched, record the position
        // 'cause we continuously searching, "found" at last will record the final position those two matched
      if (mIndex == strlen(myString)) found = pIndex - mIndex;
      mIndex = 0;
    }

    // print the position of last found myString in pString
    printf("%d", found);
    return 0;
}