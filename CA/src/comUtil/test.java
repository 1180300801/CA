package comUtil;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Objects;

public class test {
    public static void main(String[] args) throws Exception {
//        String path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\sk.key";
//        String path1 = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\pk.key";
//        String sign_source = "崔同发";
////        String m = privateKeyEncrypt(sign_source,KeyUtil.loadPrivateKeyByFile(path));
////        System.out.println(m);
////        System.out.println(publicKeyDecrypt(m,KeyUtil.loadPrivateKeyByFile(path1)));
//        String sign = RSASignature.sign(sign_source, KeyUtil.loadPrivateKeyByFile(path), "utf-8");
//        System.out.println(sign);
//        boolean result = RSASignature.doCheck(sign_source,sign,KeyUtil.loadPublicKeyByFile(path1),"utf-8");
//        System.out.println(result);
        String path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\out\\artifacts\\CA_war_exploded\\certificate\\20201225000759崔同发.cer";
        System.out.println(getContent(path));
    }

    public static String privateKeyEncrypt(String str, String privateKey) throws Exception {
        //base64编码的公钥
        byte[] decoded = Base64.decodeBase64(privateKey);
        PrivateKey priKey = KeyFactory.getInstance("RSA").
                generatePrivate(new PKCS8EncodedKeySpec(decoded));
        //RSA加密
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, priKey);
        String outStr = Base64.encodeBase64String(cipher.doFinal(str.getBytes()));
        return outStr;
    }

    /**
     * RSA公钥解密
     *
     * @param str
     * @param publicKey
     * @return
     * @throws Exception
     */
    public static String publicKeyDecrypt(String str, String publicKey) throws Exception {
        //64位解码加密后的字符串
        byte[] inputByte = Base64.decodeBase64(str.getBytes("UTF-8"));
        //base64编码的私钥
        byte[] decoded = Base64.decodeBase64(publicKey);
        PublicKey pubKey =  KeyFactory.getInstance("RSA")
                .generatePublic(new X509EncodedKeySpec(decoded));
        //RSA解密
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, pubKey);
        String outStr = new String(cipher.doFinal(inputByte));
        return outStr;
    }

    public static String getContent(String path) throws IOException {
        BufferedReader bf = new BufferedReader(new InputStreamReader(new FileInputStream(path), "UTF-8"));
        String str="";
        // 按行读取字符串
        int count = 0;
        while (count<9) {
            str += bf.readLine();
            count++;
        }
        return str;
    }
}
