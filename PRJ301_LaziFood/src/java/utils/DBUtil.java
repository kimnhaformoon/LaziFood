/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author long
 */
public class DBUtil {
    public static Connection makeConnection() throws NamingException, SQLException, ClassNotFoundException{
//        //1. get current system file
//        Context context = new InitialContext();
//        //2. get container context
//        Context tomcatContext = (Context) context.lookup("java:comp/env");
//        //3. get DataSource from container
//        DataSource ds = (DataSource) tomcatContext.lookup("DSBlink");
//        //4. get Connection
//        Connection cn = ds.getConnection(); 
//        return cn;

Connection cn=null;
        String IP="localhost";
        String instanceName="LAPTOP-SKY\\KIMNHA";
        String port="1433";
        String uid="sa";
        String pwd="12345";
        String db="LaziFood";
        String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String url="jdbc:sqlserver://" +IP+"\\"+ instanceName+":"+port
                 +";databasename="+db+";user="+uid+";password="+pwd;
        Class.forName(driver);
        cn=DriverManager.getConnection(url);
        return cn;
    }
}
