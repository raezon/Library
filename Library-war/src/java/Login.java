/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ramzi
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Login extends HttpServlet{
    protected void doPost(HttpServletRequest r,HttpServletResponse s)throws ServletException,IOException
    {
        String email = r.getParameter("email");
        String mdp = r.getParameter("mdp");
        boolean existe=false;
        if(email.equals("")||mdp.equals(""))
        {
            String erreur="Remplir toutes les cases";
            r.setAttribute("e", erreur);
            RequestDispatcher rd = r.getRequestDispatcher("Login.jsp");
            rd.forward(r,s);
            
        }
        else
        {
             try
            {
            
                connexion c = new connexion();
                Statement st=c.cnx();
        
                ResultSet myrs = st.executeQuery("select * from user WHERE email='"+email+"' and mdp='"+mdp+"' limit 1");
                if(myrs.next())
                {
                    existe=true;
                }
                if(existe)
                {
                    HttpSession session = r.getSession();
                    session.setAttribute("nom",myrs.getString("nom"));
                    if(myrs.getString("admin").equals("1"))
                    {
                        s.sendRedirect("Home_admin.jsp");
                    }
                    else
                    {
                            s.sendRedirect("index.jsp");
                    }
                    
                }
                else
                {
                    String erreur="Email ou Mot De Passe incorrect";
                    r.setAttribute("e", erreur);
                    RequestDispatcher rd = r.getRequestDispatcher("Login.jsp");
                    rd.forward(r,s);
                }
        }catch(Exception e)
        {
            
        }
        }
        
        
        
       
    }
    
}
