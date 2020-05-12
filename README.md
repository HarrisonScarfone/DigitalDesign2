# Digital Design 2

Hi Everyone, these are my projects for Digital Design 2. All labs received full marks.

## Note

Forgive the horrid formatting.  I also removed group member names from the files because in classic "group work" fashion,
I wrote them completely (hardware and tb) and am somewhat proud of my first open ended hardware design projects. 

## Disclaimer

I am not intending, by providing this, to facilitate cheating so please do not copy my solutions verbatim.
My hope is that by provding these solutions, you can gain some insight in how to approach VHDL design problems and maybe
learn some different ways to do (or NOT to do :P) certain things with an HDL.

## My Setup

I used Windows (I was more of a linux noob back then and didn't want to deal with FPGA board connectivity problems and
decided to take advantage of my dual boot) to run Quartus and Modelsim.  The first two projects I did not write a testbench
and built the simulation manually ("lol" - me now to me then).  Thanks to the help of stack exchange, I got test benches up
and running for Labs 3 and 4.

## Recommendations

Learn test benches.  Encapsulate all hardware functions you can by making seperate functions sensitive to trigger signals.
This makes your codemore readable and easier to troubleshoot.  Check out my Lab 4 for some cool ideas on that. Make use
of VHDLs concurrent execution!

Side Note: If you are a Windsor Engineer reading this, theres a 80% chance you dont format your code and write it in a block.
Please dont do that :)




