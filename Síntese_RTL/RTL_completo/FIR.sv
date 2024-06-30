module Fir3Tap (
  input  logic signed [15:0] x,
  output logic signed [15:0] y,
  input logic rstN, clk);

 	parameter [15:0] h[4:0] = '{16'd6, 16'd12, 16'd16, 16'd20, 16'd106}; // Alterar os valores dos pesos
  	logic signed [15:0] delay0, delay1, delay2, delay3, delay4, delay5, delay6, delay7, delay_aux;
  	logic signed [15:0] sum0Out, sum1Out, sum2Out, sum3Out, sum4Out, sum5Out, sum6Out, sum7Out, sum8Out;
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
		sum0Out = ((-h[4]) * delay_aux);
		sum1Out = (h[3] * delay0) + sum0Out;
		sum2Out = ((-h[2]) * delay1) + sum1Out;
		sum3Out = (h[1] * delay2) + sum2Out;
		sum4Out = (h[0] * delay3) + sum3Out;
		sum5Out = (h[1] * delay4) + sum4Out;
		sum6Out = ((-h[2]) * delay5) + sum5Out;
		sum7Out = (h[3] * delay6) + sum6Out;
		sum8Out = ((-h[4]) * delay7) + sum7Out;
	end

	assign y = sum8Out;

endmodule
