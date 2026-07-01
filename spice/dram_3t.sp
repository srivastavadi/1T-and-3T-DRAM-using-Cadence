* 3T DRAM cell - non-destructive read (ngspice)
* NM0 write access (WL), NM1 storage/read device (gate = storage node SN),
* NM2 read access (RL). BBL is the precharged read bit-line = OUT.
.include nmos_generic.inc
.param VDD=5 W=2u L=0.18u

Vdd vdd 0 {VDD}

NM0 BL  WL  SN  0 nmos w={W} l={L}
Csn SN  0   2f
NM1 n1  SN  0   0 nmos w={W} l={L}
NM2 BBL RL  n1  0 nmos w={W} l={L}
Rpre vdd BBL 10k

Vwl WL 0 PULSE(0 {VDD} 0 5n 5n 95n 200n)
Vbl BL 0 PULSE(0 {VDD} 0 5n 5n 95n 200n)
Vrl RL 0 PULSE(0 {VDD} 0 5n 5n 45n 100n)

.tran 0.5n 800n
.control
run
meas tran v_store MAX v(SN)
plot v(WL) v(RL) v(SN) v(BBL)
.endc
.end
