# ALP-Cat-2

# Overview of Each Program

## Question 1: Number Sign Detection Program

This Assembly program reads a number and classifies it as positive, negative, or zero using system calls.

### Assembling the Program
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

### Assembling the Program
the following codes were used to compile the code
- nasm -f elf64 -o q2.o q2.asm
- ld -m elf_i386 -o q2 q2.o
- ./q2

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

## Question 3: Modular Program with Subroutines for Factorial Calculation

### Objective
This program:
- Accepts an integer input from the user.
- Computes the factorial of the input number using a separate subroutine.
- Uses the stack to preserve registers during the calculation.
- Places the final result in the `rax` register for output.

### Assembling the Program
the following codes were used to compile the code
- nasm -f elf64 -o q3.o q3.asm
- ld -m elf_i386 -o q3 q3.o
- ./q3

### Program Flow

#### 1. **Input Handling**
- The program prompts the user to enter an integer.
- The integer input is stored in the `rax` register for use in the factorial calculation.

#### 2. **Factorial Calculation Subroutine**
- The program calls the `factorial_sub` subroutine to compute the factorial:
  - The subroutine calculates the factorial iteratively by multiplying the current value in the `rax` register by the number stored in `rbx`.
  - It decrements `rbx` each time until it reaches 1.
  - The value of `rbx` is preserved by pushing it to the stack at the beginning and restoring it at the end.

#### 3. **Stack Management**
- **Preserving Registers**: Registers `rbx`, `rcx`, and `rdx` are pushed onto the stack to preserve their values during the factorial calculation.
- **Restoring Registers**: After the calculation, the values in `rbx`, `rcx`, and `rdx` are restored from the stack using `pop`.
- The final result is returned in the `rax` register, which is the standard register for returning function results.

#### 4. **Printing the Result**
- The factorial result stored in `rax` is converted to ASCII digits and printed using the `print_number` subroutine. Registers that are used for conversion are saved and restored to ensure no interference with the main program.

### Challenges with Register and Stack Management
- **Register Preservation**: Since assembly programs don’t automatically preserve registers, it's essential to manually push and pop registers to avoid conflicts between the main program and subroutines.
- **Register Conflicts**: If registers are not properly managed, the values might be overwritten, leading to incorrect results.

### Key Instructions
- **`push` and `pop`**: Used to save and restore register values to/from the stack.
- **`mov`**: Used to move data between registers and memory.
- **`cmp` and `jg`**: Used for comparison and conditional jumps, which control the flow of the factorial loop.
- **`mul`**: Used to perform multiplication in the factorial calculation.
- **`dec`**: Used to decrement the counter register (`rbx`) during the factorial calculation.

### Example Input/Output
- **Input**: `4`
- **Output**: `24`

## Question 4: Data Monitoring and Control Using Port-Based Simulation
### Objective
This program:
- Simulates a water level sensor reading from a memory location.
- Performs actions based on the sensor input, such as:
  - Turning on a motor.
  - Triggering an alarm if the water level is too high.
  - Stopping the motor if the water level is moderate.
- Uses memory locations to reflect the motor and alarm status.

### Assembling the Program
the following codes were used to compile the code
- nasm -f elf64 -o q4.o q4.asm
- ld -m elf_i386 -o q4 q4.o
- ./q4

### Program Flow

#### 1. **Reading Sensor Value**
- The program simulates reading a water level sensor value from a specified memory location (`sensor_value`).
- The sensor value represents the water level, and the program compares this value against two thresholds: **high threshold** (80) and **moderate threshold** (50).

#### 2. **Control Logic for Actions**
- Based on the sensor value, the program performs the following actions:
  - **High Water Level**: If the sensor value exceeds the high threshold, the program triggers the **alarm** and turns the **motor off**.
  - **Moderate Water Level**: If the sensor value is between the high and moderate thresholds (above 50 but below 80), the **motor is turned off**, and the **alarm is turned off**.
  - **Low Water Level**: If the sensor value is below the moderate threshold, the program **turns the motor on** and ensures the **alarm is off**.

#### 3. **Memory Locations for Status**
- **Motor Status**: The motor's status is stored in `motor_status db 0`. The motor is turned on (set to `1`) or off (set to `0`) based on the water level.
- **Alarm Status**: The alarm's status is stored in `alarm_status db 0`. If the water level exceeds the high threshold, the alarm is turned on (set to `1`). Otherwise, it is turned off (set to `0`).

#### 4. **Displaying the Action**
- After performing the appropriate action, the program outputs a message indicating the motor and alarm status:
  - "Motor ON" if the motor is turned on.
  - "Motor OFF" if the motor is turned off.
  - "ALARM ON" if the alarm is triggered.
  - "ALARM OFF" if the alarm is off.

#### **Challenges and Insights**

- **Memory Management**: Handling multiple sensors and ports requires efficient memory usage.
- **Motor/Alarm Control**: Lack of actuation limits; adding delays could improve component lifespan.
- **Real-Time Constraints**: The program doesn’t account for real-time performance.
- **Scalability**: The system is designed for one sensor; scaling requires better task management.



























