`timescale 1ms/1ms
`include "./tt_top_level.v"

module tb_tt;
    
    reg [7:0] ui_in;
    wire [7:0] uo_out;
    reg [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg       ena;      
    reg       clk;      
    reg       rst_n;

    tt_um_felixfeierabend uut (
        .clk(clk),
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .rst_n(rst_n)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        ena = 0;
        ui_in = 8'h00;
        uio_in = 8'h00;

        $dumpfile("tb_tt.vcd");
        $dumpvars(0, tb_tt);

        #5 rst_n = 1;
        #10 ena = 1;
        $display("Starting stimulus loop...");

        #50 ui_in = 8b'1

        #200 $finish;
    end


endmodule