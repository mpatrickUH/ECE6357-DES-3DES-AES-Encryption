clear all;clc;
% This script is the implementation of the DES encryption standards. 
% It uses the following in its implementation:
%-------------------------------------------------------------------------
% Variables:
%           plaintext = the generated plain text message to be encrypted
%           key = they encryption key
%           cipher = the returned cipher text
%           plain = the decrypted plain text
%-------------------------------------------------------------------------
% Acronym: TLS,TMC = Too Little Sleep, Too Much Caffeine  
%    TLS,TMC = I know this is obvious but just in case you are in a brain
%    fog, this explains what I'm doing in this part.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECE 6357 Cybersecurity, University of Houston 
% Spring 2021, class project
% Created by: K.M.Patrick Krueger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%LIST OF THE DATA SETS USED IN DEVELOPING AND TESTING THIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Test data 'xxx_01.mat','xxx_AExx.mat','xxx_WeakKeyxx.mat', and 'xxx_KeyCompxx.mat'
%taken from  
%https://academic.csuohio.edu/yuc/security/Chapter_06_Data_Encription_Standard.pdf
%       p155-163
%Test data 'xxx_02xx.mat' taken from
%   'Cryptography and Network Security, 5th ed', William Stallings. p 85-87
%Test data 'xxx_03.mat' (and a step by step walk through) taken from
%   http://page.math.tu-berlin.de/~kant/teaching/hess/krypto-ws2006/des.htm
%Test data 'xxx_04.mat' taken from
%   https://www.hanewin.net/encrypt/aes/aes-test.htm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('DES_Test_01.mat')
% load('DES_Test_02.mat')
% load('DES_Test_02_AE_KeyChg_a.mat')
% load('DES_Test_02_AE_KeyChg_b.mat')
% load('DES_Test_AE_a.mat')
% load('DES_Test_AE_b.mat')
% load('DES_Test_KeyComp_a.mat')
% load('DES_Test_KeyComp_b.mat')
% load('DES_Test_WeakKey_a.mat')
load('DES_Test_WeakKey_b.mat')

%Format the key and plaintext message into binary for the DES encryption.
%DES is a bitwise operation.
key = reshape(dec2bin(key,64).'-'0',1,64);
pt = reshape(dec2bin(pt,64).'-'0',1,64);

%Run the encryption/decryption back to back. This uses the FUNCTIONS
%encrypt/decrypt which are exactly the same as the scripts with the
%exception ... well, obviously ... with the exception that they are
%functions not stand alone scripts.

[ct] = DES_encrypt(pt,key);
[plain] = DES_decrypt(ct,key);



%Calculate the avalance effect 
AE = nnz(bitxor(pt,ct))*100/64;


%Output the original input message, ciphertext, recovered message, and key

disp(append('Input plaintext:     ',string(binaryVectorToHex(pt))))
disp(append('Output ciphertext:   ',string(binaryVectorToHex(ct))))
disp(append('Recovered plaintext: ',string(binaryVectorToHex(plain))))
disp(append('Key:                 ',string(binaryVectorToHex(key))))
disp('---------    ')
disp(append('Avalanche Effect:     ',string(AE),'%'))



% ptInComp = binaryVectorToHex(pt);
% ptOutCom - binaryVectorToHex(plain);
% for i = 1:16
%     if ptInComp(i) = ptOutCom(i)
%         AE(i) = 1;
%     else
%         AE(i) = 0;
%     end
% end








