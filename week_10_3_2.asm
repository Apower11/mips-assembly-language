.text 	
    la  $s0, S0
    lw  $s0, 0($s0)             
    la  $s1, S1
    lw  $s1, 0($s1)
    la  $s2, S2
    lw  $s2, 0($s2)

    # your instructions to be inserted here!
    slt $t0, $s0, $s1
    bne $t0, $zero, PRINT_CHECKED
    slt $t0, $s1, $s2
    bne $t0, $zero, PRINT_CHECKED
    j SKIP 

    PRINT_CHECKED:
    addi  $v0, $zero, 4         
    la $a0, MSG_CHECKED          
    syscall                    

    SKIP:
    addi $v0, $zero, 10        
    syscall                    

.data
    MSG_CHECKED:  .asciiz "Checked!" 
    # some values are put here, vary them to make sure you are getting the expected result!  
    S0: .word   7 
    S1: .word   6
    S2: .word   1