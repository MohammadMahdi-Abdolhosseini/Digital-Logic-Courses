inv
.protect
.Lib'mm90.L' tt
.unprotect
.option post=2
.param vdd=1.2
vdd vdd 0 vdd
Mn out in 0 0 nmos w=120nm L=100nm
Mp out in  vdd vdd  pmos w=240nm L=100nm
vin in 0 dc 0
.TRAN 10p 10n
.measure tran pow AVG power from=1ns to=10ns

.op
.end