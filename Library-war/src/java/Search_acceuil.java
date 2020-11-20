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

public class Search_acceuil extends HttpServlet {
    protected void doPost(HttpServletRequest r,HttpServletResponse s ) throws ServletException, IOException
    {
        String query = r.getParameter("query");

        System.out.println("query = "+query);
        System.out.println("t = titre");
        
        connexion c = new connexion();
        Statement st=c.cnx();
        
                    r.setAttribute("query", query);
                    r.setAttribute("t", "titre");
                    RequestDispatcher rd = r.getRequestDispatcher("index.jsp");
                    rd.forward(r,s);
    }
}