
<%@page import="com.entity.UserDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%   UserDetail user = (UserDetail)session.getAttribute("user");     %>
  <header>
        <a href="index.jsp"><h1>Blog Website</h1></a>
        <nav class="nav">
            <button class="bars" onclick="dropdown(this)"><i class="fa fa-bars"></i> MENU</button>
            <ul class="nav-list">
                <li><a href="category.jsp">Categories</a></li>
                <li><a href="search.jsp"><i class="fa fa-search"></i> Search</a></li>
                <li>About</li>
                
                          <!-- if login -->
                          <%
                              if(user!=null)
                              {
                              %>
                
                <li><a href="post-article.jsp"><i class="fa fa-file"></i> Post Article</a></li>
                <li><a href="profile.jsp"><i class="fa fa-user"></i> View Profile</a></li>

<% } 
else{
%>
                <!-- if not login -->
                <li><a href="login-signup.jsp"><i class="fa fa-user"></i> Login / Signup</a></li>
                
              <%  }   %>  
      
            </ul>
        </nav>
    </header>
