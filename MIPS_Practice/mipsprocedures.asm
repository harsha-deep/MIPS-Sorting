main:
addi $a0, $0, 2      # a0 = 2
addi $a1, $0, 3      # a1 = 3
addi $a2, $0, 4      # a2 = 4
addi $a3, $0, 5      # a3 = 5
jal diffofsums       # call the procedure diffofsums
add $s1, $v0, $0     # $s1 = $v0
addi $a0, $a1, 100


End:

diffofsums:
add $t0, $a0, $a1 # $t0 = 2 + 3
add $t1, $a2, $a3 # $t1 = 4 + 5
sub $t2, $t0, $t1 # $t2 = $t0 - $t1
add $v0, $t2, $0  # $v0 = $t2
jr $ra            #return to main
