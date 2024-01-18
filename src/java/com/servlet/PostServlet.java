/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.Dao.CategoryDao;
import com.Dao.PostDao;
import com.entity.Post;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class PostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           
            try{
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int userid = Integer.parseInt(request.getParameter("userid"));
            LocalDateTime date1 = LocalDateTime.now();
            DateTimeFormatter dateformat = DateTimeFormatter.ofPattern("E, MMM dd yyyy");
            String date = date1.format(dateformat);
            
            
            int catid= Integer.parseInt(request.getParameter("category"));
            if(catid==-1)
            {
                String cat = request.getParameter("cat");
                CategoryDao.newCategory(cat);
                catid = CategoryDao.getCategoryId(cat);
            }
            
            
            
           Part part = request.getPart("file");
           String filename = part.getSubmittedFileName();
         
           
           String path = getServletContext().getRealPath(File.separator+"img"+File.separator+"post"+File.separator+filename);
           
           InputStream is = part.getInputStream();
           Post ps = new Post();
           
          
           
           if(is.available()==0)
           {
                HttpSession session = request.getSession();
              
               ps.setTitle(title);
               ps.setDescription(description);
               ps.setPicture("null");
               ps.setUser(userid);
               ps.setCategory(catid);
               ps.setDate(date);
               
                 session.setAttribute("post",ps);
                 response.sendRedirect("text-editor/index.jsp");
               

                   
           }
           
           else if(uploadFile(is,path)){
               
               HttpSession session = request.getSession();
                ps.setTitle(title);
               ps.setDescription(description);
               ps.setPicture(filename);
               ps.setUser(userid);
               ps.setCategory(catid);
               ps.setPicture(filename);
               ps.setDate(date);
               
               session.setAttribute("post",ps);
                response.sendRedirect("text-editor/index.jsp");
               

           }
           else{
               out.println("Something went wrong upload the data");
               return;
           }
          
           
            }catch(Exception e){
                out.println("Something went wrong to get the filename");
                 e.printStackTrace();
            }
        }
    }
    
    public boolean uploadFile(InputStream is, String path)
    {
        
        boolean status = false;
        try{
            byte[] byt = new byte[is.available()];
            is.read(byt);
            
            try(FileOutputStream fos = new FileOutputStream(path))
            {
              fos.write(byt);
              fos.close();
            }
            status = true;
        }catch(Exception e){
            System.out.println("something went wrong to upload file");
            e.printStackTrace();
        }
        
        return status;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
