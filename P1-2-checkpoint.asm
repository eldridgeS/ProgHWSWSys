#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW2-2
# Student Name: Eldridge Surianto
# Date: 10/5/24
#
#     I c o n   M a t c hou
#
# This routine determines which of eight candidate icons matches a pattern icon.
#
#===========================================================================
# CHANGE LOG: brief description of changes made from P1-2-shell.asm
# to this version of code.
# Date  Modification
# 10/04 Started working on asm code, just translating what I did in C
# 10/05 Reduce dynamic execution by precomputing start and end index of non-black pixels in pattern
#then only iterating through those indexes for candidates, then if all match check the black pixels
# the code works, but the average dynamic count is like above 1200 and static instructions also went overboard, I really need to rethink my strategy entirely
# The pattern always doesnt form around the edges, so I think I can take advantage of that to optimize
#I might also need to take advantage of the fact that one of the candidates is always correct, so I don't have
#to completely check the correct candidate, but rather rule out the others
# ...
# REPLACE the (example) lines with your own list of changes.
#===========================================================================

.data
CandBase: 	.alloc 1152
PatternBase:	.alloc 144

.text
IconMatch:	addi	$1, $0, CandBase	# point to base of Candidates
	############################################################
	#      For debugging only: set $2 to -1 before swi 584 to  #
	#      allow previously generated puzzle to be loaded in   #
	       #addi    $2, $0, -1              
	############################################################

	        swi	584			# generate puzzle icons
	
	############################################################
	
	# your code goes here
			addi    $2, $0, PatternBase     #Get base address of pattern

			addi    $3, $0, 0				#Initialize counter to find first non-black pixel in pattern
FindStart:	lw      $5, PatternBase($3)     #Get current pixel color from memory
			bne     $5, $0, Endindex       #if current pixel is not black, found start index and proceed to find end index
			addi    $3, $3, 4				#Increment counter if still black
			j       FindStart				#Continue next iteration if still black

Endindex:  addi     $4, $0, 572				#Initialize counter at last position of pattern
FindEnd:   lw       $5, PatternBase($4)     #Get current pixel from memory
		   bne      $5, $0, Main			#If current pixel is not black, found end index and proceed to Main
		   addi     $4, $4, -4				#decrement counter
		   j        FindEnd				#Continue next iteratio	n if still black


Main:      addi     $5, $0, 0               #Initialize an offset for the 7 iterations
		   addi     $11, $0, 0				#Intialize a counter for 7 iterations
NxtCand:   addi     $6, $3, 0               #Initialize counter pointer for pattern
		   add     $7, $3, $5 		        #Initialize counter pointer for candidate

Inner:	   slt      $10, $4, $6             #if current index exceeds endindex ($6 > $4), $10 = 1
		   bne      $10, $0, Outer          #if $10 = 1, inner matches, go to check outer
		   lw       $8, PatternBase($6)         #Get pattern color code
		   lw       $9, CandBase($7)        #Get candidate color code
		   bne      $8, $9, Mismatch        #if pixels dont match, go to next candidate

		   addi     $6, $6, 4               #increment counter for pattern
		   addi     $7, $7, 4               #increment counter for candidate
		   j        Inner

Mismatch:  addi     $5, $5, 576             #Increment counter to find next candidate base address
		   addi     $11, $11, 1
		   j        NxtCand                 #Go to next candidate

Outer:     add      $6, $5, $3              #Get starting index with offset address
	       addi     $7, $5, 0               #initialize counter for current pointer with offset

Front:	   beq      $7, $6, BackSetup       #If pointer has reached first non black pixel, proceed to check back
		   lw       $8, CandBase($7)        #get color at current pointer
		   bne      $8, $0, Mismatch        #if current pixel isnt black, mismatch is found, proceed to mismatch
		   addi     $7, $7, 4               #increment pointer for next pixel
		   j        Front                   #Loop back

BackSetup: add      $6, $5, $4              #Get ending index with offset
		   addi     $7, $5, 572             #Get address of last non black pixel

Back:      beq      $7, $6, Found           #If counter reached last non black pixel, Match found
           lw       $8, CandBase($7)        #get color at current pointer
		   bne      $8, $0, Mismatch        #if current pixel isnt black, mismatch is found, proceed to mismatch
		   addi     $7, $7, -4              #decrement pointer
		   j        Back                    #Loop back




Found:     addi    $2, $11, 0             # REPLACE: guess the first icon
		swi	544			# submit answer and check
		jr	$31			# return to caller
