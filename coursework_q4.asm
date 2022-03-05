.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

li  $s0, 0
li  $a1, 8
LOOP: 
li  $v0, 5
syscall 
div $v0, $a1
mfhi $a2
mflo $v1
beq $a2, 0, ADDTOSUM
bne $v0, $zero, LOOP
j EXIT

ADDTOSUM:
addu    $s0, $s0, $v0
bne $v0, $zero, LOOP
j EXIT

EXIT:
# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $s0
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit