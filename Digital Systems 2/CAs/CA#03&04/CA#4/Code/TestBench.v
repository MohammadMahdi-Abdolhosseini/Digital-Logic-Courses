



module TB;

    reg clk;


    MIPS mips(clk);


    always begin
        #1 clk = ~clk;
    end


    initial begin
    
    #100
    $stop;

    end



endmodule