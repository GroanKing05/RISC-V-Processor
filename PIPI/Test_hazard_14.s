addi x5, x0, 63
add x5, x5, x5
sub x6, x0, x5
sd x6, 17(x0)
ld x7, 17(x0)
add x8, x5, x5
sd x7, 0(x8)
ld x9, 0(x8)
addi x10, x0, 17
add x11, x10, x0
ld x12, 0(x11)
add x13, x5, x5
beq x13, x8, 4
addi x31, x0, -1
add x14, x13, x13
sub x15, x8, x5
add x16, x15, x14
add x17, x14, x15
add x18, x16, x17
add x18, x18, x17
add x19, x18, x0
ld x20, 0(x11)
sd x20, 121(x11)
ld x21, 121(x11)
sd x10, 1(x0)
ld x22, 1(x0)
sd x21, 1(x22)
ld x23, 1(x22)
ld x24, 121(x11)
sub x25, x0, x24
ld x26, 1(x0)
beq x10, x26, 4
sub x31, x0, x15
ld x27, 1(x0)
ld x28, 1(x27)
addi x29, x10, 1
add x0, x0, x0
ld x30, 0(x29)
add x0, x0, x0
add x4, x30, x30
add x0, x0, x0
add x0, x0, x0
add x1, x4, x0
add x0, x0, x0
add x0, x0, x0
add x0, x0, x0
add x0, x0, x0