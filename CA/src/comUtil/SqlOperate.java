package comUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//import com.mysql.jdbc.*;
public class SqlOperate {
    public List User=new ArrayList();

/** 
* @Description: 查询数据库 
* @Param:  
* @return:  
* @Author: 1170300421 
* @Date: 2019/11/28 
*/ 
    public boolean verify(String Username, String Password) {
        String Usertemp, PassTemp;
        String sql="select * from user";
        DbUtil dbUtil = new DbUtil();
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

    /**
     *
     * @param Username
     * @param Password
     * @return
     */
    public boolean insert(String Username, String Password)  {
        if (Username == null || Password == null)
            return false;
        DbUtil dbUtil = new DbUtil();
        try {
            Connection connection=dbUtil.getCon();
            Statement stmt=connection.createStatement();//创建一个Statement对象
            System.out.println(Username);
            System.out.println(Password);
            String sql="insert into user(username, password) values ('"+Username+"', '"+Password+"')";
            stmt.executeUpdate(sql);//执行sql语句
            System.out.println("插入到数据库成功");
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("operate fail");
        }
        return true;
    }
}
