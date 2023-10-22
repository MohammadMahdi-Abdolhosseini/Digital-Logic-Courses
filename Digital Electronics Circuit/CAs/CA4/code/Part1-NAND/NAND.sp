* Circuit Extracted by Tanner Research's L-Edit Version 8.30 / Extract Version 8.30 ;
* TDB File:  E:\Science\Term 7\ElecDig_CA4_810198434\Part1-NAND\Layout_NAND.tdb
* Cell:  Cell0	Version 1.03
* Extract Definition File:  ..\..\CA4_Files\L-Edit\Tech\Part1\MHP_N05.EXT
* Extract Date and Time:  01/06/2023 - 20:02

* Warning:  Layers with Unassigned AREA Capacitance.
*   <allsubs>
*   <poly wire>
*   <Poly Resistor>
*   <LPNP collector>
*   <n well wire>
*   <LPNP emitter>
*   <P Diff Resistor>
*   <N Diff Resistor>
*   <N Well Resistor>
*   <subs>
*   <Metal1>
*   <Metal1-Tight>
*   <Metal2>
*   <Metal2-Tight>
* Warning:  Layers with Unassigned FRINGE Capacitance.
*   <Pad Comment>
*   <AllMetal1>
*   <allsubs>
*   <poly wire>
*   <ndiff>
*   <Poly Resistor>
*   <LPNP collector>
*   <n well wire>
*   <LPNP emitter>
*   <P Diff Resistor>
*   <pdiff>
*   <N Diff Resistor>
*   <N Well Resistor>
*   <subs>
*   <AllMetal2>
*   <Metal3>
*   <Metal1>
*   <Metal1-Tight>
*   <Metal2>
*   <Metal2-Tight>
* Warning:  Layers with Zero Resistance.
*   <Pad Comment>
*   <allsubs>
*   <cap using Cap-Well>
*   <poly wire>
*   <LPNP collector>
*   <n well wire>
*   <LPNP emitter>
*   <NMOS Capacitor>
*   <PMOS Capacitor>
*   <subs>
*   <Metal1>
*   <Metal1-Tight>
*   <Metal2>
*   <Metal2-Tight>

Cpar1 Out 0 C=213.165f
Cpar2 2 0 C=100.89f
Cpar3 Vss 0 C=219.123f
Cpar4 Vdd 0 C=265.5f
* Warning: Node B has zero nodal parasitic capacitance.
* Warning: Node A has zero nodal parasitic capacitance.

M1 Out A Vdd Vdd PMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M1 DRAIN GATE SOURCE BULK (-96.5 53.5 -91.5 62.5) 
M2 Out B Vdd Vdd PMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M2 DRAIN GATE SOURCE BULK (-40 53.5 -35 62.5) 
M3 2 A Out Vss NMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M3 DRAIN GATE SOURCE BULK (-111.5 19.5 -106.5 28.5) 
M4 2 B Vss Vss NMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M4 DRAIN GATE SOURCE BULK (-40 19.5 -35 28.5) 

* Total Nodes: 6
* Total Elements: 8
* Total Number of Shorted Elements not written to the SPICE file: 0
* Extract Elapsed Time: 0 seconds
.END
