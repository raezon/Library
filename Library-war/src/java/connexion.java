
import java.sql.*;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author 
 */
public class connexion {
    public static Statement cnx()
    {
        
        
        Statement st = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
            st=c.createStatement();
            
        } catch(Exception e){
            
        }
        return st;
    }
}
