/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.Dao.UserDao;
import com.entity.UserDetail;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author rahul
 */
@MultipartConfig
public class UpdateUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
             HttpSession session = request.getSession();
             
             
         
            

            try {

                int id = Integer.parseInt(request.getParameter("userid"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                Part part = request.getPart("pic");
                String filename = part.getSubmittedFileName();

                String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "user" + File.separator + filename);
               

                System.out.println("id: " + id);
                System.out.println("name: " + name);
                System.out.println("email: " + email);
                System.out.println("password: " + password);
                System.out.println("filename: " + filename);
                InputStream is = part.getInputStream();
                UserDetail ud = new UserDetail();
                
                  

                if (uploadFile(is, path)) {

                    ud.setId(id);
                    ud.setName(name);
                    ud.setEmail(email);
                    ud.setPassword(password);
                    ud.setPicture(filename);

                    int status = UserDao.updateUser(ud);

                    if (status == 1) {
                        session.removeAttribute("user");
                        session.setAttribute("user",ud);
                        response.sendRedirect("profile.jsp");
                    } else {
                        out.println("Something went wrong");
                    }
                } else if (is.available() == 0) {
                    
                 
                    session.setAttribute("image","not select");
                    UserDetail us = (UserDetail)session.getAttribute("user");
                    ud.setId(id);
                    ud.setName(name);
                    ud.setEmail(email);
                    ud.setPassword(password);
                    ud.setPicture(us.getPicture());

                    int status = UserDao.updateUser(ud);

                    if (status == 1) {
                        session.removeAttribute("user");
                        session.setAttribute("user",ud);
                        response.sendRedirect("profile.jsp");
                    } else {
                        out.println("Something went wrong");
                    }
                } else {
                    out.println("Something is wrong to upload data");
                    return;
                }

            } catch (Exception e) {
                System.out.println("error in updateuserserlvet page ");
                
                e.printStackTrace();
            }

        }
    }

    public boolean uploadFile(InputStream is, String path) {
        boolean status = false;
        try {
            byte[] byt = new byte[is.available()];
            is.read(byt);

            try (FileOutputStream fos = new FileOutputStream(path)) {
                fos.write(byt);
                fos.close();
            }

            status = true;

        } catch (Exception e) {
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
