pragma circom 2.1.5;
include "@zk-email/circuits/regexes/regex_helpers.circom";

template FromAddrRegex(msg_bytes) {
	signal input msg[msg_bytes];
	signal output out;

	var num_bytes = msg_bytes+1;
	signal in[num_bytes];
	in[0]<==128;
	for (var i = 0; i < msg_bytes; i++) {
		in[i+1] <== msg[i];
	}

	component eq[61][num_bytes];
	component lt[54][num_bytes];
	component and[65][num_bytes];
	component multi_or[23][num_bytes];
	signal states[num_bytes+1][19];
	component state_changed[num_bytes];

	states[0][0] <== 1;
	for (var i = 1; i < 19; i++) {
		states[0][i] <== 0;
	}

	for (var i = 0; i < num_bytes; i++) {
		state_changed[i] = MultiOR(18);
		lt[0][i] = LessThan(8);
		lt[0][i].in[0] <== 47;
		lt[0][i].in[1] <== in[i];
		lt[1][i] = LessThan(8);
		lt[1][i].in[0] <== in[i];
		lt[1][i].in[1] <== 58;
		and[0][i] = AND();
		and[0][i].a <== lt[0][i].out;
		and[0][i].b <== lt[1][i].out;
		lt[2][i] = LessThan(8);
		lt[2][i].in[0] <== 64;
		lt[2][i].in[1] <== in[i];
		lt[3][i] = LessThan(8);
		lt[3][i].in[0] <== in[i];
		lt[3][i].in[1] <== 91;
		and[1][i] = AND();
		and[1][i].a <== lt[2][i].out;
		and[1][i].b <== lt[3][i].out;
		lt[4][i] = LessThan(8);
		lt[4][i].in[0] <== 96;
		lt[4][i].in[1] <== in[i];
		lt[5][i] = LessThan(8);
		lt[5][i].in[0] <== in[i];
		lt[5][i].in[1] <== 123;
		and[2][i] = AND();
		and[2][i].a <== lt[4][i].out;
		and[2][i].b <== lt[5][i].out;
		eq[0][i] = IsEqual();
		eq[0][i].in[0] <== in[i];
		eq[0][i].in[1] <== 46;
		eq[1][i] = IsEqual();
		eq[1][i].in[0] <== in[i];
		eq[1][i].in[1] <== 95;
		and[3][i] = AND();
		and[3][i].a <== states[i][1];
		multi_or[0][i] = MultiOR(5);
		multi_or[0][i].in[0] <== and[0][i].out;
		multi_or[0][i].in[1] <== and[1][i].out;
		multi_or[0][i].in[2] <== and[2][i].out;
		multi_or[0][i].in[3] <== eq[0][i].out;
		multi_or[0][i].in[4] <== eq[1][i].out;
		and[3][i].b <== multi_or[0][i].out;
		lt[6][i] = LessThan(8);
		lt[6][i].in[0] <== 47;
		lt[6][i].in[1] <== in[i];
		lt[7][i] = LessThan(8);
		lt[7][i].in[0] <== in[i];
		lt[7][i].in[1] <== 58;
		and[4][i] = AND();
		and[4][i].a <== lt[6][i].out;
		and[4][i].b <== lt[7][i].out;
		lt[8][i] = LessThan(8);
		lt[8][i].in[0] <== 64;
		lt[8][i].in[1] <== in[i];
		lt[9][i] = LessThan(8);
		lt[9][i].in[0] <== in[i];
		lt[9][i].in[1] <== 91;
		and[5][i] = AND();
		and[5][i].a <== lt[8][i].out;
		and[5][i].b <== lt[9][i].out;
		lt[10][i] = LessThan(8);
		lt[10][i].in[0] <== 96;
		lt[10][i].in[1] <== in[i];
		lt[11][i] = LessThan(8);
		lt[11][i].in[0] <== in[i];
		lt[11][i].in[1] <== 123;
		and[6][i] = AND();
		and[6][i].a <== lt[10][i].out;
		and[6][i].b <== lt[11][i].out;
		eq[2][i] = IsEqual();
		eq[2][i].in[0] <== in[i];
		eq[2][i].in[1] <== 46;
		eq[3][i] = IsEqual();
		eq[3][i].in[0] <== in[i];
		eq[3][i].in[1] <== 95;
		and[7][i] = AND();
		and[7][i].a <== states[i][13];
		multi_or[1][i] = MultiOR(5);
		multi_or[1][i].in[0] <== and[4][i].out;
		multi_or[1][i].in[1] <== and[5][i].out;
		multi_or[1][i].in[2] <== and[6][i].out;
		multi_or[1][i].in[3] <== eq[2][i].out;
		multi_or[1][i].in[4] <== eq[3][i].out;
		and[7][i].b <== multi_or[1][i].out;
		multi_or[2][i] = MultiOR(2);
		multi_or[2][i].in[0] <== and[3][i].out;
		multi_or[2][i].in[1] <== and[7][i].out;
		states[i+1][1] <== multi_or[2][i].out;
		state_changed[i].in[0] <== states[i+1][1];
		eq[4][i] = IsEqual();
		eq[4][i].in[0] <== in[i];
		eq[4][i].in[1] <== 13;
		and[8][i] = AND();
		and[8][i].a <== states[i][0];
		and[8][i].b <== eq[4][i].out;
		eq[5][i] = IsEqual();
		eq[5][i].in[0] <== in[i];
		eq[5][i].in[1] <== 13;
		and[9][i] = AND();
		and[9][i].a <== states[i][4];
		and[9][i].b <== eq[5][i].out;
		multi_or[3][i] = MultiOR(2);
		multi_or[3][i].in[0] <== and[8][i].out;
		multi_or[3][i].in[1] <== and[9][i].out;
		states[i+1][2] <== multi_or[3][i].out;
		state_changed[i].in[1] <== states[i+1][2];
		eq[6][i] = IsEqual();
		eq[6][i].in[0] <== in[i];
		eq[6][i].in[1] <== 32;
		eq[7][i] = IsEqual();
		eq[7][i].in[0] <== in[i];
		eq[7][i].in[1] <== 34;
		and[10][i] = AND();
		and[10][i].a <== states[i][1];
		multi_or[4][i] = MultiOR(2);
		multi_or[4][i].in[0] <== eq[6][i].out;
		multi_or[4][i].in[1] <== eq[7][i].out;
		and[10][i].b <== multi_or[4][i].out;
		lt[12][i] = LessThan(8);
		lt[12][i].in[0] <== 47;
		lt[12][i].in[1] <== in[i];
		lt[13][i] = LessThan(8);
		lt[13][i].in[0] <== in[i];
		lt[13][i].in[1] <== 58;
		and[11][i] = AND();
		and[11][i].a <== lt[12][i].out;
		and[11][i].b <== lt[13][i].out;
		lt[14][i] = LessThan(8);
		lt[14][i].in[0] <== 64;
		lt[14][i].in[1] <== in[i];
		lt[15][i] = LessThan(8);
		lt[15][i].in[0] <== in[i];
		lt[15][i].in[1] <== 91;
		and[12][i] = AND();
		and[12][i].a <== lt[14][i].out;
		and[12][i].b <== lt[15][i].out;
		lt[16][i] = LessThan(8);
		lt[16][i].in[0] <== 96;
		lt[16][i].in[1] <== in[i];
		lt[17][i] = LessThan(8);
		lt[17][i].in[0] <== in[i];
		lt[17][i].in[1] <== 123;
		and[13][i] = AND();
		and[13][i].a <== lt[16][i].out;
		and[13][i].b <== lt[17][i].out;
		eq[8][i] = IsEqual();
		eq[8][i].in[0] <== in[i];
		eq[8][i].in[1] <== 32;
		eq[9][i] = IsEqual();
		eq[9][i].in[0] <== in[i];
		eq[9][i].in[1] <== 34;
		eq[10][i] = IsEqual();
		eq[10][i].in[0] <== in[i];
		eq[10][i].in[1] <== 46;
		eq[11][i] = IsEqual();
		eq[11][i].in[0] <== in[i];
		eq[11][i].in[1] <== 64;
		eq[12][i] = IsEqual();
		eq[12][i].in[0] <== in[i];
		eq[12][i].in[1] <== 95;
		and[14][i] = AND();
		and[14][i].a <== states[i][3];
		multi_or[5][i] = MultiOR(8);
		multi_or[5][i].in[0] <== and[11][i].out;
		multi_or[5][i].in[1] <== and[12][i].out;
		multi_or[5][i].in[2] <== and[13][i].out;
		multi_or[5][i].in[3] <== eq[8][i].out;
		multi_or[5][i].in[4] <== eq[9][i].out;
		multi_or[5][i].in[5] <== eq[10][i].out;
		multi_or[5][i].in[6] <== eq[11][i].out;
		multi_or[5][i].in[7] <== eq[12][i].out;
		and[14][i].b <== multi_or[5][i].out;
		eq[13][i] = IsEqual();
		eq[13][i].in[0] <== in[i];
		eq[13][i].in[1] <== 32;
		eq[14][i] = IsEqual();
		eq[14][i].in[0] <== in[i];
		eq[14][i].in[1] <== 34;
		eq[15][i] = IsEqual();
		eq[15][i].in[0] <== in[i];
		eq[15][i].in[1] <== 64;
		and[15][i] = AND();
		and[15][i].a <== states[i][12];
		multi_or[6][i] = MultiOR(3);
		multi_or[6][i].in[0] <== eq[13][i].out;
		multi_or[6][i].in[1] <== eq[14][i].out;
		multi_or[6][i].in[2] <== eq[15][i].out;
		and[15][i].b <== multi_or[6][i].out;
		eq[16][i] = IsEqual();
		eq[16][i].in[0] <== in[i];
		eq[16][i].in[1] <== 32;
		eq[17][i] = IsEqual();
		eq[17][i].in[0] <== in[i];
		eq[17][i].in[1] <== 34;
		eq[18][i] = IsEqual();
		eq[18][i].in[0] <== in[i];
		eq[18][i].in[1] <== 64;
		and[16][i] = AND();
		and[16][i].a <== states[i][13];
		multi_or[7][i] = MultiOR(3);
		multi_or[7][i].in[0] <== eq[16][i].out;
		multi_or[7][i].in[1] <== eq[17][i].out;
		multi_or[7][i].in[2] <== eq[18][i].out;
		and[16][i].b <== multi_or[7][i].out;
		eq[19][i] = IsEqual();
		eq[19][i].in[0] <== in[i];
		eq[19][i].in[1] <== 32;
		eq[20][i] = IsEqual();
		eq[20][i].in[0] <== in[i];
		eq[20][i].in[1] <== 34;
		eq[21][i] = IsEqual();
		eq[21][i].in[0] <== in[i];
		eq[21][i].in[1] <== 64;
		and[17][i] = AND();
		and[17][i].a <== states[i][15];
		multi_or[8][i] = MultiOR(3);
		multi_or[8][i].in[0] <== eq[19][i].out;
		multi_or[8][i].in[1] <== eq[20][i].out;
		multi_or[8][i].in[2] <== eq[21][i].out;
		and[17][i].b <== multi_or[8][i].out;
		multi_or[9][i] = MultiOR(5);
		multi_or[9][i].in[0] <== and[10][i].out;
		multi_or[9][i].in[1] <== and[14][i].out;
		multi_or[9][i].in[2] <== and[15][i].out;
		multi_or[9][i].in[3] <== and[16][i].out;
		multi_or[9][i].in[4] <== and[17][i].out;
		states[i+1][3] <== multi_or[9][i].out;
		state_changed[i].in[2] <== states[i+1][3];
		eq[22][i] = IsEqual();
		eq[22][i].in[0] <== in[i];
		eq[22][i].in[1] <== 128;
		and[18][i] = AND();
		and[18][i].a <== states[i][0];
		and[18][i].b <== eq[22][i].out;
		eq[23][i] = IsEqual();
		eq[23][i].in[0] <== in[i];
		eq[23][i].in[1] <== 10;
		and[19][i] = AND();
		and[19][i].a <== states[i][2];
		and[19][i].b <== eq[23][i].out;
		multi_or[10][i] = MultiOR(2);
		multi_or[10][i].in[0] <== and[18][i].out;
		multi_or[10][i].in[1] <== and[19][i].out;
		states[i+1][4] <== multi_or[10][i].out;
		state_changed[i].in[3] <== states[i+1][4];
		eq[24][i] = IsEqual();
		eq[24][i].in[0] <== in[i];
		eq[24][i].in[1] <== 60;
		and[20][i] = AND();
		and[20][i].a <== states[i][1];
		and[20][i].b <== eq[24][i].out;
		eq[25][i] = IsEqual();
		eq[25][i].in[0] <== in[i];
		eq[25][i].in[1] <== 60;
		and[21][i] = AND();
		and[21][i].a <== states[i][3];
		and[21][i].b <== eq[25][i].out;
		eq[26][i] = IsEqual();
		eq[26][i].in[0] <== in[i];
		eq[26][i].in[1] <== 60;
		and[22][i] = AND();
		and[22][i].a <== states[i][12];
		and[22][i].b <== eq[26][i].out;
		eq[27][i] = IsEqual();
		eq[27][i].in[0] <== in[i];
		eq[27][i].in[1] <== 60;
		and[23][i] = AND();
		and[23][i].a <== states[i][15];
		and[23][i].b <== eq[27][i].out;
		multi_or[11][i] = MultiOR(4);
		multi_or[11][i].in[0] <== and[20][i].out;
		multi_or[11][i].in[1] <== and[21][i].out;
		multi_or[11][i].in[2] <== and[22][i].out;
		multi_or[11][i].in[3] <== and[23][i].out;
		states[i+1][5] <== multi_or[11][i].out;
		state_changed[i].in[4] <== states[i+1][5];
		eq[28][i] = IsEqual();
		eq[28][i].in[0] <== in[i];
		eq[28][i].in[1] <== 102;
		and[24][i] = AND();
		and[24][i].a <== states[i][4];
		and[24][i].b <== eq[28][i].out;
		states[i+1][6] <== and[24][i].out;
		state_changed[i].in[5] <== states[i+1][6];
		eq[29][i] = IsEqual();
		eq[29][i].in[0] <== in[i];
		eq[29][i].in[1] <== 45;
		and[25][i] = AND();
		and[25][i].a <== states[i][1];
		and[25][i].b <== eq[29][i].out;
		lt[18][i] = LessThan(8);
		lt[18][i].in[0] <== 47;
		lt[18][i].in[1] <== in[i];
		lt[19][i] = LessThan(8);
		lt[19][i].in[0] <== in[i];
		lt[19][i].in[1] <== 58;
		and[26][i] = AND();
		and[26][i].a <== lt[18][i].out;
		and[26][i].b <== lt[19][i].out;
		lt[20][i] = LessThan(8);
		lt[20][i].in[0] <== 64;
		lt[20][i].in[1] <== in[i];
		lt[21][i] = LessThan(8);
		lt[21][i].in[0] <== in[i];
		lt[21][i].in[1] <== 91;
		and[27][i] = AND();
		and[27][i].a <== lt[20][i].out;
		and[27][i].b <== lt[21][i].out;
		lt[22][i] = LessThan(8);
		lt[22][i].in[0] <== 96;
		lt[22][i].in[1] <== in[i];
		lt[23][i] = LessThan(8);
		lt[23][i].in[0] <== in[i];
		lt[23][i].in[1] <== 123;
		and[28][i] = AND();
		and[28][i].a <== lt[22][i].out;
		and[28][i].b <== lt[23][i].out;
		eq[30][i] = IsEqual();
		eq[30][i].in[0] <== in[i];
		eq[30][i].in[1] <== 45;
		eq[31][i] = IsEqual();
		eq[31][i].in[0] <== in[i];
		eq[31][i].in[1] <== 46;
		eq[32][i] = IsEqual();
		eq[32][i].in[0] <== in[i];
		eq[32][i].in[1] <== 95;
		and[29][i] = AND();
		and[29][i].a <== states[i][5];
		multi_or[12][i] = MultiOR(6);
		multi_or[12][i].in[0] <== and[26][i].out;
		multi_or[12][i].in[1] <== and[27][i].out;
		multi_or[12][i].in[2] <== and[28][i].out;
		multi_or[12][i].in[3] <== eq[30][i].out;
		multi_or[12][i].in[4] <== eq[31][i].out;
		multi_or[12][i].in[5] <== eq[32][i].out;
		and[29][i].b <== multi_or[12][i].out;
		lt[24][i] = LessThan(8);
		lt[24][i].in[0] <== 47;
		lt[24][i].in[1] <== in[i];
		lt[25][i] = LessThan(8);
		lt[25][i].in[0] <== in[i];
		lt[25][i].in[1] <== 58;
		and[30][i] = AND();
		and[30][i].a <== lt[24][i].out;
		and[30][i].b <== lt[25][i].out;
		lt[26][i] = LessThan(8);
		lt[26][i].in[0] <== 64;
		lt[26][i].in[1] <== in[i];
		lt[27][i] = LessThan(8);
		lt[27][i].in[0] <== in[i];
		lt[27][i].in[1] <== 91;
		and[31][i] = AND();
		and[31][i].a <== lt[26][i].out;
		and[31][i].b <== lt[27][i].out;
		lt[28][i] = LessThan(8);
		lt[28][i].in[0] <== 96;
		lt[28][i].in[1] <== in[i];
		lt[29][i] = LessThan(8);
		lt[29][i].in[0] <== in[i];
		lt[29][i].in[1] <== 123;
		and[32][i] = AND();
		and[32][i].a <== lt[28][i].out;
		and[32][i].b <== lt[29][i].out;
		eq[33][i] = IsEqual();
		eq[33][i].in[0] <== in[i];
		eq[33][i].in[1] <== 45;
		eq[34][i] = IsEqual();
		eq[34][i].in[0] <== in[i];
		eq[34][i].in[1] <== 46;
		eq[35][i] = IsEqual();
		eq[35][i].in[0] <== in[i];
		eq[35][i].in[1] <== 95;
		and[33][i] = AND();
		and[33][i].a <== states[i][7];
		multi_or[13][i] = MultiOR(6);
		multi_or[13][i].in[0] <== and[30][i].out;
		multi_or[13][i].in[1] <== and[31][i].out;
		multi_or[13][i].in[2] <== and[32][i].out;
		multi_or[13][i].in[3] <== eq[33][i].out;
		multi_or[13][i].in[4] <== eq[34][i].out;
		multi_or[13][i].in[5] <== eq[35][i].out;
		and[33][i].b <== multi_or[13][i].out;
		eq[36][i] = IsEqual();
		eq[36][i].in[0] <== in[i];
		eq[36][i].in[1] <== 45;
		and[34][i] = AND();
		and[34][i].a <== states[i][13];
		and[34][i].b <== eq[36][i].out;
		multi_or[14][i] = MultiOR(4);
		multi_or[14][i].in[0] <== and[25][i].out;
		multi_or[14][i].in[1] <== and[29][i].out;
		multi_or[14][i].in[2] <== and[33][i].out;
		multi_or[14][i].in[3] <== and[34][i].out;
		states[i+1][7] <== multi_or[14][i].out;
		state_changed[i].in[6] <== states[i+1][7];
		eq[37][i] = IsEqual();
		eq[37][i].in[0] <== in[i];
		eq[37][i].in[1] <== 114;
		and[35][i] = AND();
		and[35][i].a <== states[i][6];
		and[35][i].b <== eq[37][i].out;
		states[i+1][8] <== and[35][i].out;
		state_changed[i].in[7] <== states[i+1][8];
		eq[38][i] = IsEqual();
		eq[38][i].in[0] <== in[i];
		eq[38][i].in[1] <== 64;
		and[36][i] = AND();
		and[36][i].a <== states[i][7];
		and[36][i].b <== eq[38][i].out;
		states[i+1][9] <== and[36][i].out;
		state_changed[i].in[8] <== states[i+1][9];
		eq[39][i] = IsEqual();
		eq[39][i].in[0] <== in[i];
		eq[39][i].in[1] <== 111;
		and[37][i] = AND();
		and[37][i].a <== states[i][8];
		and[37][i].b <== eq[39][i].out;
		states[i+1][10] <== and[37][i].out;
		state_changed[i].in[9] <== states[i+1][10];
		eq[40][i] = IsEqual();
		eq[40][i].in[0] <== in[i];
		eq[40][i].in[1] <== 109;
		and[38][i] = AND();
		and[38][i].a <== states[i][10];
		and[38][i].b <== eq[40][i].out;
		states[i+1][11] <== and[38][i].out;
		state_changed[i].in[10] <== states[i+1][11];
		eq[41][i] = IsEqual();
		eq[41][i].in[0] <== in[i];
		eq[41][i].in[1] <== 64;
		and[39][i] = AND();
		and[39][i].a <== states[i][1];
		and[39][i].b <== eq[41][i].out;
		states[i+1][12] <== and[39][i].out;
		state_changed[i].in[11] <== states[i+1][12];
		eq[42][i] = IsEqual();
		eq[42][i].in[0] <== in[i];
		eq[42][i].in[1] <== 58;
		and[40][i] = AND();
		and[40][i].a <== states[i][11];
		and[40][i].b <== eq[42][i].out;
		states[i+1][13] <== and[40][i].out;
		state_changed[i].in[12] <== states[i+1][13];
		lt[30][i] = LessThan(8);
		lt[30][i].in[0] <== 47;
		lt[30][i].in[1] <== in[i];
		lt[31][i] = LessThan(8);
		lt[31][i].in[0] <== in[i];
		lt[31][i].in[1] <== 58;
		and[41][i] = AND();
		and[41][i].a <== lt[30][i].out;
		and[41][i].b <== lt[31][i].out;
		lt[32][i] = LessThan(8);
		lt[32][i].in[0] <== 64;
		lt[32][i].in[1] <== in[i];
		lt[33][i] = LessThan(8);
		lt[33][i].in[0] <== in[i];
		lt[33][i].in[1] <== 91;
		and[42][i] = AND();
		and[42][i].a <== lt[32][i].out;
		and[42][i].b <== lt[33][i].out;
		lt[34][i] = LessThan(8);
		lt[34][i].in[0] <== 96;
		lt[34][i].in[1] <== in[i];
		lt[35][i] = LessThan(8);
		lt[35][i].in[0] <== in[i];
		lt[35][i].in[1] <== 123;
		and[43][i] = AND();
		and[43][i].a <== lt[34][i].out;
		and[43][i].b <== lt[35][i].out;
		eq[43][i] = IsEqual();
		eq[43][i].in[0] <== in[i];
		eq[43][i].in[1] <== 45;
		eq[44][i] = IsEqual();
		eq[44][i].in[0] <== in[i];
		eq[44][i].in[1] <== 46;
		eq[45][i] = IsEqual();
		eq[45][i].in[0] <== in[i];
		eq[45][i].in[1] <== 95;
		and[44][i] = AND();
		and[44][i].a <== states[i][9];
		multi_or[15][i] = MultiOR(6);
		multi_or[15][i].in[0] <== and[41][i].out;
		multi_or[15][i].in[1] <== and[42][i].out;
		multi_or[15][i].in[2] <== and[43][i].out;
		multi_or[15][i].in[3] <== eq[43][i].out;
		multi_or[15][i].in[4] <== eq[44][i].out;
		multi_or[15][i].in[5] <== eq[45][i].out;
		and[44][i].b <== multi_or[15][i].out;
		eq[46][i] = IsEqual();
		eq[46][i].in[0] <== in[i];
		eq[46][i].in[1] <== 45;
		and[45][i] = AND();
		and[45][i].a <== states[i][12];
		and[45][i].b <== eq[46][i].out;
		lt[36][i] = LessThan(8);
		lt[36][i].in[0] <== 47;
		lt[36][i].in[1] <== in[i];
		lt[37][i] = LessThan(8);
		lt[37][i].in[0] <== in[i];
		lt[37][i].in[1] <== 58;
		and[46][i] = AND();
		and[46][i].a <== lt[36][i].out;
		and[46][i].b <== lt[37][i].out;
		lt[38][i] = LessThan(8);
		lt[38][i].in[0] <== 64;
		lt[38][i].in[1] <== in[i];
		lt[39][i] = LessThan(8);
		lt[39][i].in[0] <== in[i];
		lt[39][i].in[1] <== 91;
		and[47][i] = AND();
		and[47][i].a <== lt[38][i].out;
		and[47][i].b <== lt[39][i].out;
		lt[40][i] = LessThan(8);
		lt[40][i].in[0] <== 96;
		lt[40][i].in[1] <== in[i];
		lt[41][i] = LessThan(8);
		lt[41][i].in[0] <== in[i];
		lt[41][i].in[1] <== 123;
		and[48][i] = AND();
		and[48][i].a <== lt[40][i].out;
		and[48][i].b <== lt[41][i].out;
		eq[47][i] = IsEqual();
		eq[47][i].in[0] <== in[i];
		eq[47][i].in[1] <== 45;
		eq[48][i] = IsEqual();
		eq[48][i].in[0] <== in[i];
		eq[48][i].in[1] <== 46;
		eq[49][i] = IsEqual();
		eq[49][i].in[0] <== in[i];
		eq[49][i].in[1] <== 95;
		and[49][i] = AND();
		and[49][i].a <== states[i][14];
		multi_or[16][i] = MultiOR(6);
		multi_or[16][i].in[0] <== and[46][i].out;
		multi_or[16][i].in[1] <== and[47][i].out;
		multi_or[16][i].in[2] <== and[48][i].out;
		multi_or[16][i].in[3] <== eq[47][i].out;
		multi_or[16][i].in[4] <== eq[48][i].out;
		multi_or[16][i].in[5] <== eq[49][i].out;
		and[49][i].b <== multi_or[16][i].out;
		eq[50][i] = IsEqual();
		eq[50][i].in[0] <== in[i];
		eq[50][i].in[1] <== 45;
		and[50][i] = AND();
		and[50][i].a <== states[i][15];
		and[50][i].b <== eq[50][i].out;
		multi_or[17][i] = MultiOR(4);
		multi_or[17][i].in[0] <== and[44][i].out;
		multi_or[17][i].in[1] <== and[45][i].out;
		multi_or[17][i].in[2] <== and[49][i].out;
		multi_or[17][i].in[3] <== and[50][i].out;
		states[i+1][14] <== multi_or[17][i].out;
		state_changed[i].in[13] <== states[i+1][14];
		lt[42][i] = LessThan(8);
		lt[42][i].in[0] <== 47;
		lt[42][i].in[1] <== in[i];
		lt[43][i] = LessThan(8);
		lt[43][i].in[0] <== in[i];
		lt[43][i].in[1] <== 58;
		and[51][i] = AND();
		and[51][i].a <== lt[42][i].out;
		and[51][i].b <== lt[43][i].out;
		lt[44][i] = LessThan(8);
		lt[44][i].in[0] <== 64;
		lt[44][i].in[1] <== in[i];
		lt[45][i] = LessThan(8);
		lt[45][i].in[0] <== in[i];
		lt[45][i].in[1] <== 91;
		and[52][i] = AND();
		and[52][i].a <== lt[44][i].out;
		and[52][i].b <== lt[45][i].out;
		lt[46][i] = LessThan(8);
		lt[46][i].in[0] <== 96;
		lt[46][i].in[1] <== in[i];
		lt[47][i] = LessThan(8);
		lt[47][i].in[0] <== in[i];
		lt[47][i].in[1] <== 123;
		and[53][i] = AND();
		and[53][i].a <== lt[46][i].out;
		and[53][i].b <== lt[47][i].out;
		eq[51][i] = IsEqual();
		eq[51][i].in[0] <== in[i];
		eq[51][i].in[1] <== 46;
		eq[52][i] = IsEqual();
		eq[52][i].in[0] <== in[i];
		eq[52][i].in[1] <== 95;
		and[54][i] = AND();
		and[54][i].a <== states[i][12];
		multi_or[18][i] = MultiOR(5);
		multi_or[18][i].in[0] <== and[51][i].out;
		multi_or[18][i].in[1] <== and[52][i].out;
		multi_or[18][i].in[2] <== and[53][i].out;
		multi_or[18][i].in[3] <== eq[51][i].out;
		multi_or[18][i].in[4] <== eq[52][i].out;
		and[54][i].b <== multi_or[18][i].out;
		lt[48][i] = LessThan(8);
		lt[48][i].in[0] <== 47;
		lt[48][i].in[1] <== in[i];
		lt[49][i] = LessThan(8);
		lt[49][i].in[0] <== in[i];
		lt[49][i].in[1] <== 58;
		and[55][i] = AND();
		and[55][i].a <== lt[48][i].out;
		and[55][i].b <== lt[49][i].out;
		lt[50][i] = LessThan(8);
		lt[50][i].in[0] <== 64;
		lt[50][i].in[1] <== in[i];
		lt[51][i] = LessThan(8);
		lt[51][i].in[0] <== in[i];
		lt[51][i].in[1] <== 91;
		and[56][i] = AND();
		and[56][i].a <== lt[50][i].out;
		and[56][i].b <== lt[51][i].out;
		lt[52][i] = LessThan(8);
		lt[52][i].in[0] <== 96;
		lt[52][i].in[1] <== in[i];
		lt[53][i] = LessThan(8);
		lt[53][i].in[0] <== in[i];
		lt[53][i].in[1] <== 123;
		and[57][i] = AND();
		and[57][i].a <== lt[52][i].out;
		and[57][i].b <== lt[53][i].out;
		eq[53][i] = IsEqual();
		eq[53][i].in[0] <== in[i];
		eq[53][i].in[1] <== 46;
		eq[54][i] = IsEqual();
		eq[54][i].in[0] <== in[i];
		eq[54][i].in[1] <== 95;
		and[58][i] = AND();
		and[58][i].a <== states[i][15];
		multi_or[19][i] = MultiOR(5);
		multi_or[19][i].in[0] <== and[55][i].out;
		multi_or[19][i].in[1] <== and[56][i].out;
		multi_or[19][i].in[2] <== and[57][i].out;
		multi_or[19][i].in[3] <== eq[53][i].out;
		multi_or[19][i].in[4] <== eq[54][i].out;
		and[58][i].b <== multi_or[19][i].out;
		multi_or[20][i] = MultiOR(2);
		multi_or[20][i].in[0] <== and[54][i].out;
		multi_or[20][i].in[1] <== and[58][i].out;
		states[i+1][15] <== multi_or[20][i].out;
		state_changed[i].in[14] <== states[i+1][15];
		eq[55][i] = IsEqual();
		eq[55][i].in[0] <== in[i];
		eq[55][i].in[1] <== 13;
		and[59][i] = AND();
		and[59][i].a <== states[i][14];
		and[59][i].b <== eq[55][i].out;
		eq[56][i] = IsEqual();
		eq[56][i].in[0] <== in[i];
		eq[56][i].in[1] <== 13;
		and[60][i] = AND();
		and[60][i].a <== states[i][15];
		and[60][i].b <== eq[56][i].out;
		eq[57][i] = IsEqual();
		eq[57][i].in[0] <== in[i];
		eq[57][i].in[1] <== 13;
		and[61][i] = AND();
		and[61][i].a <== states[i][17];
		and[61][i].b <== eq[57][i].out;
		multi_or[21][i] = MultiOR(3);
		multi_or[21][i].in[0] <== and[59][i].out;
		multi_or[21][i].in[1] <== and[60][i].out;
		multi_or[21][i].in[2] <== and[61][i].out;
		states[i+1][16] <== multi_or[21][i].out;
		state_changed[i].in[15] <== states[i+1][16];
		eq[58][i] = IsEqual();
		eq[58][i].in[0] <== in[i];
		eq[58][i].in[1] <== 62;
		and[62][i] = AND();
		and[62][i].a <== states[i][14];
		and[62][i].b <== eq[58][i].out;
		eq[59][i] = IsEqual();
		eq[59][i].in[0] <== in[i];
		eq[59][i].in[1] <== 62;
		and[63][i] = AND();
		and[63][i].a <== states[i][15];
		and[63][i].b <== eq[59][i].out;
		multi_or[22][i] = MultiOR(2);
		multi_or[22][i].in[0] <== and[62][i].out;
		multi_or[22][i].in[1] <== and[63][i].out;
		states[i+1][17] <== multi_or[22][i].out;
		state_changed[i].in[16] <== states[i+1][17];
		eq[60][i] = IsEqual();
		eq[60][i].in[0] <== in[i];
		eq[60][i].in[1] <== 10;
		and[64][i] = AND();
		and[64][i].a <== states[i][16];
		and[64][i].b <== eq[60][i].out;
		states[i+1][18] <== and[64][i].out;
		state_changed[i].in[17] <== states[i+1][18];
		states[i+1][0] <== 1 - state_changed[i].out;
	}

	component final_state_result = MultiOR(num_bytes+1);
	for (var i = 0; i <= num_bytes; i++) {
		final_state_result.in[i] <== states[i][18];
	}
	out <== final_state_result.out;

	signal is_consecutive[msg_bytes+1][2];
	is_consecutive[msg_bytes][1] <== 1;
	for (var i = 0; i < msg_bytes; i++) {
		is_consecutive[msg_bytes-1-i][0] <== states[num_bytes-i][18] * (1 - is_consecutive[msg_bytes-i][1]) + is_consecutive[msg_bytes-i][1];
		is_consecutive[msg_bytes-1-i][1] <== state_changed[msg_bytes-i].out * is_consecutive[msg_bytes-1-i][0];
	}
	signal is_substr0[msg_bytes][15];
	signal is_reveal0[msg_bytes];
	signal output reveal0[msg_bytes];
	for (var i = 0; i < msg_bytes; i++) {
		is_substr0[i][0] <== 0;
		is_substr0[i][1] <== is_substr0[i][0] + states[i+1][5] * states[i+2][7];
		is_substr0[i][2] <== is_substr0[i][1] + states[i+1][13] * states[i+2][7];
		is_substr0[i][3] <== is_substr0[i][2] + states[i+1][1] * states[i+2][7];
		is_substr0[i][4] <== is_substr0[i][3] + states[i+1][7] * states[i+2][9];
		is_substr0[i][5] <== is_substr0[i][4] + states[i+1][13] * states[i+2][1];
		is_substr0[i][6] <== is_substr0[i][5] + states[i+1][12] * states[i+2][15];
		is_substr0[i][7] <== is_substr0[i][6] + states[i+1][7] * states[i+2][7];
		is_substr0[i][8] <== is_substr0[i][7] + states[i+1][15] * states[i+2][15];
		is_substr0[i][9] <== is_substr0[i][8] + states[i+1][1] * states[i+2][1];
		is_substr0[i][10] <== is_substr0[i][9] + states[i+1][15] * states[i+2][14];
		is_substr0[i][11] <== is_substr0[i][10] + states[i+1][9] * states[i+2][14];
		is_substr0[i][12] <== is_substr0[i][11] + states[i+1][14] * states[i+2][14];
		is_substr0[i][13] <== is_substr0[i][12] + states[i+1][1] * states[i+2][12];
		is_substr0[i][14] <== is_substr0[i][13] + states[i+1][12] * states[i+2][14];
		is_reveal0[i] <== is_substr0[i][14] * is_consecutive[i][1];
		reveal0[i] <== in[i+1] * is_reveal0[i];
	}
}