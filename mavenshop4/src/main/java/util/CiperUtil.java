package util;

import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CiperUtil {
	private final static byte[] iv = new byte[] { //초기화 백터
			(byte) 0x8E, 0x12, 0x39, (byte) 0x9C, 0x07, 0x72, 0x6F,
			(byte) 0x5A, 
			(byte) 0x8E, 0x12, 0x39, (byte) 0x9C, 0x07, 0x72, 0x6F, 
			(byte) 0x5A };

	static Cipher cipher;

	static {
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static byte[] makeKey(String key) {
		int len = key.length();
		char ch = 'A';
		for( int i=len;i<16;i++) {
			key += ch++;
		}
		return key.substring(0, 16).getBytes();
	}

	// 암호화
	public static String encrypt(String plain, String key) {
		byte[] ciperMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");// key 객체 생성
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv); //초기화 vector 객체 생성
			// Cipher.ENCRYPT_MODE : 암호화 모드
			cipher.init(Cipher.ENCRYPT_MODE, genkey, paramSpec);
			ciperMsg = cipher.doFinal(paddingString(plain).getBytes()); // paddingString(plain).getBytes() : byte형 배열
		} catch (Exception e) {
			e.printStackTrace();
		}
		return byteToHex(ciperMsg).trim();
	}

	private static String byteToHex(byte[] ciperMsg){
		if (ciperMsg == null)
			return null;
		int len = ciperMsg.length;
		String str = "";
		for (int i = 0; i < len; i++) {
			if ((ciperMsg[i] & 0xFF) < 16) { // (ciperMsg[i] & 0xFF) : 음수 일 경우 양수로 바꿔주기 위해 
				str += "0" + Integer.toHexString(ciperMsg[i] & 0xFF); //문자열 형태로 다시 만들어 줌
			} else {
				str += Integer.toHexString(ciperMsg[i] & 0xFF); //문자열 형태로 다시 만들어 줌
			}
		}
		return str;
	}

	private static String paddingString(String plain) {
		char paddingChar = ' ';
		int size = 16;
		int x = plain.length() % size; // ex) plain.length = 5
		int len = size - x;
		for (int i = 0; i < len; i++) {
			plain += paddingChar; //16바이트 중 모자란 부분을 공백 ' '으로 채움. 16바이트로 채워야함.  완벽한 블럭으로 만든다.
		}
		return plain;
	}

	// 복호화
	public static String decrypt(String ciper, String key) {
		byte[] plainMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES"); 
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);
			//Cipher.DECRYPT_MODE : 복호화
			cipher.init(Cipher.DECRYPT_MODE, genkey, paramSpec);
			plainMsg = cipher.doFinal(hexToByte(ciper.trim()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new String(plainMsg).trim();
	}

	private static byte[] hexToByte(String str) { //byte형 배열 만드는 메서드
		if (str == null)
			return null;
		if (str.length() < 2)
			return null;
		int len = str.length() / 2;
		byte[] buffer = new byte[len];
		for (int i = 0; i < len; i++) {
			buffer[i] = (byte) Integer.parseInt(str.substring(i * 2, i * 2 + 2), 16); // 2개씩 끊어서 복호화 시킴
		}
		return buffer;
	}
}
