package comWeb;

import comUtil.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.security.PrivateKey;
import java.security.interfaces.RSAPrivateKey;
import java.text.SimpleDateFormat;
import java.util.*;

public class ApplyServlet extends HttpServlet {

    Logger logger = LogManager.getLogger("myLog");//记录日志

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Map<String, String> parameters = new HashMap<>();

        String upload_path = this.getServletContext().getRealPath("/publicKeys");
        File file = new File(upload_path);
        if (!file.exists()) {
            file.mkdirs();
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> fileItemList = servletFileUpload.parseRequest(request);
                for (FileItem fileItem : fileItemList) {
                    if (!fileItem.isFormField()) {
                        String file_name = fileItem.getName();
                        if (file_name.isEmpty()) {
                            return;
                        }
                        InputStream inputStream = fileItem.getInputStream();
                        String line = "";
                        String content = "";
                        BufferedReader bufferedReader =
                                new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
                        while ((line = bufferedReader.readLine()) != null) {
                            content += line;
                        }
                        bufferedReader.close();
                        parameters.put("public_key", content);
                        fileItem.delete();
                    }
                    else {
                        parameters.put(fileItem.getFieldName(),fileItem.getString("utf-8"));
                    }
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        } // END parsing form
//        PrivateKey privateKey = null;
//        try {
//            privateKey =
//                    Ende.loadPrivateKeyByStr("MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAK9TBo9p6Tyl5qCIGmN20+We8woZPpIQ91JB8uePTogF5M5aUFITmDKpmaOaI9+T2Mq57Olxoh+zVnRumQcy/YMOy283u9/uDB4ZFCeCnkM4dsz6DgTid3qIgjqh/y1DA2L5B4rQe3AxOkJmjjiu7ANUrnbPTBjeb+csLBkK5ajtAgMBAAECgYB/7NmtjP7lBLwZyBVRG+QS+H6nkLHqDD0ZpQsi0Jrhf0NrGdTffnKgDMYQ7KheO1eE3FK0Jvi/nrBndkdsTFVStSwpfhwqddgns1jHUQDtoDIclmgOJlBnx3l3FVjpjuhf7rfgFwo4/vF11/SVvmtlZXMHs45dScwXZ+PSJ1y7QQJBANXElqvhVYmqgC83taVYv9dSbgbNY6kkVrHrp3CmLnOps8RTcx7wpqYAVIaMstOX1rY1O06uTeIzdx1vlSZXIhECQQDR9iJM4G6IR1rbpRt0TyFOwm3tNHPxHm3BQ4iVRWhGeMzHOZrjKYj4A0Kbuu7W2j5VrJJnKPgetfIL5zWUnP0dAkBY/CHAYOeri+caQLWDo+MP7gdRG5R951uTasZjtTmm+iCT/Czy1zh357FH5S/XtuAxLw2GHjbbj5LpFPbgY+sRAkAKkaxKWGXYAFeHhPkr0qvnjgwAi8pmUdTOjLq8YOEN4xjT0oeEddvKOEfLFQ7ey9+laml4Pey3hwsnJD1jPL/VAkA+0lPwReSe9tTJdVQ4vKvH7gMBfJdcE2p/oH0FucpHFwJOD04QM9onCAUtOE/BRtUJXslYYtmRl0VEACVHyH3e");
//            parameters.put("organization",new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getMimeDecoder().decode(parameters.get("organization"))), "utf-8"));
//            parameters.put("registration_number",new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getMimeDecoder().decode(parameters.get("registration_number"))), "utf-8"));
//            parameters.put("legal_person",new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getMimeDecoder().decode(parameters.get("legal_person"))), "utf-8"));
//            parameters.put("phone_number",new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getMimeDecoder().decode(parameters.get("phone_number"))), "utf-8"));
//            parameters.put("valid_time", new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getMimeDecoder().decode(parameters.get("valid_time"))), "utf-8"));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        parameters.put("username",(String)request.getSession().getAttribute("username"));

        String serial_number =
                getSerialNumber(new String[] {new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()), parameters.get("organization")});

        upload_path += "\\" + serial_number;
        BufferedWriter bufferedWriter =
                new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(upload_path))));
        bufferedWriter.write(parameters.get("public_key"));
        bufferedWriter.flush();
        bufferedWriter.close();

        parameters.put("serial_Number",serial_number);
        String cer_source = "版本: CTF_1.0\r\n";
        cer_source += "发行机构: CA of CTF\r\n";
        cer_source += "序列号: " + serial_number+"\r\n";
        cer_source += "签名算法: sha1RSA\r\n";
        cer_source += "摘要算法: SHA-256\r\n";
        String organization = parameters.get("organization");
        cer_source += "所有者: " + organization+"(工商注册号："+parameters.get("registration_number")+"  法人："+parameters.get("legal_person")+"  联系电话："+parameters.get("phone_number")+")\r\n";
        parameters.put("organizationAndPhone",organization+"(工商注册号："+parameters.get("registration_number")+"  法人:"+parameters.get("legal_person")+"  联系电话:"+parameters.get("phone_number")+")");
        String[] valid_time = getTTL(Integer.parseInt(parameters.get("valid_time")));
        cer_source += "生效时间: " + valid_time[0]+"\r\n";
        cer_source += "失效时间: " + valid_time[1]+"\r\n";
        parameters.put("start_time",valid_time[0]);
        parameters.put("end_time",valid_time[1]);
        cer_source += "所有者公钥: " + parameters.get("public_key")+"\r\n";
        String sign_source = cer_source;
        String path = this.getServletContext().getRealPath("/key/sk.key");
        String sign = RSASignature.sign(SHADigest.getDigest(sign_source.replace("\r\n","")), KeyUtil.loadPrivateKeyByFile(path), "utf-8");
        cer_source += "签名: " + sign;
        parameters.put("sign",sign);
        parameters.put("file_path",makeCertificate(cer_source,serial_number));
        logger.info(parameters.get("organization")+"成功注册证书，序列号为："+serial_number);
        SqlOperate so = new SqlOperate();
        if(so.insert_to_certificate(parameters)){
            logger.info("序列号为："+serial_number+"的证书成功存储到数据库certificate中！");
            request.setAttribute("msg","申请证书成功");
        }
        else{
            deleteFile(parameters.get("file_path"));
            request.setAttribute("msg","申请证书失败,该组织已申请证书或您已拥有证书");
        }
        request.setAttribute("serial_number", serial_number);
        request.setAttribute("organization", organization);
        request.getRequestDispatcher("apply.jsp").forward(request, response);
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
                    new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(file_path)),"utf-8"));
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
    /**
     * 删除单个文件
     *
     * @param fileName
     *            要删除的文件的文件名
     */
    public static void deleteFile(String fileName) {
        File file = new File(fileName);
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                System.out.println("删除单个文件" + fileName + "成功！");
            } else {
                System.out.println("删除单个文件" + fileName + "失败！");
            }
        } else {
            System.out.println("删除单个文件失败：" + fileName + "不存在！");
        }
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
