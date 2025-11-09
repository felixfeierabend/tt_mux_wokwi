module mixer (
    input waveA,                // Channel A
    input waveB,                // Channel B
    input noise,                // LFSR-Input

    input[3:0] volumeA,         // Volume for Channel A
    input[3:0] volumeB,         // Volume for Channel B
    input[3:0] volumeNoise,     // Volume for Noise

    input[3:0] envA,            // Envelope for Channel A
    input[3:0] envB,            // Envelope for Channel B

    input enableA,              // Enable Channel A
    input enableB,              // Enable Channel B
    input enableNoise,          // Enable Noise-Channel

    output[7:0] mixout          // Mixer output for PWM
);

    wire[7:0] multA = volumeA * envA;
    wire[7:0] multB = volumeB * envB;

    // Calculate Values for channels
    wire[4:0] a_val = (enableA && waveA) ? multA[7:3] : 0;
    wire[4:0] b_val = (enableB && waveB) ? multB[7:3] : 0;
    wire[4:0] noise_val = (enableNoise && noise) ? {volumeNoise, 1'b0} : 0;

    // sum channels for output
    wire[5:0] sum = a_val + b_val + noise_val;

    // scale sum up to 8 bit
    assign mixout = {sum, 2'b00};
    
endmodule