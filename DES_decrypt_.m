%Stand-alone decryption to test the timing
% This function implements the decryption stage of DES. 
%-------------------------------------------------------------------------
% Initial Permutation to transform the key into 56 bit vs 64, creating all 
% shifted keys needed for the 16 rounds of encrption at the same time. Also
% to do the permutation on the pt and output it as R/L blocks of 32 bits each
%-------------------------------------------------------------------------
% clear all;clc;
load('DES_ciphertext_out.mat');

[key48] = DES_d_keyPermShiftXfm(key);
[block_L, block_R] = DES_initPermutation(ct);
%-------------------------------------------------------------------------
% Begin the 16 rounds of encryption. Starting with key permutation and
% transformation, creating the f function, xor'ing it with the left
% block, then swapping the left and right blocks to start all over again.
%-------------------------------------------------------------------------
for i = 1:16
%-------------------------------------------------------------------------
% The f function: take the R side and combine it with the 48 bit key.
%-------------------------------------------------------------------------
 	block_Rf = DES_fFxn(block_R, key48(i,:));
%-------------------------------------------------------------------------
% XOR the output of the f function with the previous L 32 bits for the new
% R side 32 bit value
%-------------------------------------------------------------------------
    block_Rnew = xor(block_Rf,block_L);
%-------------------------------------------------------------------------
% Swap the blocks. The previous R side becomes the new L side and the newly
% XOR of the f function and previous L side becomes the new R side.
%-------------------------------------------------------------------------
   block_L = block_R;
   block_R = double(block_Rnew);
end
%-------------------------------------------------------------------------
% Final permutation
%-------------------------------------------------------------------------
pt = DES_finalPermutation(block_L, block_R);
 



disp(append('Input plaintext:     ',string(dec2hex(pt_in,16))))
disp(append('Output ciphertext:   ',string(binaryVectorToHex(ct))))
disp(append('Recovered plaintext: ',string(binaryVectorToHex(pt))))
disp(append('Key:                 ',string(binaryVectorToHex(key))))



%-------------------------------------------------------------------------
% input:    cipher = cipher text
%           key = encryption key
% output:   pt = plain text
% used:     e = encrypt
%           d = decrypt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECE 6357 Cybersecurity, University of Houston 
% Spring 2021, class project
% Created by: K.M.Patrick Krueger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




