package comUtil;

import comDao.certificate;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//import com.mysql.jdbc.*;
public class SqlOperate {
    DbUtil dbUtil = new DbUtil();

    public boolean verify(String username, String password) {
        String Usertemp, PassTemp;
        if (username == null || password == null)
            return false;
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            String sql="SELECT * FROM `user` WHERE  username='"+username+"'";
            System.out.println(sql);
            ResultSet rs = stmt.executeQuery(sql);//执行sql语句
            while (rs.next()){
                String salt = rs.getString("salt");
                PasswordEncryptor passwordEncryptor = new PasswordEncryptor(salt, "sha-256"); // 生成加密器
                // 加盐加密
                String enc_password = passwordEncryptor.encode(password);
                if(enc_password.equals(rs.getString("password"))){
                    return true;
                }
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return false;
    }


    public boolean insert_to_user(String Username,String idCard, String Password,String salt)  {
        if (Username == null || Password == null)
            return false;
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            String sql="SELECT * FROM `user` WHERE username='"+Username+"' or IdCard='"+idCard+"'";
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                connection.close();
                return false;
            }
            sql="insert into user(username,IdCard,password,salt) values ('"+Username+"','"+idCard+"', '"+Password+"','"+salt+"')";
            stmt.executeUpdate(sql);//执行sql语句
            System.out.println("插入到数据库user成功");
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return true;
    }

    public boolean insert_to_certificate(Map<String, String> parameters)  {
        if (parameters.isEmpty())
            return false;
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            System.out.println(parameters.get("serial_Number"));
            String sql="SELECT * FROM `certificate` WHERE username='"+parameters.get("username")+"'";
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                connection.close();
                return false;
            }
            sql="SELECT * FROM `certificate` WHERE organization='"+parameters.get("organizationAndPhone")+"'";
            rs = stmt.executeQuery(sql);
            if(rs.next()){
                connection.close();
                return false;
            }
            sql="INSERT INTO `certificate` (username,serial_Number,organization, start_time, end_time, public_key, sign,file_path) VALUES ('"+parameters.get("username")+"','"+parameters.get("serial_Number")+"','"+parameters.get("organizationAndPhone")+"','"+parameters.get("start_time")+"','"+parameters.get("end_time")+"','"+parameters.get("public_key")+"','"+parameters.get("sign")+"','"+parameters.get("file_path")+"')";
            stmt.executeUpdate(sql);//执行sql语句
            System.out.println("插入到数据库成功certificate");
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return true;
    }

    public int delete_certificate(String username)  {
        if (username==null)
            return 0;
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            String sql="SELECT * FROM `certificate` WHERE username='"+username+"'";
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                sql="INSERT INTO `crl` (serial_Number, organization) VALUES ('"+rs.getString("serial_Number")+"','"+rs.getString("organization")+"')";
                stmt.executeUpdate(sql);//执行sql语句
            }
            sql="DELETE FROM `certificate` WHERE  username='"+username+"'";
            System.out.println(sql);
            int result = stmt.executeUpdate(sql);//执行sql语句
            connection.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return 0;
    }

    public certificate checkCertificate(String username) throws SQLException {
        if(username == null)
        {
            return null;
        }
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `certificate` WHERE username='"+username+"'";
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        certificate cer = new certificate(rs);
        if(cer.getSerial_Number()==null){
            connection.close();
            return null;
        }
        connection.close();
        return cer;
    }

    public certificate queryCertificate(String serial_Number) throws SQLException {
        if(serial_Number == null)
        {
            return null;
        }
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `certificate` WHERE serial_Number='"+serial_Number+"'";
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        certificate cer = new certificate(rs);
        if(cer.getSerial_Number()==null){
            connection.close();
            return null;
        }
        connection.close();
        return cer;
    }

    public certificate queryCerByName(String organization) throws SQLException {
        if(organization == null)
        {
            return null;
        }
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `certificate` WHERE find_in_set('"+organization+"',organization)";
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        certificate cer = new certificate(rs);
        if(cer.getSerial_Number()==null){
            connection.close();
            return null;
        }
        connection.close();
        return cer;
    }

    public List<certificate> selectCertificate() throws SQLException {
        List<certificate> certificates = new ArrayList<>();
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `certificate`";
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        while(rs.next()){
            certificate cer = new certificate();
            cer.setOrganization(rs.getString("organization"));
            cer.setSerial_Number(rs.getString("serial_Number"));
            certificates.add(cer);
        }
        if(certificates.isEmpty()){
            connection.close();
            return null;
        }
        connection.close();
        return certificates;
    }

    public List<certificate> selectCRL() throws SQLException {
        List<certificate> certificates = new ArrayList<>();
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `crl`";
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        while(rs.next()){
            certificate cer = new certificate();
            cer.setOrganization(rs.getString("organization"));
            cer.setSerial_Number(rs.getString("serial_Number"));
            certificates.add(cer);
        }
        if(certificates.isEmpty()){
            connection.close();
            return null;
        }
        connection.close();
        return certificates;
    }

    public boolean queryCRL(String serial_Number) throws SQLException {
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `crl` where serial_Number='"+serial_Number+"'";
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        if(rs.next()){
            connection.close();
            return true;
        }
        connection.close();
        return false;
    }

}
