# All the code (instructions) go after the .text Assembler directive
.text
    addi  $v0, $zero, 4 
    la $a0, MSG_INPUT 
    syscall 
    addi  $v0, $zero, 5 
    add $t0, $zero, $v0 
    syscall 
    addi  $v0, $zero, 4 
    la $a0, MSG_OUTPUT 
    syscall 
    addi  $v0, $zero, 1 
    add  $a0, $zero, $t0 
    syscall 
    addi  $v0, $zero, 10 
    syscall 

# All memory structure are placed after the .data Assembler directive:
.data
    # two (null terminated) strings:
    MSG_INPUT:  .asciiz "\nPlease enter an integer number: "
    MSG_OUTPUT: .asciiz "\nThe number you entered was: "