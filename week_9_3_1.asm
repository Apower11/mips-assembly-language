#   code comes after the .text directive
.text

    addi  $v0, $zero, 4     # to be requesting syscall 4, for printing strings
    la  $a0, MSG       # load the address of the starting byte of our string into $a0
    syscall            # print the string by issuing the syscall

    addi  $v0, $zero, 10    # Load the syscall to exit.
    syscall                 # Invoke the syscall to exit.

#   the memory structure comes after the .data directive
.data
    MSG:   .asciiz "QMUL!\n"  