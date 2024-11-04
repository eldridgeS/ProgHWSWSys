#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW2-2
# Student Name:
# Date:
#
#     I c o n   M a t c h
#
# This routine determines which of eight candidate icons matches a pattern icon.
#
#===========================================================================
# CHANGE LOG: brief description of changes made from P1-2-shell.asm
# to this version of code.
# Date  Modification
# 09/12 Looping through pixels of an icon to find a nonblack one    (example)
# 09/13 Reduced avg # dynamic insts by precomputing ... before loop (example)
# 09/19 Fixed bug with loop bounds causing infinite loop.           (example)
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
	# The follow is an example of how to use the debugging     #
	# swi 585 to highlight certain cells.                      #
	# REMOVE THIS FROM YOUR CODE                               #
		addi    $2, $0, CandBase        # 0th icon, 0th cell
		swi     585
		addi    $2, $2, 20		# 0th icon, cell 5
		swi     585
		addi    $2, $0, PatternBase
		addi    $2, $2, 20		# pattern, cell 5
		swi     585
	# BESURE TO REMOVE ALL swi 585 DEBUGGING CODE before       #
	# submitting your code (otherwise it will count against    #
	# your static and dynamic instruction counts)              #
	############################################################
	
	
	# your code goes here

	
		# TEMP: replace this line to give your answer
                addi    $2, $0, 0               # REPLACE: guess the first icon
		swi	544			# submit answer and check
		jr	$31			# return to caller
