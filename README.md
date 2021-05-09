ECE6357-DES Encryption

All .mat files are message/keys used to test the code. At this time, this code is not set up to be able to take any kind of input. It only takes hex message/keys but as far as I can tell it is working correctly.

DES.m - Used as a 1 shot to both encrypt/decrypt at the same time. Calls DES_encrypt.m & DES_decrypt.m

    DES_encrypt.m - The encryption as a function called by DES.m
    DES_decrypt.m - The decryption as a function called by DES.m

Stand alone versions used to find the time necessary for encryption/decryption. (Same as functions)

    DES_encrypt_.m
    DES_decrypt_.m

Support functions

    DES_d_initpermutation.m - decryption initial permutation
    DES_d_finalpermutation.m - decryption final permutation
    DES_fFxn.m - calculating the the f function to xor with the right side
    DES_finalPermutation.m - encryption final permutatoin
    DES_initPermutation.m - encryption initial permutation
    DES_keyPermShiftXfm.m - Permutation and compression of key, creating an array of all 6 keys
    DES.sBox.m - sBox transformation

Not Needed
    
    DES_keyTransform.m - Not used - was an initial effort that should have been deleted vs uploaded.
