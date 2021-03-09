.data  0x0000              		        
.text 0x0000						        
start:
		lui $v0,0xFFFF
		ori $v0,$v0,0xF000
		ori $t0,$zero,0xAAAA
		ori $t1,$zero,0xAAAA
		ori $t2,$zero,1
		
lop:	lw $a1,0xC72($v0)
		srl $a1,$a1,5
		beq $a1,$zero,case1			#000
		ori $a3,$zero,4
		beq $a1,$a3,case1			#100
		ori $a3,$zero,1
		beq $a1,$a3,case2			#001
		ori $a3,$zero,2
		beq $a1,$a3,case3			#010
		ori $a3,$zero,3
		beq $a1,$a3,case4			#011
		ori $a3,$zero,5
		beq $a1,$a3,case5			#101
		ori $a3,$zero,6
		beq $a1,$a3,case6			#110
		ori $a3,$zero,7
		beq $a1,$a3,case7			#111
case1:
		sw $t0,0xC60($v0)
		beq $t0,$t1,bran1
		ori $t0,$zero,0xAAAA
		j lop
bran1:	
		ori $t0,$zero,0x5555
		j lop
case2:
		lw $a0,0xC70($v0)
		j exit
case3:
		addi $a0,$a0,1
		j exit
case4:
		sub $a0,$a0,$t2
		j exit
case5:
		sll $a0,$a0,1
		j exit
case6:
		sra $a0,$a0,1
		j exit
case7:
		srl $a0,$a0,1
		j exit
exit:	
		sw $a0,0xC60($v0)
		j lop
		


