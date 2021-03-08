package comUtil;

import java.io.*;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.sql.SQLException;
import java.util.Base64;

public class Verify {

//    public static void main(String[] args) throws Exception{
////        String path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\out\\artifacts\\CA_war_exploded\\certificate\\20201226153249崔同发.cer";
//        String path1 = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\pk.key";
//        String path2 = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\sk.key";
////        System.out.println(verify(path,KeyUtil.loadPublicKeyByFile(path1)));
//        String content = "publicKey:"+KeyUtil.loadPublicKeyByFile(path1)+"\n";
//        String sign = RSASignature.sign(SHADigest.getDigest(content), KeyUtil.loadPrivateKeyByFile(path2), "utf-8");
//        content += "sign:" + sign;
//        String file_path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\root_cer\\CA.cer";
//        try {
//            BufferedWriter bufferedWriter =
//                    new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(file_path)),"utf-8"));
//            bufferedWriter.write(content);
//            bufferedWriter.flush();
//            bufferedWriter.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

    public static boolean verify(InputStream inputStream) throws IOException, SQLException {
        String path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\pk.key";
        String publicKey = KeyUtil.loadPublicKeyByFile(path);
        BufferedReader bf = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
        String content="";
        // 按行读取字符串
        int count = 0;
        while (count<9) {
            if(count==2){
                String serial_Number = bf.readLine();
                content += serial_Number;
                serial_Number = serial_Number.replace("序列号: ","");
                SqlOperate so = new SqlOperate();
                if(so.queryCRL(serial_Number)){
                    return false;
                }
            }
            else{
                content += bf.readLine();
            }
            count++;
        }
        String sign = bf.readLine();
        sign = sign.replace("签名: ","");
        bf.close();
        System.out.println(content.substring(1));
        System.out.println(getDigest(content.substring(1)));
        return doCheck(getDigest(content),sign,publicKey,"utf-8");
    }

    /**
     * RSA验签名检查
     *
     * @param content   待签名数据
     * @param sign      签名值
     * @param publicKey 分配给开发商公钥
     * @param encode    字符集编码
     * @return 布尔值
     */
    private static boolean doCheck(String content, String sign, String publicKey, String encode) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] encodedKey = Base64.getMimeDecoder().decode(publicKey);
            PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
            java.security.Signature signature =
                    java.security.Signature.getInstance("SHA1WithRSA");
            signature.initVerify(pubKey);
            signature.update(content.getBytes(encode));
            System.out.println(sign);
            System.out.println(Base64.getDecoder().decode(sign).length);
            return signature.verify(Base64.getDecoder().decode(sign));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static String getDigest(String message) {
        try {
            byte[] plaintext = message.getBytes("utf-8");
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(plaintext);
            byte[] ciphertext = messageDigest.digest();
            return bytesToHexString(ciphertext);
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String bytesToHexString(byte[] bArray) {
        StringBuffer stringBuffer = new StringBuffer(bArray.length);
        String sTemp;
        for (int i = 0; i < bArray.length; i++) {
            sTemp = Integer.toHexString(0xFF & bArray[i]);
            if (sTemp.length() < 2)
                stringBuffer.append(0);
            stringBuffer.append(sTemp.toUpperCase());
        }
        return stringBuffer.toString();
    }
}
