package comUtil;

import comDao.certificate;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//import com.mysql.jdbc.*;
public class SqlOperate {
    DbUtil dbUtil = new DbUtil();

    public boolean verify(String Username, String Password) {
        String Usertemp, PassTemp;
        String sql="select * from user";
        if (Username == null || Password == null)
            return false;
        try {
            Connection connection=dbUtil.getCon();

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.execute();
            ResultSet resultSet = preparedStatement.executeQuery("select * from user");
            while (resultSet.next()) {
                Usertemp = resultSet.getString(2);

                if (Usertemp.equals(Username)) {
                    PassTemp = resultSet.getString(3);
                    if (PassTemp.equals(Password))
                        return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }

        return false;
    }


    public boolean insert_to_user(String Username, String Password)  {
        if (Username == null || Password == null)
            return false;
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            String sql="insert into user(username, password) values ('"+Username+"', '"+Password+"')";
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
            String sql="INSERT INTO `certificate` (username,serial_Number,organization, start_time, end_time, public_key, sign,file_path) VALUES ('"+parameters.get("username")+"','"+parameters.get("serial_Number")+"','"+parameters.get("organization")+"','"+parameters.get("start_time")+"','"+parameters.get("end_time")+"','"+parameters.get("public_key")+"','"+parameters.get("sign")+"','"+parameters.get("file_path")+"')";
            stmt.executeUpdate(sql);//执行sql语句
            System.out.println("插入到数据库成功certificate");
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return true;
    }

    public certificate checkCertificate(String username) throws SQLException {
        if(username == null)
        {
            System.out.println("SELECT * FROM `certificate` WHERE username=");
            return null;
        }
        Connection connection=dbUtil.getCon();
        Statement stmt=connection.createStatement();//创建一个Statement对象
        String sql="SELECT * FROM `certificate` WHERE username='"+username+"'";
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);//执行sql语句
        certificate cer = new certificate(rs);
        connection.close();
        return cer;
    }
}
