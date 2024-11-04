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
# Your Name:	
# Date:
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
	
        	addi  $2, $0, 0		# TEMP: (guess answer=0) REPLACE THIS

End:		swi   587		# give answer
                jr    $31               # return to caller
