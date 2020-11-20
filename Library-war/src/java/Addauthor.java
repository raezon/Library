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
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
public class Addauthor extends HttpServlet{
    protected void doPost(HttpServletRequest r,HttpServletResponse s)throws ServletException,IOException
    {
        String nom = r.getParameter("nom");
        String prenom = r.getParameter("prenom");
        String datenaissence = r.getParameter("datenaissence");
        connexion c = new connexion();
        Statement st=c.cnx();
        
        if(nom.equals("")||prenom.equals("")||datenaissence.equals(""))
        {
            String erreur="Remplir toutes les cases";
            r.setAttribute("e", erreur);
            RequestDispatcher rd = r.getRequestDispatcher("Add_Author.jsp");
            rd.forward(r,s);
            
        }
        else
        {
            try
            {
                String rq = "INSERT INTO author "
                    + "(nom,prenom,datenaissence) VALUES "
                    + "('"+nom+"','"+prenom+"','"+datenaissence+"')";
            
                st.executeUpdate(rq);          
                s.sendRedirect("index.jsp");
            }catch(Exception e)
            {

            }
        }
        
    }
    
}
