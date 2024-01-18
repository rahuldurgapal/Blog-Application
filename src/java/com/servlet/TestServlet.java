/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.Dao.PostDao;
import com.entity.Post;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author rahul
 */
public class TestServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try{
           String content = request.getParameter("content");
    String title = request.getParameter("title");
    String filename = request.getParameter("filename");
    String description = request.getParameter("description");
    int category = Integer.parseInt(request.getParameter("category"));
    String picture = request.getParameter("picture");
    int user = Integer.parseInt(request.getParameter("user"));
    String date = request.getParameter("date");

    String path = getServletContext().getRealPath(File.separator+"components"+File.separator+"Blogs"+File.separator+filename);
     HttpSession session = request.getSession();
     
     
    InputStream is = new ByteArrayInputStream(content.getBytes(Charset.forName("UTF-8")));

    // Call the uploadFile method
    if(saveFile(is, path))
    {
       
        Post ps = new Post();
        ps.setTitle(title);
        ps.setDescription(description);
        ps.setCategory(category);
        ps.setFilename(filename);
        ps.setPicture(picture);
        ps.setUser(user);
        ps.setDate(date);
        
       int status = PostDao.insertPost(ps);
       if(status==1){
           session.removeAttribute("post");
           out.println("Blog save Successfully");
       }
           
       else
           out.println("Something wrong to insert blog");
        
        
    }
     else
        out.println("Something wrong to save the file");
    
}catch(Exception e){
    out.println("Something wrong to save the blog");
    e.printStackTrace();
}

        }
    }
    
    
    boolean saveFile(InputStream is, String path)
    {
        boolean status=false;
        try{
            byte[] byt = new byte[is.available()];
            is.read(byt);
            
            try(FileOutputStream fos = new FileOutputStream(path)){
                fos.write(byt);
                fos.close();
            }
            status=true;
            
        }catch(Exception e){
            System.out.println("Something wrogn to upload file");
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
