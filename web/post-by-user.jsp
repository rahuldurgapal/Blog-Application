
<%@page import="com.Dao.CategoryDao"%>
<%@page import="com.Dao.UserDao"%>
<%@page import="com.Dao.PostDao"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDetail user1 = (UserDetail) session.getAttribute("user");
    if (user1 == null) {

        session.setAttribute("message", "Don't be Smart");
        response.sendRedirect("login-signup.jsp#login");
    }


%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- It is a Awasome Font Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <title>Document</title>
    </head>

    <body>
        <%@include file="components/header.jsp" %>
        <%
              int id= Integer.parseInt(request.getParameter("userid"));
               List<Post> post = PostDao.getAllPostByUserId(id);
              
                    
                   
            %>
        <main>
            
            <%
               if(post.size()==0)
               {
                %>
                
                <h1 style="text-align: center; padding: 20px;">No Blog Found </h1>
                
               <% } else { %> 
            
            <h1 style="text-align: center; padding: 20px;">Your Written Blogs are</h1>
            <div class="blogs">
                
                
                <%
                  
                    
                    for(Post ps: post)
                    {
                     
                      String userName = UserDao.getUserName(id);
                    %>
                    

                <div class="blog">
                    <img src="img/post/<%= ps.getPicture()  %>" alt=""
                         class="cover-img">
                    <h1 class="title">
                        <%= ps.getTitle()  %>
                    </h1> 
                    <p class="description">
                        <%= ps.getDescription() %>
                    </p>
                    <div class="info">
                        <p class="name"> <%= userName %> - 
                            <!--                        <span>August 10, 2024</span>-->
                        </p>
                        <div class="rate">
                            <a href="BlogServlet?id=<%= ps.getId()  %>" class="like" target="_blank">
                                View Blog   
                            </a>
                            <div class="comment"> 
                                <a href="BlogDeleteServlet?id=<%= ps.getId()  %>" class="like" onclick="return confirm('Are you sure you want to delete?')"> Delete </a>
                            </div> 
                        </div>

       
                    </div>
                  

                </div>
                    <% } %>
            </div>
            <% } %>
        </main>
        <%@include file="components/footer.jsp" %>
    </body>

</html>

<script>
    function dropdown(bars) {
        let value = document.querySelector('.nav-list');
        if (value.classList.contains('dropdown')) {
            value.classList.remove('dropdown');
            bars.classList.remove('bars-focus');
        } else {
            value.classList.add('dropdown');
            bars.classList.add('bars-focus');
        }
    }
</script>