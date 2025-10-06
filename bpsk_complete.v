module bpsk_complete (
    input wire clk,
    input wire reset,
    output reg signed [15:0] sine_out,
    output reg [7:0] counter,
    output reg signed [15:0]bpsk,
    input reg rand_bit
);

reg signed [15:0] sine_table [0:255];
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        sine_table[i] = $rtoi($sin(2.0 * 3.14159 * i / 256.0) * 32767.0);
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) 
	begin
        counter <= 8'd0;
        sine_out <= 16'd0;
    	end 
    else 
	begin

		if(rand_bit==1)
		bpsk<=sine_table[counter];
		else if(rand_bit==0)
		bpsk<=(-sine_table[counter]);

        counter <= counter + 8'd1;
        sine_out <= sine_table[counter];
        end
end

endmodule


module bpsk_complete_tb;
    reg clk, reset;
    wire[7:0] counter;
    wire signed [15:0] sine_out;
    wire signed [15:0]bpsk;
    reg rand_bit;
   
    bpsk_complete dut (
        .clk(clk),
        .reset(reset),
        .sine_out(sine_out),
	.counter(counter),
	.bpsk(bpsk),
	.rand_bit(rand_bit)
    );
    always #5 clk = ~clk;
    
    initial begin
        
        clk = 0;
        reset = 1;
        
        #20 reset = 0;
        rand_bit=1; #2540
	rand_bit=0; #5080
	rand_bit=1; #2540
	rand_bit=0; #5080
	rand_bit=1; #2540
	rand_bit=0;
        $finish;
    end
endmodule