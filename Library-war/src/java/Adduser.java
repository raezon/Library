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

public class Adduser extends HttpServlet {
    protected void doPost(HttpServletRequest r,HttpServletResponse s ) throws ServletException, IOException
    {
        String nom = r.getParameter("nom");
        String prenom = r.getParameter("prenom");
        String email = r.getParameter("email");
        String mdp = r.getParameter("mdp");
        String datenaissence = r.getParameter("datenaissence");
        connexion c = new connexion();
        Statement st=c.cnx();
        
        if(nom.equals("")||prenom.equals("")||email.equals("")||mdp.equals("")||datenaissence.equals(""))
        {
            String erreur="Remplir toutes les cases";
            r.setAttribute("e", erreur);
            RequestDispatcher rd = r.getRequestDispatcher("Singup.jsp");
            rd.forward(r,s);
            
        }
        else
        {
            try
            {
                String rq = "INSERT INTO user "
                    + "(nom,prenom,email,mdp,datenaissence,admin) VALUES "
                    + "('"+nom+"','"+prenom+"','"+email+"','"+mdp+"','"+datenaissence+"','0')";
            
                st.executeUpdate(rq);          
                s.sendRedirect("index.jsp");
            }catch(Exception e)
            {

            }
        }
        
        
        
        
    }
    /*
    public static void main(String[] args)
    {
            System.out.print("1");
        try
        {
        connexion c = new connexion();
        Statement st=c.cnx();
        ResultSet myrs = st.executeQuery("select * from user");
            while(myrs.next())
            {
                System.out.println(myrs.getString("nom") + " , "+myrs.getString("prenom") + " , "+myrs.getString("email"));
            }
        System.out.print("");
        }catch(Exception e)
        {
            
        }
    }
    */
        
}
