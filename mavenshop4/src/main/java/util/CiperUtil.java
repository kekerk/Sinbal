package util;

import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CiperUtil {
	private static byte[] randomkey;
	private final static byte[] iv = new byte[] {
			(byte)0x8E,0x12,0x39,(byte)0x9C,
			      0x07,0x72,0x6F,(byte)0x5A,
			(byte)0x8E,0x12,0x39,(byte)0x9C,
			      0x07,0x72,0x6F,(byte)0x5A};
	static Cipher cipher;
	static {
		try {
/*
* AES : 암호 알고리즘 종류. 블럭단위 128비트임. 16바이트
* CBC : 블럭화 모드
* PKCS5Padding : 패딩 방식
*/
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	//암호화
	public static String encrypt(String plain, String key) {
		byte[] ciperMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key),"AES");
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);
			//Cipher.ENCRYPT_MODE : 암호화 모드
			cipher.init(Cipher.ENCRYPT_MODE, genkey, paramSpec);
			ciperMsg = cipher.doFinal(paddingString(plain).getBytes());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return byteToHex(ciperMsg).trim();
	}
	private static byte[] makeKey(String key) {
		int len = key.getBytes().length;
		char ch = 'A';
		for(int i=len; i<16; i++) {
			key += ch++;
		}
		byte[] keybyte = new byte[16];
		for(int i=0;i<16;i++) {
			keybyte[i] = key.getBytes()[i];
		}
		return keybyte;
	}
	//128비트단위로 블럭화홤.
	private static String paddingString(String plain) {
		char paddingChar = ' ';
		int size = 16;
		int x = plain.length() % size;
		int len = size - x;
		for(int i=0; i<len; i++) {
			plain += paddingChar;
		}
		return plain;
	}
	private static String byteToHex(byte[] ciperMsg) {
		if(ciperMsg == null) return null;
		int len = ciperMsg.length;
		String str = "";
		System.out.println(len);
		for(int i=0; i<len; i++) {
			//01010101
			//11111111
			if((ciperMsg[i]&0xFF) < 16)
				str += "0" + Integer.toHexString(ciperMsg[i]&0xFF);
			else
				str += Integer.toHexString(ciperMsg[i]&0xFF);
		}
		return str;
	}
	//복호화
	public static String decrypt(String ciper, String key) {
		byte[] plainMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);
			//Cipher.DECRYPT_MODE : 복호화 모드 설정
			cipher.init(Cipher.DECRYPT_MODE, genkey, paramSpec);
			plainMsg = cipher.doFinal(hexToByte(ciper.trim()));
		} catch(Exception e) {
			e.printStackTrace();
		}
		return new String(plainMsg).trim();
	}
	private static byte[] hexToByte(String str) {
		if(str == null) return null;
		if(str.length() < 2) return null;
		int len = str.length() / 2;
		byte[] buffer = new byte[len];
		for(int i=0; i<len; i++) {
			buffer[i] = (byte)Integer.parseInt(str.substring(i*2, i*2+2),16);
		}
		return buffer;
	}
}
