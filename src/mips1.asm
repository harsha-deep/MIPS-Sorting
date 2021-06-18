#Written by Harshith(IMT2017516)
#email: Harshith.Reddy@iiitb.org

#run in linux terminal by java -jar Mars4_5.jar nc filename.asm(take inputs from console)

#system calls by MARS simulator:
#http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
.data
	next_line: .asciiz "\n"	
.text
#input: N= how many numbers to sort should be entered from terminal. 
#It is stored in $t1	
jal input_int 
move $t1,$t4			

#input: X=The Starting address of input numbers (each 32bits) should be entered from
# terminal in decimal format. It is stored in $t2
jal input_int
move $t2,$t4

#input:Y= The Starting address of output numbers(each 32bits) should be entered
# from terminal in decimal. It is stored in $t3
jal input_int
move $t3,$t4 

#input: The numbers to be sorted are now entered from terminal.
# They are stored in memory array whose starting address is given by $t2
move $t8,$t2
move $s7,$zero	#i = 0
loop1:  beq $s7,$t1,loop1end
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1
        j loop1      
loop1end: move $t2,$t8       
#############################################################
#Do not change any code above this line
#Occupied registers $t1,$t2,$t3. Don't use them in your sort function.
#############################################################
#function: should be written by students(sorting function)
#The below function adds 10 to the numbers. You have to replace this with
#your code

#### start of copying contents
move $t8,$t2 # X
move $t9,$t3 # Y
addi $s7,$0,0 # i = 0
loopy:		beq $s7,$t1,loopyend
		lw $a2,0($t2)
		sw $a2,0($t3)
		addi $t2,$t2,4
		addi $t3,$t3,4
		addi $s7,$s7,1
		j loopy
		
loopyend:	move $t2,$t8
		move $t3,$t9
		move $s7,$0
#### end of copying contents

#### start of sort part
move $s7,$0 # i = 0 
addi $t5,$0,1 # $t5 = 1
sub $t9,$t1,$t5 # $t9 = N - 1
loopouter:	beq $s7,$t9,loopouterend
		addi $s2,$0,0 # $s2 = 0 j = 0
		addi $t5,$s7,1 # $t5 = $s7 + 1 = i + 1
		sub $t7,$t1,$t5 # $t7 = N-i-1
		move $s1,$t3 # $s1 = Y
		loopinner:	beq $s2,$t7,loopinnerend
				addi $s3,$s1,4 # $s3 = Y + 4
				lw $a2,0($s1) # $a2 = Mem[Y] <=> arr[j]
				lw $a3,4($s1) # a3 = Mem[Y + 4] <=> arr[j + 1] Word aligned in MIPS.
				slt $t8,$a2,$a3 # if $a2 < $a3 $t8 = 1 else $t8 = 0
				beq $t8,$0,swap # if $t8 == 0 then goto swap
				
			loopinnercont:	addi $s1,$s1,4 # $s1 = $s1 + 4 goto next locations
					addi $s2,$s2,1 # increment inner loop counter (j++)
					j loopinner
			swap:	sw $a3,0($s1) # swapping Mem[Y] and Mem[Y + 4]
				sw $a2,0($s3)
				j loopinnercont # continue with inner loop
				
		        loopinnerend:   addi $s7,$s7,1 # increment inner loop counter (i++)
					j loopouter 
				
loopouterend:		
#### end of sort part.
#endfunction

#############################################################
#You need not change any code below this line
#print sorted numbers
move $s7,$zero	#i = 0
loop: beq $s7,$t1,end
      lw $t4,0($t3)
      jal print_int
      jal print_line
      addi $t3,$t3,4
      addi $s7,$s7,1
      j loop 
#end
end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#print integer(prints the value of $t6 )
print_int: li $v0,1		#1 implie
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra
