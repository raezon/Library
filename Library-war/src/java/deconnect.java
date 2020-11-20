/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author 
 */
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class deconnect extends HttpServlet{
    protected void doPost(HttpServletRequest r,HttpServletResponse s)throws ServletException,IOException
    {
        HttpSession session = r.getSession();
        session.setAttribute("nom","");
        s.sendRedirect("index.jsp");
    }
    
}
