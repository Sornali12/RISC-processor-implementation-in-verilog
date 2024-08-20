`include "MIPS32.v"
module mips32_prog2;
    reg clk1, clk2;
    integer k;

    MIPS32_Pipelined mips(clk1, clk2);

    initial
        begin
            clk1 = 0; clk2 = 0;
            repeat (20)
                begin
                    #5 clk1 = 1; #5 clk1 = 0;
                    #5 clk2 = 1; #5 clk2 = 0;
                end
        end

    initial
        begin
            for (k=0; k<31; k++)  // Putting values in registers
                mips.Reg[k] = 0;

            $readmemh("data_mem.txt",mips.Data_Mem,0,255);
            #10

            //for(k=0; k<256; k++)
                //$display("Data_Mem[%d]  = %h", k, mips.Data_Mem[k]);

            #50
            $readmemh("inst.txt",mips.Inst_Mem,0,7);
            //for(k=0; k<8; k++)
                //$display("Inst_Mem[%d]  = %h", k, mips.Inst_Mem[k]);
           //mips.Inst_Mem[0] = 32'h28010078;   // ADDI R1,R0,120
           //mips.Inst_Mem[1] = 32'h0c631800;   // OR R3,R3,R3 -- dummy instr.
           //mips.Inst_Mem[2] = 32'h20220000;   // LW R2,0(R1)
           //mips.Inst_Mem[3] = 32'h0c631800;   // OR R3,R3,R3 -- dummy instr.
           //mips.Inst_Mem[4] = 32'h2842002d;   // ADDI R2,R2,45
           //mips.Inst_Mem[5] = 32'h0c631800;   // OR R3,R3,R3 -- dummy instr.
           //mips.Inst_Mem[6] = 32'h24220001;   // SW R2,1(R1)
           //mips.Inst_Mem[7] = 32'hfc000000;   // HLT

           //mips.Data_Mem[120] = 32'd85;

            mips.PC = 0;
            mips.HALTED = 0;
            mips.TAKEN_BRANCH = 0;

            #500 $display("R2: %2d \nMem[120]: %h \nMem[121]: %h", mips.Reg[2], mips.Data_Mem[120], mips.Data_Mem[121]);

        end

    initial
        begin
            $dumpfile("prog2.vcd");
            $dumpvars (0, mips32_prog2);
            #600 $finish;
        end

endmodule