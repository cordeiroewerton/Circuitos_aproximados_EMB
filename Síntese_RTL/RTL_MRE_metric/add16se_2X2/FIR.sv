module Fir3Tap (
  input  logic signed [15:0] x,
  output logic signed [15:0] y,
  input logic rstN, clk);

 	parameter [15:0] h[4:0] = '{16'd32, 16'd18, 16'd6, 16'd0, 16'd2}; // Alterar os valores dos pesos
  	logic signed [15:0] delay0, delay1, delay2, delay3, delay4, delay5, delay6, delay7, delay_aux;
  	logic signed [15:0] mul0Out, mul1Out, mul2Out, mul3Out, mul4Out, mul5Out, mul6Out, mul7Out, mul8Out;
  	logic signed [15:0] sum0Out, sum1Out, sum2Out, sum3Out, sum4Out, sum5Out, sum6Out, sum7Out;
	//logic signed [63:0] y_aux;
  
	always_ff @(posedge clk or negedge rstN) begin
    		if (!rstN) begin
			//Reset delays
			delay_aux <= 0;
			delay0	  <= 0;
      			delay1    <= 0;
      			delay2    <= 0;
			delay3	  <= 0;
      			delay4    <= 0;
      			delay5    <= 0;
			delay6	  <= 0;
			delay7	  <= 0;
		end
    		else begin
			//Set delay
      			delay_aux <= x;
			delay0    <= delay_aux;
      			delay1    <= delay0;
      			delay2    <= delay1;
      			delay3    <= delay2;
      			delay4    <= delay3;
      			delay5    <= delay4;
      			delay6    <= delay5;
      			delay7    <= delay6;
	
    		end
  	end

	always_comb begin
		//Set mult
		mul0Out = (h[4]) * delay_aux;
		mul1Out = (h[3]) * delay0;
		mul2Out = (h[2]) * delay1;
		mul3Out = (h[1]) * delay2;
		mul4Out = (-h[0]) * delay3;
		mul5Out = (h[1]) * delay4;
		mul6Out = (h[2]) * delay5;
		mul7Out = (h[3]) * delay6;
		mul8Out = (h[4]) * delay7;
	end

	//Set add
	add16se_2X2 u0(.A(mul0Out), .B(mul1Out), .O(sum0Out)); 
	add16se_2X2 u1(.A(mul2Out), .B(sum0Out), .O(sum1Out)); 
	add16se_2X2 u2(.A(mul3Out), .B(sum1Out), .O(sum2Out)); 
	add16se_2X2 u3(.A(mul4Out), .B(sum2Out), .O(sum3Out)); 
	add16se_2X2 u4(.A(mul5Out), .B(sum3Out), .O(sum4Out)); 
	add16se_2X2 u5(.A(mul6Out), .B(sum4Out), .O(sum5Out)); 
	add16se_2X2 u6(.A(mul7Out), .B(sum5Out), .O(sum6Out)); 
	add16se_2X2 u7(.A(mul8Out), .B(sum6Out), .O(sum7Out)); 

	assign y = sum7Out;

endmodule
