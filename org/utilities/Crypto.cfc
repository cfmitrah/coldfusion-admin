component output="false"{
	/**
		@created on 08/18/2013 by Aaron Benton :: Security init method
		@return Security
	*/
	public struct function init(){
		return this;
	}
	/**
		@created on 08/18/2013 by Aaron Benton :: Compute the hash
		@param password The password
		@param salt The salt, a secure random base64 string
		@param (Optional) iterations The number of times to hash is to be rehashed
		@param (Optional) algorithm The message digest alorigthm to use
		@return computed hash
	*/
	public string function compute(required string str, required string salt, numeric iterations=1024, string algorithm="SHA-512"){
		var hashed = "";
		hashed = lCase(hash(arguments.str & arguments.salt, arguments.algorithm, "UTF-8"));
		for(var i = 1; i <= iterations; i++){
			hashed = lCase(hash(hashed & arguments.salt, arguments.algorithm, "UTF-8"));
		}
		return hashed;
	}
	/**
		@created on 08/18/2013 by Aaron Benton :: Generates a base64 salt
		@param size The number of bytes to generate the salt
		@return salt
	*/
	public string function salt(numeric size=16){
		var byteType = createObject("java", "java.lang.Byte").TYPE;
		var bytes = createObject("java", "java.lang.reflect.Array").newInstance(byteType, size);
		var rand = createObject("java", "java.security.SecureRandom").nextBytes(bytes);
		bytes = toBase64(bytes);
		return bytes;
	}
	/**
		@created on 09/03/2013 by Aaron Benton :: Encrypt a string
		@param str The string to be encrypted
		@param (Optional) iterations The number of times to re-encrypt the string
		@param (Optional) algorithm The encryption alorigthm to use
		@param (Optional) encoding The binary encoding in which to represent the encrypted string
		@return encData
	*/
	public struct function encrypt(required string str, string key=salt(), numeric iterations=5, string algorithm="AES", string encoding="Base64"){
		var encData = {
			'encrypted' = arguments.str,
			'key' = arguments.key
		};
		for(var i = 1; i <= arguments.iterations; i++){
			encData['encrypted'] = encrypt(encData.encrypted, encData.key, arguments.algorithm, arguments.encoding);
		}
		encData['size'] = len(encData.encrypted);
		return encData;
	}
	/**
		@created on 09/03/2013 by Aaron Benton :: Decrypts a string
		@param str The string to be encrypted
		@param str The key to be used to decrypt the string
		@param (Optional) iterations The number of times the encryption was ran
		@param (Optional) algorithm The encryption alorigthm to use
		@param (Optional) encoding The binary encoding in which to represent the encrypted string
		@return decrypted string
	*/
	public string function decrypt(required string str, required string key, numeric iterations=5, string algorithm="AES", string encoding="Base64"){
		var decrypted = arguments.str;
		for(var i = 1; i <= arguments.iterations; i++){
			decrypted = decrypt(decrypted, arguments.key, arguments.algorithm, arguments.encoding);
		}
		return decrypted;
	}
}