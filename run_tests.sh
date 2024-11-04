#!/bin/bash
# Bash script to test student's code for the alternative
# squares method for ECE2035. 
# Written by Diego Fratta and AI
# Modified for IoU assignment

# Only current issue here is that you can't check for the newline, but students shouldn't
# be changing it...

# Set the paths and filenames for the source code and compiled executable
source_code="HW1-2.c"         
executable="HW1-2"            

# Compiler and compiler flags 
compiler="gcc"                          
compiler_flags="-Wall -g -o $executable"        

# Function to compile the code
compile_code() {
    $compiler $compiler_flags $source_code
}

# Function to run the compiled executable and capture the output
run_code() {
    ./$executable > program_output.txt
}

# Function to compare the program output with the test output
compare_output() {
    local program_output=$(cat program_output.txt)
    
    echo "---- Test $x ----"
    echo "Expected Output:"
    echo "Intersection over Union: YOUR ANSWER%"
    echo "Program Output:"
    echo "$program_output"
   
    if [ "${program_output:0:24}" = "Intersection over Union:" ]; then
        echo "Test passed! BEGINNING of output matches the expected test output, including the colon and space. The numeric IoU value IS NOT TESTED for accuracy."
    else
        echo "Test failed! Output does not match the expected test output."
    fi
}


# Main execution starts here
rm -f log.out # this removes the previous log file
compile_code
if [ $? -eq 0 ]; then
    run_code
    echo "Code compiled successfully!"
    compare_output | tee -a log.out # Check if it passed
else
    echo "Compilation failed. Please check your source code."
fi

echo "These tests do not represent the complete set of tests that will be run to grade your code." | tee -a log.out

# Cleanup temporary files
rm -f program_output.txt $executable
