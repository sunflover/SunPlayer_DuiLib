Description
==============
Version: 1.0.0 

NsisCrypt is a wrapper around Windows CryptoAPI libraries. It does various hashing and encryption algorithms alongside with base64 coding. 

Instructions:
- Copy NsisCrypt.dll to Plugins folder of Nsis - Read this readme and example files. 

Functions
==============

NsisCrypt::Hash
---------------------------
Hash the given string and returns base64 encoded hash result.The first parameter is the string to be hashed and the second is algorithm name, e.g. 'md5'. If you set NSIS user variable $1 to phrase 'ascii', the the string is hashed as an ASCII string, otherwise, the string is behaved like a unicode one. Result is pushed into stack, which is base64 return value, or an error message.Supported algorithms: md5, sha1, sha256, sha384, sha512 

Example: 
NsisCrypt::Hash "Test string" "md5"
Pop $1


NsisCrypt::Base64Encode
---------------------------
Encodes given string into base64 string.The given value can also be a binary array (can include zero).Usage is very simple, but as always you have to pop the return value (or possibly error). 

Example: 
NsisCrypt::Base64Encode "Test string"
Pop $1


NsisCrypt::Base64Decode
---------------------------
Decodes a given base64 encoded string into original string.Returned value may also be a binary array (can include zero).Usage is very simple, but as always you have to pop the return value (or possibly error). 

Example: 
NsisCrypt::Base64Decode "VGVzdCBzdHJpbmc="
Pop $1


NsisCrypt::EncryptSymmetric
---------------------------
Encrypts given string or binary array using specified symmetric algorithm, and then encodes the result into base64 string. As always you have to pop the result, which may be the return value or the error message.Supported algorithms: aes128, aes192, aes256, des, 3des 

NsisCrypt::EncryptSymmetric "string" "algorithm" "base64 encoded key" "base64 encoded iv" 

Example: 
NsisCrypt::EncryptSymmetric "test string" "3des" "doq5Eh/wmT6vWoVVyRpdPhMD9KNsWa0G" "EkjR1hOing8=" 
Pop $1


NsisCrypt::DecryptSymmetric
---------------------------
decrypts given base64 encoded cipher data to the original data using specified symmetric algorithm. As always you have to pop the result, which may be the return value or the error message.Supported algorithms: aes128, aes192, aes256, des, 3des 

NsisCrypt::DecryptSymmetric "base64 encoded cipher" "algorithm" "base64 encoded key" "base64 encoded iv" 

Example: 
NsisCrypt::DecryptSymmetric "lrnmILKaNUYh/z6ZAChWMg==" "3des" "doq5Eh/wmT6vWoVVyRpdPhMD9KNsWa0G" "EkjR1hOing8=" 
Pop $1


TODO
==============
Adding support for Asymmetric Encryption/Decryption algorithms. 
Adding support for using user or machine key containers. 


History
==============
3/16/20100 Released version 1.0.0. 

Retrieved from "http://nsis.sourceforge.net/NsisCrypt_plug-in"
