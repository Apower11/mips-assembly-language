.data
buffer_for_input_string: .space 100
buffer_for_processed_string: .space 100
prompt_for_input: .asciiz "Please enter your string:\n"
prompt_for_output: .asciiz "Your processed string is as follows:\n"

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

# reading the input string and putting it in the memory:
# the starting address of the string is accessible as buffer_for_input_string
# 100 is the hard-coded maximum length of the null-terminated string that is
# going to be read from the input. So effectively, up to 99 ascii characters.
li $v0, 8
la $a0, buffer_for_input_string
li $a1, 100
syscall

# >>>> MAKE YOUR CHANGES BELOW HERE:

# Looping over characters of the string:
la      $t0, buffer_for_input_string
la      $t1, buffer_for_processed_string
lb      $t2, 0($t0)
j checkfirstcharacter
Loop:
lb      $t2, 0($t0) 
# potentially do some processing on the character loaded in t2
beq     $t2, ' ', spacedetected
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop # keep going until you reach the end of the string, which is demarcated by the null character.
j EXIT

spacedetected:
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, checkadjacentcharacter

checkfirstcharacter:
bgt     $t2, 'a', checkiflowercase
beq     $t2, 'a', deletecharacter
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop

checkadjacentcharacter:
lb      $t2, 0($t0) 
bgt     $t2, 'a', checkiflowercase
beq     $t2, 'a', deletecharacter
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop

checkiflowercase:
blt     $t2, 'z', deletecharacter
beq     $t2, 'z', deletecharacter
bne     $t2, $zero, Loop

deletecharacter:
sb      $t2, 0($t1)
addi    $t0, $t0, 1
bne     $t2, $zero, checkwordnextcharacter

checkwordnextcharacter:
lb      $t2, 0($t0) 
beq     $t2, ' ', spacedetected
bgt     $t2, 'a', checkiflowercase2
beq     $t2, 'a', deletecharacter
bgt     $t2, 'A', checkifuppercase
beq     $t2, 'A', deletecharacter
bgt     $t2, '0', checkifnumber
beq     $t2, '0', deletecharacter
bne     $t2, $zero, Loop

checkiflowercase2:
blt    $t2, 'z', deletecharacter
beq    $t2, 'z', deletecharacter
bne    $t2, $zero, wordend
j EXIT

checkifuppercase:
blt    $t2, 'Z', deletecharacter
beq    $t2, 'Z', deletecharacter
bne    $t2, $zero, wordend
j EXIT

checkifnumber:
blt    $t2, '9', deletecharacter
beq    $t2, '9', deletecharacter
bne    $t2, $zero, wordend
j EXIT

wordend:
sb      $t2, 0($t1)
addi    $t0, $t0, 1
addi    $t1, $t1, 1
bne     $t2, $zero, Loop
j EXIT


EXIT:
# <<<< MAKE YOUR CHANGES ABOVE HERE

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the processed output
# note that v0 already holds 4, the syscall code for printing a string.
la $a0, buffer_for_processed_string
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit