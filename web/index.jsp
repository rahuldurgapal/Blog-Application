
<%@page import="com.Dao.UserDao"%>
<%@page import="com.Dao.PostDao"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <main>
            <h1 style="text-align: center; padding: 20px;">Our Top Resources</h1>
            <div class="blogs">
                <%
                    List<Post> post = PostDao.getAllPost();
                    
                    for(Post ps: post)
                    {
                      int userid = ps.getUser();
                      String userName = UserDao.getUserName(userid);
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
                                                   <span> <%= ps.getDate()  %> </span>
                        </p>
                        <div class="rate">
                            <a href="BlogServlet?id=<%= ps.getId()  %>" class="like" target="_blank">
                                View Blog   
                            </a>
                            <!--                        <div class="comment"><i class="fa fa-comment"> 2K</i> Comments</div>-->
                        </div>

       
                    </div>
                  

                </div>
                    <% } %>
            </div>
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