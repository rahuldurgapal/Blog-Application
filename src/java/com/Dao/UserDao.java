/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.DB.DatabaseConnection;
import com.entity.UserDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;


public class UserDao {
    
    private static Connection con = DatabaseConnection.getConnection();
    
    public static int saveUser(UserDetail user)
    {
        int status = 0;
        try{
            PreparedStatement ps = con.prepareStatement("insert into user(name, email, password, picture) values (?,?,?,?)");
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPicture());
            
            status = ps.executeUpdate();
        }catch (SQLException e) {
    e.printStackTrace();
    System.out.println("SQL State: " + e.getSQLState());
    System.out.println("Error Code: " + e.getErrorCode());
}
        
        
        return status;
    }
    
    public static UserDetail loginUser(UserDetail us)
    {
        UserDetail user = null;
       
        try{
            
            PreparedStatement ps = con.prepareStatement("select * from user where email = ? and password = ?");
            ps.setString(1,us.getEmail());
            ps.setString(2,us.getPassword());
            
            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
                user = new UserDetail();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPicture(rs.getString("picture"));
            }
        }catch(Exception e){
            System.out.println("error in userdao page");
            e.printStackTrace();
        }
        
        return user;
        
    }
    
    public static int updateUser(UserDetail ud)
    {
        int status=0;
        try{
            
            PreparedStatement ps = con.prepareStatement("update user set name=?, email=?, password=?,picture=? where id=?");
            ps.setString(1,ud.getName());
            ps.setString(2,ud.getEmail());
            ps.setString(3,ud.getPassword());
            ps.setString(4,ud.getPicture());
            ps.setInt(5, ud.getId());
            
           status=ps.executeUpdate();
           
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return status;
    }
    
    public static String getUserName(int id)
    {
        String name="";
        try{
       PreparedStatement ps = con.prepareStatement("select name from user where id=?");
       ps.setInt(1, id);
       ResultSet rs = ps.executeQuery();
         if(rs.next())
           name= rs.getString("name");
         
    }catch(Exception e){
            e.printStackTrace();
            }
        
        return name;
    }
    
    
}
