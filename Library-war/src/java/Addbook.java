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
import java.util.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import com.oreilly.servlet.MultipartRequest;


public class Addbook extends HttpServlet{
    protected void doPost(HttpServletRequest r,HttpServletResponse s ) throws ServletException, IOException
    {
        String titre="";
        int nbrpage=0;
        String domaine="";
        int auteur=0;
        String image="";
        String resume="";
        connexion c = new connexion();
        Statement st=c.cnx();
        try
        {   
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(r);
            for (FileItem item : items) {
            if (item.isFormField()) {
                // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                String fieldName = item.getFieldName();
                String fieldValue = item.getString();
                
                if(fieldName.equals("titre"))
                {
                    titre=fieldValue;
                }
                if(fieldName.equals("nbrpage"))
                {
                    nbrpage=Integer.parseInt(fieldValue);
                }
                if(fieldName.equals("domaine"))
                {
                    domaine=fieldValue;
                }
                if(fieldName.equals("auteur"))
                {
                    auteur=Integer.valueOf(fieldValue);
                }
                if(fieldName.equals("resume"))
                {
                    resume=fieldValue;
                }
            } else {
                // Process form file field (input type="file").
                String fieldName = item.getFieldName();
                String fileName = FilenameUtils.getName(item.getName());
                InputStream fileContent = item.getInputStream();
                image=fileName;
            }
            
        }
            String rq = "INSERT INTO livre "
                    + "(titre,nbrpage,domaine,num_auteur,image,resume) VALUES "
                    + "('"+titre+"','"+nbrpage+"','"+domaine+"','"+auteur+"','"+image+"','"+resume+"')";
                st.executeUpdate(rq); 
        //partie saving image in a folder
                
                
                s.sendRedirect("Home_admin.jsp");

        }catch(Exception e)
        {
        
        }
    }
    
}
