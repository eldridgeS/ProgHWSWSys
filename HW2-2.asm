#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================
#
#     When Harry Met Sally
#
# HW2-2
# Your Name: Eldridge Surianto
# Date: 9/9/2024
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
	
.data
Harry:  .alloc  10            # allocate static space for 5 duration-city pairs
Sally:  .alloc  10            # allocate static space for 5 duration-city pairs

.text
WhenMet:	addi  $1, $0, Harry     # set memory base
        	swi     597             # create timelines and store them

		# your code goes here

.data
HarryArr: .alloc 30 # Allocate static space for Harry's location every year
SallyArr: .alloc 30 # Allocate static space for Sally's location every year

.text
# $5: number of years for each location iteration (Harry)
# $6: number of years for each location iteration (Sally)
# $7: City code for current iteration (Harry)
# $8: City code for current iteration (Sally)
# $9: counterH (initialize to 0)
# $10: counterS (initialize to 0)
# $11: index to load HarryArr (initialize to 0)
# $12: index to load SallyArr (initialize to 0)
# $13: index to get the address of Harry's location
# $14: index to get the address of Sally's location
# $15: a register to store 40, the end of the size of 10 arrays

addi $9, $0, 0 
addi $10, $0, 0
addi $11, $0, 0
addi $12, $0, 0
addi $15, $0, 40


#Loop to fill up Harry's timeline, location then year by year

FillHarry:	lw $5, Harry($11) #Load number of years
	addi $13, $11, 4 #Get address of city
	lw $7, Harry($13) # Load city code
	addi $11, $11, 8 #Preincrement to the next time-location pair in Harry


FillHarryLoop:	beq $5, $0, NextCityHarry #If finished with this city, move to next city
	sw $7, HarryArr($9) #Store city code into corresponding index
	addi $9, $9, 4 #Increment HarryArr index by 4 bits (next year)
	addi $5, $5, -1 #Decrement the number of years once filled
	j FillHarryLoop #Loop back to next year


NextCityHarry:	beq $11, $15, FillSally #If we have exceeded the index, we jump to filling Sally
	j FillHarry #If we have not exceeded the index, we go to the next city

#Loop to fill up Sally's timeline, location then year by year

FillSally:	lw $6, Sally($12) #Load number of years
	addi $14, $12, 4 #Get address of city
	lw $8, Sally($14) # Load city code
	addi $12, $12, 8 #Preincrement to the next time-location pair in Harry


FillSallyLoop:	beq $6, $0, NextCitySally #If finished with this city, move to next city
	sw $8, SallyArr($10) #Store city code into corresponding index
	addi $10, $10, 4 #Increment SallyArr index by 4 bits
	addi $6, $6, -1 #Decrement the number of years once year is filled
	j FillSallyLoop #Loop back to next year


NextCitySally:	beq $12, $15, FindMatch #If we have exceeded the index, we jump to finding a match
	j FillSally #If we have not exceeded the index, we go to the next city


FindMatch:	addi $16, $0, 1990 # Base year
	addi $17, $0, 0 #Initiate counter to iterate through 30 years
	addi $18, $0, 120 #Stopping index once all 30 years searched (30*4)
	addi $2, $0, 0 #default return answer is 0


CompareLoop:	beq $17, $18, End #when index exceeded (120), jump to end
	lw $19, HarryArr($17) #load Harry's location
	lw $20, SallyArr($17) #load Sally's location 
	beq $19, $20, MatchFound #if harry and sally's location match, jump to matchfound
	addi $17, $17, 4 #Increment the index to next year
	addi $16, $16, 1 #Increment the year number
	j CompareLoop


MatchFound:	add $2, $2, $16 #If match found, store answer year into $2

	
#        	addi  $2, $0, 0		# TEMP: (guess answer=0) REPLACE THIS

End:		swi   587		# give answer
                jr    $31               # return to caller
