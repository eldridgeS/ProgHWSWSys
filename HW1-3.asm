#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW1-3
# Student Name:
# Date:
#
# This program computes the Intersection over Union of two rectangles
# as an integer representing a percent:
#                 Area(Intersection of R1 and R2) * 100
#  IoU =    -----------------------------------------------------
#           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)
#
# Assumptions for this homework:	
#  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
#  2. only R1's bottom left corner is inside R2, and only R2's top
#     right corner is inside R1.	
#
# Input: two bounding boxes, each specified as (Tx, Ty, Bx, By), where
#	 (Tx, Ty) is the upper left corner point and
#	 (Bx, By) is the lower right corner point.
# Output: IoU (an integer, 1 <= IoU <= 99).
#
# IoU should be specified as an integer (only the whole part of the division),
# i.e., round down to the nearest whole number between 1 and 99 inclusive.
#
# Also, for HW1 (only), do not write values to registers $0, $29, $30, or $31
# and do NOT use helper functions or function calls (JAL).
#
# FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
# MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

.data
# DO NOT change the following three labels (you may change the initial values):
#               Tx, Ty,  Bx, By	
R1:	.word	64, 51, 205, 210
R2:	.word	19, 65, 190, 326
IoU:	.alloc  1
	
.text
	# write your code here...
addi $1, $0, R1 # $1 holds address of first set of coordinates
lw $2, 0($1)  # $2 contains Tx1 (64)
lw $3, 4($1)  # $3 contains Ty1 (51)
lw $4, 8($1)  # $4 contains Bx1 (205)
lw $5, 12($1) # $5 contains By1 (210)

addi $6, $0, R2 # $6 holds address of second set of coordinates
lw $7, 0($6)  # $7 contains Tx2 (19)
lw $8, 4($6)  # $8 contains Ty2 (65)
lw $9, 8($6)  # $9 contains Bx2 (190)
lw $10, 12($6) # $10 contains By2 (326)

# Find the area of the original rectangles
# int areaR1 = (R1[2] - R1[0]) * (R1[3] - R1[1]);
sub $11, $4, $2 # $11 = Bx1 - Tx1 (141)
sub $12, $5, $3 # $12 = By1 - Ty1 (159)
mult $11, $12 # Multiply the two sides together
mflo $13 # $13 contains area of R1 (22419)

# int areaR2 = (R2[2] - R2[0]) * (R2[3] - R2[1]);
sub $14, $9, $7 # $14 = Bx2 - Tx2 (171)
sub $15, $10, $8 # $15 = By2 - Ty2 (261)
mult $14, $15 # Multiply both sides
mflo $16 # $16 contains area of R2 (44631)

# Find area of overlapping rectangle
sub $17, $9, $2 # $17 = length of overlap = Bx2 - Tx1 (126)
sub $18, $5, $8 # $18 = height of overlap = By1 - Ty2 (145)
mult $17, $18 # Multiply both sides
mflo $19 # $19 contains area of R3 (18270)

# IoU = (areaR3 * 100) / (areaR1 + areaR2 - areaR3);
#Compute denominator
add $20, $13, $16 # $20 = areaR1 + areaR2 (67050)
sub $21, $20, $19 # $21 = areaR1 + areaR2 - areaR3 (48780)
addi $22, $0, 100 # Store 100 in $22 (100)
mult $19, $22 # Compute areaR3 * 100
mflo $23 # $23 = areaR3 * 100 (1827000)
div $23, $21 #Compute IoU
mflo $24 # $24 = result (1827000/48780=37)

#Store IoU result in memory
#                # addi $25, $0, IoU # $25 contains address of IoU
sw $24, IoU($0) #Store result into IoU's address

# store it (an integer between 1 and 99, inclusive) in the memory location labeled IoU.

	

End:	jr $31	     			# return to OS

