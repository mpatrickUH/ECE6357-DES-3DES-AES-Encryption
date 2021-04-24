%Stand-alone encryption to test the timing
% This function implements the encryption stage of DES. 
%-------------------------------------------------------------------------
% Initial Permutation to transform the key into 56 bit vs 64, creating all 
% shifted keys needed for the 16 rounds of encrption at the same time. Also
% to do the permutation on the pt and output it as R/L blocks of 32 bits each
%-------------------------------------------------------------------------
% input:    pt = plain text
%           key = encryption key
% output:   ct = cipher text
% used:     e = encrypt
%           d = decrypt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;clc;
%LIST OF THE DATA SETS USED IN DEVELOPING AND TESTING THIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Test data 'xxx_01.mat' taken from
%   'Cryptography and Network Security, 5th ed', William Stallings. p 169-173
%Test data 'xxx_02.mat' taken from
%
%The rest taken from 
%   https://www.hanewin.net/encrypt/aes/aes-test.htm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('DES_Test_01.mat')
% load('DES_Test_02.mat')
% load('DES_Test_02_AE_KeyChg_a.mat')
% load('DES_Test_02_AE_KeyChg_b.mat')
% load('DES_Test_AE_a.mat')
% load('DES_Test_AE_b.mat')
load('DES_Test_KeyComp_a.mat')
% load('DES_Test_KeyComp_b.mat')
% load('DES_Test_WeakKey_a.mat')
% load('DES_Test_WeakKey_b.mat')


pt_in = pt;              %So the original pt value can be passed to the decrypt for output check 

%Format the key and plaintext message into binary for the DES encryption.
%DES is a bitwise operation.
key = reshape(dec2bin(key,64).'-'0',1,64);
pt = reshape(dec2bin(pt,64).'-'0',1,64);

%Get the party started.
key48 = DES_keyPermShiftXfm(key);                
[block_L, block_R] = DES_initPermutation(pt);    
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
    block_Rnew = bitxor(block_Rf,block_L);
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
ct = DES_finalPermutation(block_L, block_R);
%Save these values to feed into the decryption round and compare pt_in with pt_out.
save('DES_ciphertext_out','ct','key','pt_in');

%Output the initial plaintext, ciphertext, and key used to the screen in
%hex in a string format for cut/paste into reports.
% pt1 = reshape(dec2hex(bin2dec(reshape(pt,4,[])')),1,[]);
% key1 = reshape(dec2hex(bin2dec(reshape(key,4,[])')),1,[]);
disp(append('Input Plaintext:   ',string(binaryVectorToHex(pt))))
disp(append('output ciphertext: ',string(binaryVectorToHex(ct))))
disp(append('key:               ',string(binaryVectorToHex(key))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECE 6357 Cybersecurity, University of Houston 
% Spring 2021, class project
% Created by: K.M.Patrick Krueger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
