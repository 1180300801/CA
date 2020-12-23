package comWeb;

import comUtil.KeyUtil;
import comUtil.RSASignature;
import comUtil.SHADigest;
import comUtil.SqlOperate;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.text.SimpleDateFormat;
import java.util.*;

public class ApplyServlet extends HttpServlet {

    Logger logger = LogManager.getLogger("myLog");//记录日志

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Map<String, String> parameters = new HashMap<>();
        parameters.put("username",(String)request.getSession().getAttribute("username"));
        parameters.put("organization",request.getParameter("organization"));
        parameters.put("valid_time",request.getParameter("valid_time"));
        parameters.put("public_key",request.getParameter("public_key"));
        System.out.println("true");
        String serial_number =
                getSerialNumber(new String[] {new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()), parameters.get("organization")});
        parameters.put("serial_Number",serial_number);
        System.out.println("true");
        String cer_source = "版本: CTF_1.0\r\n";
        cer_source += "发行机构: CA of CTF\r\n";
        cer_source += "序列号: " + serial_number+"\r\n";
        cer_source += "签名算法: sha1RSA\r\n";
        cer_source += "摘要算法: sha1RSA\r\n";
        String organization = parameters.get("organization");
        cer_source += "所有者: " + organization+"\r\n";
        String[] valid_time = getTTL(Integer.parseInt(parameters.get("valid_time")));
        System.out.println("true");
        cer_source += "生效时间: " + valid_time[0]+"\r\n";
        cer_source += "失效时间: " + valid_time[1]+"\r\n";
        parameters.put("start_time",valid_time[0]);
        parameters.put("end_time",valid_time[1]);
        cer_source += "所有者公钥: " + parameters.get("public_key")+"\r\n";
        String path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\sk.key";
        String sign = RSASignature.sign(SHADigest.getDigest(cer_source), KeyUtil.loadPrivateKeyByFile(path), "utf-8");
        cer_source += "签名: " + sign;
        parameters.put("sign",sign);
        parameters.put("file_path",makeCertificate(cer_source,serial_number));
        logger.info(parameters.get("organization")+"成功注册证书，序列号为："+serial_number);
        SqlOperate so = new SqlOperate();
        if(so.insert_to_certificate(parameters)){
            logger.info("序列号为："+serial_number+"的证书成功存储到数据库certificate中！");
        }
//        System.out.println(cer_source);
//        System.out.println("key");
        request.setAttribute("serial_number", serial_number);
        request.setAttribute("organization", organization);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    private String makeCertificate(String cerSource,String serial_number) {
        String cer_path = this.getServletContext().getRealPath("/certificate/");
        String cer_name = serial_number+".cer";
        String file_path = cer_path+cer_name;
        file_path = file_path.replace("\\","/");
        try {
            BufferedWriter bufferedWriter =
                    new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(
                            file_path))));
            bufferedWriter.write(cerSource);
            bufferedWriter.flush();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file_path;
    }

    private String getSerialNumber(String[] message) {
        StringBuilder string= new StringBuilder(message[0]);
        for (int i = 1; i < message.length; i++) {
            string.append(message[i]);
        }
//        String serialNumber = DigestUtils.md5DigestAsHex(stringBuilder.toString().getBytes());
//        return serialNumber;
        return string.toString();
    }

    private String[] getTTL(int ttl) {
        String present_time =
                new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(Calendar.getInstance().getTime());
        Calendar temp = Calendar.getInstance();
        temp.add(Calendar.YEAR, ttl);
        String future_time = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(temp.getTime());
        System.out.println(present_time);
        return new String[] {present_time, future_time};
    }

//    private String getSign(String message) {
//        byte[] plaintext = new byte[0];
//        plaintext = message.getBytes(StandardCharsets.UTF_8);
//        String file_path = "C:\\Users\\Administrator\\Desktop\\大学\\大三上\\密码学\\-Cryptography-experiment\\CA\\web\\key\\sk.key";
//        File file = new File(file_path);
//        String line = "";
//        StringBuilder key_file = new StringBuilder();
//        try {
//            InputStreamReader inputStreamReader = new InputStreamReader(new FileInputStream(file));
//            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
//            while ((line = bufferedReader.readLine()) != null) {
//                key_file.append(line);
//            }
//            bufferedReader.close();
//            inputStreamReader.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        try {
//            byte[] buffer = Base64.getDecoder().decode(key_file.toString());
//            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
//            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
//            RSAPrivateKey privateKey = (RSAPrivateKey) keyFactory.generatePrivate(keySpec);
//            Cipher cipher = Cipher.getInstance("RSA");
//            cipher.init(Cipher.ENCRYPT_MODE, privateKey);
//            byte[] ciphertext = cipher.doFinal(plaintext);
//            //            return HexStringUtil.getInstance().bytesToHexString(ciphertext);
//            return Base64.getEncoder().encodeToString(ciphertext);
//        } catch (NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException | InvalidKeyException | BadPaddingException | IllegalBlockSizeException e) {
//            e.printStackTrace();
//        }
//        System.out.println("public_key");
//        return null;
//    }
}
