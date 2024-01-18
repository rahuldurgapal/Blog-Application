/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.DB.DatabaseConnection;
import com.entity.Category;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


/**
 *
 * @author rahul
 */
public class CategoryDao {
    
    private static Connection con = DatabaseConnection.getConnection();
    
    public static List<Category> getCategory()
    {
        List<Category> list=new ArrayList<Category>();
        Category cat = null;
        try{
            PreparedStatement ps = con.prepareStatement("select * from category");
            ResultSet rs = ps.executeQuery();
           while(rs.next())
            {
                cat=new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                list.add(cat);
                
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public static int newCategory(String cat)
    {
        int status=0;
        try{
            PreparedStatement ps = con.prepareStatement("insert into category(name) values (?)");
            ps.setString(1,cat);
            status=ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return status;
    }
    
   public static int getCategoryId(String cat) {
    int id = -1; // Initialize to a default value
    try {
        PreparedStatement ps = con.prepareStatement("select id from category where name=?");
        ps.setString(1, cat);
        ResultSet rs = ps.executeQuery();
        
        // Check if there is a result before trying to get the id
        if (rs.next()) {
            id = rs.getInt("id");
        }
        
        // Close the ResultSet and PreparedStatement to release resources
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return id;
}

   public static String categoryName(int id)
   {
       String name = "";
       try{
           PreparedStatement ps = con.prepareStatement("select name from category where id =?");
           ps.setInt(1,id);
           ResultSet rs = ps.executeQuery();
           if(rs.next())
               name=rs.getString("name");
       }catch(Exception e){
           e.printStackTrace();
       }
       
       return name;
   }
   
}
