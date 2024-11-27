# ALP-Cat-2

# 1) Overview of Each Program

## Question 1: Number Sign Detection Program

This Assembly program reads a number and classifies it as positive, negative, or zero using system calls.

### Assembling the Programm
the following codes were used to compile the code
- nasm -f elf32 -o q1.o q1.asm
- ld -m elf_i386 -o q1 q1.o
- ./q1

### Jump Instructions Documentation

1. **`je zero_case`**:
   - Jumps to `zero_case` if the input is "0".
   - Ensures that zero input is handled before any other checks.

2. **`je negative_case`**:
   - Jumps to `negative_case` if the input starts with a negative sign (`-`).
   - Directly handles negative numbers without further checks.

3. **`call check_positive`**:
   - Calls the `check_positive` subroutine to check if the input is positive.
   - Modularizes the positive number check.

4. **`jmp end_program`**:
   - Jumps to the end of the program after displaying the appropriate message.
   - Skips unnecessary checks after the result is printed.

5. **`jmp end_program` (second use)**:
   - Used after displaying the "ZERO" message to terminate the program.
   - Prevents further processing after handling zero input.


## Question 2: Array Manipulation with Looping and Reversal

### Objective
This program:
- Accepts an array of integers (5 digits) from the user.
- Reverses the array in place without using extra memory.
- Outputs the reversed array.

### Program Flow

#### 1. **Input Handling**
- The program prompts the user to enter a single digit (0-9) and stores the input in the `array` (5 positions). If invalid input is detected (i.e., non-digit input), the user is prompted again.

#### 2. **Reversal Process**
- After collecting 5 valid digits, the program uses two indices (`r12` and `r13`) to reverse the array **in place**:
  - `r12` starts at 0 (left index).
  - `r13` starts at 4 (right index).
  - The program swaps the elements at `r12` and `r13`, then increments `r12` and decrements `r13`, repeating the process until the indices meet or cross.

#### 3. **Printing the Reversed Array**
- The program then prints each digit in the reversed order, followed by a newline after each character.

#### 4. **Handling Invalid Input**
- If the input is invalid (not a digit), an error message is shown, and the program prompts for input again.

### Challenges with Memory Handling
- **Memory Access**: Directly accessing memory using indices (`[array + r12]`) requires careful management. The indices must be updated correctly to avoid accessing out-of-bounds memory or overwriting existing values.
- **Bounds Checking**: Assembly doesn't automatically check array bounds, so the program must manually handle indices to avoid memory corruption.
- **In-Place Reversal**: Reversing the array in place is memory-efficient, but care must be taken to correctly swap elements without using additional memory space.

### Key Instructions
- **`mov`**: Used to move data between registers and memory locations.
- **`cmp` and `jl`/`jg`**: Used to compare values and jump to appropriate sections (e.g., invalid input check or loop control).
- **`inc` and `dec`**: Used to modify the index pointers (`r12`, `r13`) during the reversal loop.

### Example Input/Output
- Input: `3 1 4 2 5`
- Output: `5 2 4 1 3`































