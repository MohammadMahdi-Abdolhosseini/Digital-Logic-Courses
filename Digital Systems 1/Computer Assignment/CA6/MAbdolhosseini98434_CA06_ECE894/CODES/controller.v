
module controller (input clk, rst, inReady, resultAccepted, mulRes47, startFP,
		output reg shiftCtrl, initM1, initM2, doneFP, resultReady, inAccept,
		output reg [7:0] bias);

	reg [2:0] presentState, nextState;
	parameter [2:0] Idle = 3'b000,
			GetAGetB = 3'b001,
			inputsAccepted = 3'b010,
			BEGIN = 3'b011,
			Add = 3'b100,
			MUL = 3'b101,
			Result = 3'b110;
	always @(presentState, resultAccepted, inReady, startFP) begin

		nextState = Idle;

		case (presentState)
			Idle:
				nextState = (inReady)? GetAGetB : Idle;
			GetAGetB:
				nextState = (inAccept)? inputsAccepted : GetAGetB;
			inputsAccepted:
				nextState = (inReady)? inputsAccepted : BEGIN;
			BEGIN:
				nextState = (startFP)? Add : BEGIN;
			Add:
				nextState = (startFP)? Add : MUL;
			MUL:
				nextState = Result;
			Result:
				nextState = (resultAccepted)? Idle : Result;
		endcase
	end

	always @(presentState, resultAccepted, inReady, startFP) begin

		shiftCtrl = 1'b0; initM1 = 1'b0; initM2 = 1'b0; doneFP = 1'b0;
		resultReady = 1'b0; inAccept = 1'b0; bias = 8'b01111111;


		case (presentState)
			GetAGetB: begin
				resultReady = 0;
				inAccept = 1;
			end
			BEGIN: begin
				doneFP = 0;
				inAccept = 0;
			end
			Add: begin
				bias = 8'b01111111; // dec: 127
			end
			MUL: begin
				initM1 = 1;
				initM2 = 1;
				shiftCtrl = mulRes47 ? 1:0;
			end
			Result: begin
				doneFP = 1;
				resultReady = 1;
			end
		endcase
	end

	always @(posedge clk, posedge rst) begin
		if (rst == 1)
			presentState <= Idle;
		else
			presentState <= nextState;
	end

endmodule

