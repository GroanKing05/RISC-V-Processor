addi x5, x0, 63                          # 0x03f00293
add x5, x5, x5                           # 0x005282b3
sub x6, x0, x5                           # 0x40500333
sd x6, 17(x0)                            # 0x006038a3
ld x7, 17(x0)                            # 0x01103383
add x8, x5, x5                           # 0x00528433
sd x7, 0(x8)                             # 0x00743023
ld x9, 0(x8)                             # 0x00043483
addi x10, x0, 17                         # 0x01100513
add x11, x10, x0                         # 0x000505b3
ld x12, 0(x11)                           # 0x0005b603
add x13, x5, x5                          # 0x005286b3
addi x31, x0, -1                         # 0xfff00f93
add x14, x13, x13                        # 0x00d68733
sub x15, x8, x5                          # 0x405407b3
add x16, x15, x14                        # 0x00e78833
add x17, x14, x15                        # 0x00f708b3
add x18, x16, x17                        # 0x01180933
add x18, x18, x17                        # 0x01190933
add x19, x18, x0                         # 0x000909b3
ld x20, 0(x11)                           # 0x0005ba03
sd x20, 121(x11)                         # 0x0745bca3
ld x21, 121(x11)                         # 0x0795ba83