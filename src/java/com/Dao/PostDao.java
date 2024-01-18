/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;


import com.DB.DatabaseConnection;
import com.entity.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class PostDao {
    
    private static Connection con = DatabaseConnection.getConnection();
    
    public static int insertPost(Post pst)
    {
        int status = 0;
        try{
            
            PreparedStatement ps = con.prepareStatement("insert into post(title, description, picture, filename, catid, userid, date) values (?,?,?,?,?,?,?)");
            ps.setString(1, pst.getTitle());
            ps.setString(2,pst.getDescription());
            ps.setString(3,pst.getPicture());
            ps.setString(4,pst.getFilename());
            ps.setInt(5,pst.getCategory());
            ps.setInt(6,pst.getUser());
            ps.setString(7,pst.getDate());
            
            status = ps.executeUpdate();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        
        return status;
    }
    
    public static List getAllPost()
    {
        List<Post> list= new ArrayList<Post>();
        Post post = null;
        try{
            PreparedStatement ps = con.prepareStatement("select * from post");
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setDescription(rs.getString("description"));
                post.setPicture(rs.getString("picture"));
                post.setCategory(rs.getInt("catid"));
                post.setUser(rs.getInt("userid"));
                post.setDate(rs.getString("date"));
                
                list.add(post);
                  
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        
        return list;
        
    }
    
    public static List getAllPostByCatId(int id)
    {
        List<Post> list = new ArrayList<Post>();
        Post post = null;
        try{
            PreparedStatement ps = con.prepareStatement("select * from post where catid=?");
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                post=new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setDescription(rs.getString("description"));
                post.setPicture(rs.getString("picture"));
                post.setCategory(rs.getInt("catid"));
                post.setUser(rs.getInt("userid"));
                post.setDate(rs.getString("date"));
                
                list.add(post);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public static List getAllPostByUserId(int id)
    {
        List<Post> list = new ArrayList<Post>();
        Post post = null;
        try{
            PreparedStatement ps = con.prepareStatement("select * from post where userid = ?");
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setDescription(rs.getString("description"));
                post.setPicture(rs.getString("picture"));
                post.setCategory(rs.getInt("catid"));
                post.setUser(rs.getInt("userid"));
                post.setDate(rs.getString("date"));
                
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public static String getFileName(int id)
    {
        String name ="";
        
        try{
            PreparedStatement ps = con.prepareStatement("select filename from post where id = ?");
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
                name = rs.getString("filename");
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return name;
    }
    
    public static int deletePost(int id)
    {
        int status =0;
        try{
            PreparedStatement ps = con.prepareStatement("delete from post where id = ?");
            ps.setInt(1,id);
            status = ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return status;
    }
}
