//=================================================================
// Copyright 2024 Georgia Tech.  All rights reserved.
// The materials provided by the instructor in this course are for
// the use of the students currently enrolled in the course.
// Copyrighted course materials may not be further disseminated.
// This file must not be made publicly available anywhere.
//=================================================================

/*    
Please fill in the following
 Student Name: Eldridge Surianto 
 Date: 7 September 2024

ECE 2035 Homework 2-1

This is the only file that should be modified for the C implementation
of Homework 2.

Do not include any additional libraries.

FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

-----------------------------------------------

    When Harry Met Sally

This program finds the earliest year in which Harry and Sally live in the same
city.

This is the only file that should be modified for the C implementation
of Homework 2.

*/

#include <stdio.h>
#include <stdlib.h>

#define DEBUG 0 // RESET THIS TO 0 BEFORE SUBMITTING YOUR CODE

/* City IDs used in timelines. */
enum Cities{ London, Boston, Paris, Atlanta, Miami, 
             Tokyo, Metz, Seoul, Toronto, Austin };

int main(int argc, char *argv[]) {
   int	HarryTimeline[10];
   int	SallyTimeline[10];
   int	NumNums, Year;
   int  Load_Mem(char *, int *, int *);
   void Print_Timelines(int *, int *);

   if (argc != 2) {
     printf("usage: ./HW2-1 valuefile\n");
     exit(1);
   }
   NumNums = Load_Mem(argv[1], HarryTimeline, SallyTimeline);
   if (NumNums != 20) {
     printf("valuefiles must contain 20 entries\n");
     exit(1);
   }
   /* Use a statement like this in your code to print information helpful to
      debugging (e.g., the current value of some variable).
      Set DEBUG to 1 using the #define above when debugging, but
      reset it back to 0 before submitting your code so that your
      program doesn't confuse the autograder with superfluous prints. */
   if (DEBUG){
     printf("Sample debugging print statement. argc: %d \n", argc);
   }

   if (DEBUG)
     Print_Timelines(HarryTimeline, SallyTimeline);

   /* Your program goes here */

   //Create arrays of size 30 to store the corresponding location code of each year
   int HarryArr[30];
   int SallyArr[30];
   //initiate counters that we will use later to fill up the previously created arrays
   int counterH = 0;
   int counterS = 0;

    //iterate through the 5 cities in the list (odd indexes)
   for (int i = 1; i < 10; i += 2) {

    int HarryCity = HarryTimeline[i]; //get Harry's city in this iteration 
    int SallyCity = SallyTimeline[i]; //get Sally's city in this iteration

    //for each city, for the amount of years that each person was in that city
    //fill up the array. eg, if HarryTimeline contained [4,3,...]
    //Harry Arr would start with [3,3,3,3...]
    for (int j = 0; j < HarryTimeline[i - 1]; j++) {
      HarryArr[counterH++] = HarryCity;
    }
    for (int k = 0; k < SallyTimeline[i - 1]; k++) {
      SallyArr[counterS++] = SallyCity;
    }

   }

    Year = 0; //set default year value to 0 to return if no overlap

    //iterate through all 30 years, the 30 elements in our array
    for (int years = 0; years < 30; years++) {

      //if a match is found, we set Year to be 1990 + index and end the loop
      if (HarryArr[years] == SallyArr[years]) {
         Year = 1990 + years;  // First year when both are in the same city
         break;  // Stop the looping once we find the first match
      }
   }


   // DELETE THE FOLLOWING LINE. It assigns a temp value so shell code works.
   //Year = -999; //<-- delete this

   printf("Earliest year in which both lived in the same city: %d\n", Year);
   exit(0);
  
}

/* This routine loads in up to 20 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray1[], int IntArray2[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
     printf("%s could not be opened; check the filename\n", InputFileName);
     return 0;
   } else {
     for (N=0; N < 20; N++) {
       NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
       if (NumVals == 2)
	 if (N < 10)
	   IntArray1[N] = Value;
	 else
	   IntArray2[N-10] = Value;
       else
	 break;
     }
     fclose(FP);
     return N;
   }
}

/* Colors used to display timelines.
https://en.wikipedia.org/wiki/ANSI_escape_code#Colors */

const char *colors[10] = {"\x1b[30;41m", // red
			  "\x1b[30;42m", // green
			  "\x1b[30;43m", // yellow
			  "\x1b[30;44m", // blue
			  "\x1b[30;45m", // magenta
			  "\x1b[30;46m", // cyan (light blue)
			  "\x1b[30;47m", // white bkgd
			  "\x1b[30;103m", // bright yellow
			  "\x1b[30;104m", // bright blue
			  "\x1b[30;106m"}; // bright cyan

#define RESET      "\x1b[0m"

void Print_Years(){
  int i;
  printf("  ");
  for (i=90; i<120; i++){
    printf("%3d", i%100);
  }
  printf("\n");
}

void Print_Timeline(int Timeline[]){
  int j, duration, city;
  int scale = 3;
  char interval[6];
  for (j=0; j<10; j=j+2){
    duration = Timeline[j];
    city     = Timeline[j+1];
    snprintf(interval, sizeof(interval), "%%%dd", duration*scale);
    printf("%s", colors[city]); // start highlighting in city's color
    printf(interval, city);
  }
  printf(RESET); // stop highlighting
  printf("\n");
}


void Print_Timelines(int HarryTimeline[], int SallyTimeline[]) {
  Print_Years();
  printf("H: ");

  Print_Timeline(HarryTimeline);

  printf("S: ");
  Print_Timeline(SallyTimeline);
}

