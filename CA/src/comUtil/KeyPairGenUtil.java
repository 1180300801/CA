package comUtil;

import java.io.*;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import java.net.URLDecoder;

import java.net.URL;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

import org.apache.commons.codec.binary.Base64;
import sun.misc.BASE64Encoder;

public class KeyPairGenUtil {

    /** 指定加密算法为RSA */
    private static final String ALGORITHM = "RSA";
    /** 密钥长度，用来初始化 */
    private static final int KEYSIZE = 1024;

    public static void main(String[] args) throws Exception {
        URL url = KeyPairGenUtil.class.getResource("");
        String path = URLDecoder.decode(url.getPath(),"utf-8").substring(1);
        /* 指定公钥存放文件 */
        String PUBLIC_KEY_FILE = path+"Public.key";
        /* 指定私钥存放文件 */
        String PRIVATE_KEY_FILE = path+"Private.key";
        System.out.println(PRIVATE_KEY_FILE);
        genKeyPair(PUBLIC_KEY_FILE,PRIVATE_KEY_FILE);
    }

    /**
     * 随机生成密钥对
     */
    public static void genKeyPair(String PUBLIC_KEY_FILE,String PRIVATE_KEY_FILE) throws NoSuchAlgorithmException {
        // KeyPairGenerator类用于生成公钥和私钥对，基于RSA算法生成对象
        KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
        // 初始化密钥对生成器，密钥大小为96-1024位
        keyPairGen.initialize(1024,new SecureRandom());
        // 生成一个密钥对，保存在keyPair中
        KeyPair keyPair = keyPairGen.generateKeyPair();
        RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();   // 得到私钥
        RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();  // 得到公钥
        String publicKeyString = new String(Base64.encodeBase64(publicKey.getEncoded()));
        // 得到私钥字符串
        String privateKeyString = new String(Base64.encodeBase64((privateKey.getEncoded())));
        // 将公钥和私钥保存到Map
        try {
            BufferedWriter out = new BufferedWriter(new FileWriter(new File(PUBLIC_KEY_FILE)));
            out.write(publicKeyString);
            out.close();
            BufferedWriter out1 = new BufferedWriter(new FileWriter(new File(PRIVATE_KEY_FILE)));
            out1.write(privateKeyString);
            out1.close();
       } catch (IOException e) {
            System.out.println("");
       }
    }
}
