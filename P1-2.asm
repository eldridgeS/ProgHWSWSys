#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# P1-2
# Student Name:Eldridge Surianto
# Date:10/7/24
#
#     I c o n   M a t c h
#
# This routine determines which of eight candidate icons matches a pattern icon.
#
#===========================================================================
# CHANGE LOG: brief description of changes made from P1-2-checkpoint.asm
# to this version of code.
# Date  Modification
# 10/07 Rethinking the strategy, instead of finding an exact match, I just need to rule out the rest
# So I will go through each pattern and count how many matches each pixel, if count = 1, pattern found
# Else, keep iterating
# Optimize it further by only searching colored tiles and skipping black tiles
# 10/08 Optimize code by decrementing to -1 instead of incrementing to 8, saving 1 register
# 10/09 optimize again by going to next pixel once count > 1, ~260 -> 220 for 1 static instruction
# 10/16 Added extra code to stop my code from causing an infinite loop when pattern index exceeds 576
# in that case, just return a random answer (~220 -> 270 dynamic, +2 static)
# Slightly optimized to stop the outer loop once counter reaches 0 instead of slt stuff (-1 static)
# 10/17 Radical rework of solution, now using bitwise solution, elimating options every iteration
# 10/18 Slight optimization to determine answer, but added 1 register
# Saved two registers by reusing since they get overrided anyways (Final Version)
#===========================================================================

.data
CandBase: 	.alloc 1152
PatternBase:	.alloc 144

.text
IconMatch:	addi	$1, $0, CandBase	# point to base address of Candidates
	############################################################
	#      For debugging only: set $2 to -1 before swi 584 to  #
	#      allow previously generated puzzle to be loaded in   #
    #   addi    $2, $0, -1              
	############################################################

	        swi	584			# generate puzzle icons
	
	############################################################
	# The follow is an example of how to use the debugging     #
	# swi 585 to highlight certain cells.                      #	
	
	# your code goes here
		    addi        $1, $0, -4                #while loop, first iteration will +4 to get 0th index
			addi        $3, $0, 576               #Constant needed for iterating later (144 * 4)
			addi        $11, $0, 255              #Bit storage that is used at the end to determine correct answer (1111 1111)
			addi        $6, $0, 7                 #Elimination counter, once 0 reached then match found
			addi        $2, $0, 28                #initialize answer counter (0+1+2+3+4+5+6+7)
			addi        $10, $0, -1               #constant to stop go to next pixel when all candidates checked

Main:       addi        $1, $1, 4                 #increment pattern counter
            lw          $4, PatternBase($1)       #Get color code of current index
			beq         $4, $0, Main              #If current color is black, continue, else check. (Black is too common)

			addi        $5, $0, 1                 #initialize a bit mask
			addi        $7, $0, 7                 #initialize counter to iterate through candidates (doing it backwards to save 1 register)

NewCand:    beq         $7, $10, Main             #When candidate index exceeds 0, go proceed to find next pixel
			and         $9, $11, $5              #if current index and bit mask both 1, $10 =/= 0
			beq         $9, $0, NextCand         #Skip to Next Candidate, else continue
            mult        $7, $3					  #multiply index with candidate size to get offset
			mflo        $8                        #get result from low register offset
			add         $8, $8, $1                #add offset to pattern index to get corresponding candidate index
			lw          $9, CandBase($8)          #Get color code of current candidate pixel
			beq         $9, $4, NextCand          #If match found, proceed to NextCand, else Eliminate
			xor         $11, $11, $5              #Turns 1 into 0 if mismatch
			sub         $2, $2, $7                #Deduct candidate index from answer pile
			addi        $6, $6, -1                #decrement elimination counter
			beq         $6, $0, Return             #if elimination counter reached 0, get answer

NextCand:   addi        $7, $7, -1                #decrement candidate index
			sll         $5, $5, 1                 #shift bitmask one bit to the left
			j           NewCand                   #go to next pixel
			

# End:        addi        $6, $0, 1
#             addi        $2, $0, 7
            
# Count:      beq         $11, $6, Return
#             srl         $11, $11, 1
# 			addi        $2, $2, -1
# 			j Count


Return: 	swi	544			# submit answer and check
		    jr	$31			# return to caller
