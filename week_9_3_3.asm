#   code comes after the .text directive
.text
    addi  $s0, $zero, 0     # Loading s0 with an example value, 4 (so it should prompt "neither!")
    addi  $v0, $zero, 4     # syscall code for printing a string (will be reused throughout)

    beq $s0, $zero, IS_ZERO      
    addi  $t0, $zero, 1 
    la  $a0, MSG_ONE 
    beq $s0, $t0, IS_ONE 
    la  $a0, MSG_NEITHR 
    syscall 
    j EXIT 
 
 IS_ZERO:                
    la  $a0, MSG_ZERO 
    syscall 
    j EXIT 
    
 IS_ONE:                            
    syscall         
    j EXIT 
    
    EXIT:
    addi  $v0, $zero, 10    # Load the syscall to exit.
    syscall                 # Invoke the syscall to exit.

#   the memory structure comes after the .data directive 
.data
    MSG_ZERO:   .asciiz "it was zero!"
    MSG_ONE:    .asciiz "it was one!"
    MSG_NEITHR: .asciiz "it was neither!"