module win_detection(grid, winner);

input [1:0] grid [6:0] [6:0];

wire [9:0] CRD [59:0]; // [59:39]Column, [38:18]Row, [17:0]Diagonal;
wire [5:0] CRD_index;

output reg [1:0] winner;

			//split columns
			//first sub-column [59] in the first column [59:57]
			CRD[59][9:8] = grid[0][0];
			CRD[59][7:6] = grid[1][0];
			CRD[59][5:4] = grid[2][0];
			CRD[59][3:2] = grid[3][0];
			CRD[59][1:0] = grid[4][0];

			//second sub-column [58] in the first column [59:57]
			CRD[58][9:8] = grid[1][0];
			CRD[58][7:6] = grid[2][0];
			CRD[58][5:4] = grid[3][0];
			CRD[58][3:2] = grid[4][0];
			CRD[58][1:0] = grid[5][0];

			//third sub-column [57] in the first column [59:57]
			CRD[57][9:8] = grid[2][0];
			CRD[57][7:6] = grid[3][0];
			CRD[57][5:4] = grid[4][0];
			CRD[57][3:2] = grid[5][0];
			CRD[57][1:0] = grid[6][0];

			//first sub-column [56] in the second column [56:54]
			CRD[56][9:8] = grid[0][1];
			CRD[56][7:6] = grid[1][1];
			CRD[56][5:4] = grid[2][1];
			CRD[56][3:2] = grid[3][1];
			CRD[56][1:0] = grid[4][1];

			//second sub-column [55] in the second column [56:54]
			CRD[55][9:8] = grid[1][1];
			CRD[55][7:6] = grid[2][1];
			CRD[55][5:4] = grid[3][1];
			CRD[55][3:2] = grid[4][1];
			CRD[55][1:0] = grid[5][1];

			//third sub-column [54] in the second column [56:54]
			CRD[54][9:8] = grid[2][1];
			CRD[54][7:6] = grid[3][1];
			CRD[54][5:4] = grid[4][1];
			CRD[54][3:2] = grid[5][1];
			CRD[54][1:0] = grid[6][1];

			//first sub-column [53] in the third column [53:51]
			CRD[53][9:8] = grid[0][2];
			CRD[53][7:6] = grid[1][2];
			CRD[53][5:4] = grid[2][2];
			CRD[53][3:2] = grid[3][2];
			CRD[53][1:0] = grid[4][2];

			//second sub-column [52] in the third column [53:51]
			CRD[52][9:8] = grid[1][2];
			CRD[52][7:6] = grid[2][2];
			CRD[52][5:4] = grid[3][2];
			CRD[52][3:2] = grid[4][2];
			CRD[52][1:0] = grid[5][2];

			//third sub-column [51] in the third column [53:51]
			CRD[51][9:8] = grid[2][2];
			CRD[51][7:6] = grid[3][2];
			CRD[51][5:4] = grid[4][2];
			CRD[51][3:2] = grid[5][2];
			CRD[51][1:0] = grid[6][2];

			//first sub-column [50] in the fourth column [50:48]
			CRD[50][9:8] = grid[0][3];
			CRD[50][7:6] = grid[1][3];
			CRD[50][5:4] = grid[2][3];
			CRD[50][3:2] = grid[3][3];
			CRD[50][1:0] = grid[4][3];

			//second sub-column [49] in the fourth column [50:48]
			CRD[49][9:8] = grid[1][3];
			CRD[49][7:6] = grid[2][3];
			CRD[49][5:4] = grid[3][3];
			CRD[49][3:2] = grid[4][3];
			CRD[49][1:0] = grid[5][3];

			//third sub-column [48] in the fourth column [50:48]
			CRD[48][9:8] = grid[2][3];
			CRD[48][7:6] = grid[3][3];
			CRD[48][5:4] = grid[4][3];
			CRD[48][3:2] = grid[5][3];
			CRD[48][1:0] = grid[6][3];

			//first sub-column [47] in the fifth column [47:45]
			CRD[47][9:8] = grid[0][4];
			CRD[47][7:6] = grid[1][4];
			CRD[47][5:4] = grid[2][4];
			CRD[47][3:2] = grid[3][4];
			CRD[47][1:0] = grid[4][4];

			//second sub-column [46] in the fifth column [47:45]
			CRD[46][9:8] = grid[1][4];
			CRD[46][7:6] = grid[2][4];
			CRD[46][5:4] = grid[3][4];
			CRD[46][3:2] = grid[4][4];
			CRD[46][1:0] = grid[5][4];

			//third sub-column [45] in the fifth column [47:45]
			CRD[45][9:8] = grid[2][4];
			CRD[45][7:6] = grid[3][4];
			CRD[45][5:4] = grid[4][4];
			CRD[45][3:2] = grid[5][4];
			CRD[45][1:0] = grid[6][4];

			//first sub-column [44] in the sixth column [44:42]
			CRD[44][9:8] = grid[0][5];
			CRD[44][7:6] = grid[1][5];
			CRD[44][5:4] = grid[2][5];
			CRD[44][3:2] = grid[3][5];
			CRD[44][1:0] = grid[4][5];

			//second sub-column [43] in the sixth column [44:42]
			CRD[43][9:8] = grid[1][5];
			CRD[43][7:6] = grid[2][5];
			CRD[43][5:4] = grid[3][5];
			CRD[43][3:2] = grid[4][5];
			CRD[43][1:0] = grid[5][5];

			//third sub-column [42] in the sixth column [44:42]
			CRD[42][9:8] = grid[2][5];
			CRD[42][7:6] = grid[3][5];
			CRD[42][5:4] = grid[4][5];
			CRD[42][3:2] = grid[5][5];
			CRD[42][1:0] = grid[6][5];

			//first sub-column [41] in the seventh column [41:39]
			CRD[41][9:8] = grid[0][6];
			CRD[41][7:6] = grid[1][6];
			CRD[41][5:4] = grid[2][6];
			CRD[41][3:2] = grid[3][6];
			CRD[41][1:0] = grid[4][6];

			//second sub-column [40] in the seventh column [41:39]
			CRD[40][9:8] = grid[1][6];
			CRD[40][7:6] = grid[2][6];
			CRD[40][5:4] = grid[3][6];
			CRD[40][3:2] = grid[4][6];
			CRD[40][1:0] = grid[5][6];

			//third sub-column [39] in the seventh column [41:39]
			CRD[39][9:8] = grid[2][6];
			CRD[39][7:6] = grid[3][6];
			CRD[39][5:4] = grid[4][6];
			CRD[39][3:2] = grid[5][6];
			CRD[39][1:0] = grid[6][6];

			//split rows
			//first sub-row [38] in the first row [38:36]
			CRD[38][9:8] = grid[0][0];
			CRD[38][7:6] = grid[0][1];
			CRD[38][5:4] = grid[0][2];
			CRD[38][3:2] = grid[0][3];
			CRD[38][1:0] = grid[0][4];

			//second sub-row [37] in the first row [38:36]
			CRD[37][9:8] = grid[0][1];
			CRD[37][7:6] = grid[0][2];
			CRD[37][5:4] = grid[0][3];
			CRD[37][3:2] = grid[0][4];
			CRD[37][1:0] = grid[0][5];

			//third sub-row [36] in the first row [38:36]
			CRD[36][9:8] = grid[0][2];
			CRD[36][7:6] = grid[0][3];
			CRD[36][5:4] = grid[0][4];
			CRD[36][3:2] = grid[0][5];
			CRD[36][1:0] = grid[0][6];

			//first sub-row [35] in the second row [35:33]
			CRD[35][9:8] = grid[1][0];
			CRD[35][7:6] = grid[1][1];
			CRD[35][5:4] = grid[1][2];
			CRD[35][3:2] = grid[1][3];
			CRD[35][1:0] = grid[1][4];

			//second sub-row [34] in the second row [35:33]
			CRD[34][9:8] = grid[1][1];
			CRD[34][7:6] = grid[1][2];
			CRD[34][5:4] = grid[1][3];
			CRD[34][3:2] = grid[1][4];
			CRD[34][1:0] = grid[1][5];

			//third sub-row [33] in the second row [35:33]
			CRD[33][9:8] = grid[1][2];
			CRD[33][7:6] = grid[1][3];
			CRD[33][5:4] = grid[1][4];
			CRD[33][3:2] = grid[1][5];
			CRD[33][1:0] = grid[1][6];

			//first sub-row [32] in the third row [32:30]
			CRD[32][9:8] = grid[2][0];
			CRD[32][7:6] = grid[2][1];
			CRD[32][5:4] = grid[2][2];
			CRD[32][3:2] = grid[2][3];
			CRD[32][1:0] = grid[2][4];

			//second sub-row [31] in the third row [32:30]
			CRD[31][9:8] = grid[2][1];
			CRD[31][7:6] = grid[2][2];
			CRD[31][5:4] = grid[2][3];
			CRD[31][3:2] = grid[2][4];
			CRD[31][1:0] = grid[2][5];

			//third sub-row [30] in the third row [32:30]
			CRD[30][9:8] = grid[2][2];
			CRD[30][7:6] = grid[2][3];
			CRD[30][5:4] = grid[2][4];
			CRD[30][3:2] = grid[2][5];
			CRD[30][1:0] = grid[2][6];

			//first sub-row [29] in the fourth row [29:27]
			CRD[29][9:8] = grid[3][0];
			CRD[29][7:6] = grid[3][1];
			CRD[29][5:4] = grid[3][2];
			CRD[29][3:2] = grid[3][3];
			CRD[29][1:0] = grid[3][4];

			//second sub-row [28] in the fourth row [29:27]
			CRD[28][9:8] = grid[3][1];
			CRD[28][7:6] = grid[3][2];
			CRD[28][5:4] = grid[3][3];
			CRD[28][3:2] = grid[3][4];
			CRD[28][1:0] = grid[3][5];

			//third sub-row [27] in the fourth row [29:27]
			CRD[27][9:8] = grid[3][2];
			CRD[27][7:6] = grid[3][3];
			CRD[27][5:4] = grid[3][4];
			CRD[27][3:2] = grid[3][5];
			CRD[27][1:0] = grid[3][6];

			//first sub-row [26] in the fifth row [26:24]
			CRD[26][9:8] = grid[4][0];
			CRD[26][7:6] = grid[4][1];
			CRD[26][5:4] = grid[4][2];
			CRD[26][3:2] = grid[4][3];
			CRD[26][1:0] = grid[4][4];

			//second sub-row [25] in the fifth row [26:24]
			CRD[25][9:8] = grid[4][1];
			CRD[25][7:6] = grid[4][2];
			CRD[25][5:4] = grid[4][3];
			CRD[25][3:2] = grid[4][4];
			CRD[25][1:0] = grid[4][5];

			//third sub-row [24] in the fifth row [26:24]
			CRD[24][9:8] = grid[4][2];
			CRD[24][7:6] = grid[4][3];
			CRD[24][5:4] = grid[4][4];
			CRD[24][3:2] = grid[4][5];
			CRD[24][1:0] = grid[4][6];

			//first sub-row [23] in the sixth row [23:21]
			CRD[23][9:8] = grid[5][0];
			CRD[23][7:6] = grid[5][1];
			CRD[23][5:4] = grid[5][2];
			CRD[23][3:2] = grid[5][3];
			CRD[23][1:0] = grid[5][4];

			//second sub-row [22] in the sixth row [23:21]
			CRD[22][9:8] = grid[5][1];
			CRD[22][7:6] = grid[5][2];
			CRD[22][5:4] = grid[5][3];
			CRD[22][3:2] = grid[5][4];
			CRD[22][1:0] = grid[5][5];

			//third sub-row [21] in the sixth row [23:21]
			CRD[21][9:8] = grid[5][2];
			CRD[21][7:6] = grid[5][3];
			CRD[21][5:4] = grid[5][4];
			CRD[21][3:2] = grid[5][5];
			CRD[21][1:0] = grid[5][6];

			//first sub-row [20] in the seventh row [20:18]
			CRD[20][9:8] = grid[6][0];
			CRD[20][7:6] = grid[6][1];
			CRD[20][5:4] = grid[6][2];
			CRD[20][3:2] = grid[6][3];
			CRD[20][1:0] = grid[6][4];

			//second sub-row [19] in the seventh row [20:18]
			CRD[19][9:8] = grid[6][1];
			CRD[19][7:6] = grid[6][2];
			CRD[19][5:4] = grid[6][3];
			CRD[19][3:2] = grid[6][4];
			CRD[19][1:0] = grid[6][5];

			//third sub-row [18] in the seventh row [20:18]
			CRD[18][9:8] = grid[6][2];
			CRD[18][7:6] = grid[6][3];
			CRD[18][5:4] = grid[6][4];
			CRD[18][3:2] = grid[6][5];
			CRD[18][1:0] = grid[6][6];

			//split diagonal
			//first forward diagonal [17]
			CRD[17][9:8] = grid[4][0];
			CRD[17][7:6] = grid[3][1];
			CRD[17][5:4] = grid[2][2];
			CRD[17][3:2] = grid[1][3];
			CRD[17][1:0] = grid[0][4];

			//first forward sub-diagonal [16] in second diagonal [16:15]
			CRD[16][9:8] = grid[5][0];
			CRD[16][7:6] = grid[4][1];
			CRD[16][5:4] = grid[3][2];
			CRD[16][3:2] = grid[2][3];
			CRD[16][1:0] = grid[1][4];

			//second forward sub-diagonal [15] in second diagonal [16:15]
			CRD[15][9:8] = grid[4][1];
			CRD[15][7:6] = grid[3][2];
			CRD[15][5:4] = grid[2][3];
			CRD[15][3:2] = grid[1][4];
			CRD[15][1:0] = grid[0][5];

			//first forward sub-diagonal [14] in third diagonal [14:12]
			CRD[14][9:8] = grid[6][0];
			CRD[14][7:6] = grid[5][1];
			CRD[14][5:4] = grid[4][2];
			CRD[14][3:2] = grid[3][3];
			CRD[14][1:0] = grid[2][4];

			//second forward sub-diagonal [13] in third diagonal [14:12]
			CRD[13][9:8] = grid[5][1];
			CRD[13][7:6] = grid[4][2];
			CRD[13][5:4] = grid[3][3];
			CRD[13][3:2] = grid[2][4];
			CRD[13][1:0] = grid[1][5];

			//third forward sub-diagonal [12] in third diagonal [14:12]
			CRD[12][9:8] = grid[4][2];
			CRD[12][7:6] = grid[3][3];
			CRD[12][5:4] = grid[2][4];
			CRD[12][3:2] = grid[1][5];
			CRD[12][1:0] = grid[0][6];

			//first forward sub-diagonal [11] in fourth diagonal [11:10]
			CRD[11][9:8] = grid[6][1];
			CRD[11][7:6] = grid[5][2];
			CRD[11][5:4] = grid[4][3];
			CRD[11][3:2] = grid[3][4];
			CRD[11][1:0] = grid[2][5];

			//second forward sub-diagonal [10] in fourth diagonal [11:10]
			CRD[10][9:8] = grid[5][2];
			CRD[10][7:6] = grid[4][3];
			CRD[10][5:4] = grid[3][4];
			CRD[10][3:2] = grid[2][5];
			CRD[10][1:0] = grid[1][6];

			//fifth forward diagonal [9]
			CRD[9][9:8] = grid[6][2];
			CRD[9][7:6] = grid[5][3];
			CRD[9][5:4] = grid[4][4];
			CRD[9][3:2] = grid[3][5];
			CRD[9][1:0] = grid[2][6];

			//sixth backward diagonal [8]
			CRD[8][9:8] = grid[0][2];
			CRD[8][7:6] = grid[1][3];
			CRD[8][5:4] = grid[2][4];
			CRD[8][3:2] = grid[3][5];
			CRD[8][1:0] = grid[4][6];

			//first backward sub-diagonal [7] in seventh diagonal [7:6]
			CRD[7][9:8] = grid[1][2];
			CRD[7][7:6] = grid[2][3];
			CRD[7][5:4] = grid[3][4];
			CRD[7][3:2] = grid[4][5];
			CRD[7][1:0] = grid[5][6];

			//second backward sub-diagonal [6] in seventh diagonal [7:6]
			CRD[6][9:8] = grid[0][1];
			CRD[6][7:6] = grid[1][2];
			CRD[6][5:4] = grid[2][3];
			CRD[6][3:2] = grid[3][4];
			CRD[6][1:0] = grid[4][5];

			//first backward sub-diagonal [5] in eighth diagonal [5:3]
			CRD[5][9:8] = grid[2][2];
			CRD[5][7:6] = grid[3][3];
			CRD[5][5:4] = grid[4][4];
			CRD[5][3:2] = grid[5][5];
			CRD[5][1:0] = grid[6][6];

			//second backward sub-diagonal [4] in eighth diagonal [5:3]
			CRD[4][9:8] = grid[1][1];
			CRD[4][7:6] = grid[2][2];
			CRD[4][5:4] = grid[3][3];
			CRD[4][3:2] = grid[4][4];
			CRD[4][1:0] = grid[5][5];

			//third backward sub-diagonal [3] in eighth diagonal [5:3]
			CRD[3][9:8] = grid[0][0];
			CRD[3][7:6] = grid[1][1];
			CRD[3][5:4] = grid[2][2];
			CRD[3][3:2] = grid[3][3];
			CRD[3][1:0] = grid[4][4];

			//first backward sub-diagonal [2] in ninth diagonal [2:1]
			CRD[2][9:8] = grid[2][1];
			CRD[2][7:6] = grid[3][2];
			CRD[2][5:4] = grid[4][3];
			CRD[2][3:2] = grid[5][4];
			CRD[2][1:0] = grid[6][5];

			//second backward sub-diagonal [1] in ninth diagonal [2:1]
			CRD[1][9:8] = grid[1][0];
			CRD[1][7:6] = grid[2][1];
			CRD[1][5:4] = grid[3][2];
			CRD[1][3:2] = grid[4][3];
			CRD[1][1:0] = grid[5][4];

			//tenth backward diagonal [0]
			CRD[0][9:8] = grid[2][0];
			CRD[0][7:6] = grid[3][1];
			CRD[0][5:4] = grid[4][2];
			CRD[0][3:2] = grid[5][3];
			CRD[0][1:0] = grid[6][4];

			if (player == 2'b01)
			begin
				for (CRD_index = 0; CRD_index < 60; CRD_index = CRD_index + 1)
					if (CRD[CRD_index] == 10'b0101010101)
						winner <= 2'b01;
			end

			else if (player == 2'b10)
			begin
				for (CRD_index = 0; CRD_index < 60; CRD_index = CRD_index + 1)
					if (CRD[CRD_index] == 10'b1010101010)
						 winner <= 2'b10;
			end
endmodule
