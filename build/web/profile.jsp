
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    
    UserDetail user1 = (UserDetail)session.getAttribute("user");
    if (user1 == null) {
        session.setAttribute("message", "please login first!!");
        response.sendRedirect("index.jsp");
        return;  // Important: Add a return statement to exit the scriptlet
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/profile.css">
        <link rel="stylesheet" href="css/styles.css">
        <script src="js/profile.js" defer></script>
        <!-- It is a Awasome Font Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Document</title>
    </head>

    <body>
        <%@include file="components/header.jsp" %>
        <main>
            <div class="profile">
                <div class="pic">
                    
                    <img src="<%= "img"+File.separator+"user" +File.separator+ user1.getPicture()%>" alt="">
                     
                    <button style="display: none;">Change Picture</button>
                   
                </div>
                <hr>
                <div class="change-button">
                    <a href="LogoutServlet" class="logout"><i class="fa fa-power-off"></i> Logout</a>
                    <button id="check" class="edit"><i class="fa fa-edit"> Edit Profile</i></button>
                </div>
                <div class="info">
                    <p class="name"><%= user1.getName()%></p>
                    <!--                <p class="title">Software Engineer</p>-->
                    <p class="mail"><%=  user1.getEmail()%></p>
                    <a href="post-by-user.jsp?userid=<%= user1.getId()  %>" style="background-color: blueviolet; padding: 5px 10px; border-radius: 15px;">View written Blogs</a>
                </div>
                    
                    
       <form action="UpdateUserServlet" method="post" class="update" style="display: none;" enctype="multipart/form-data">
    <input type="hidden" value="<%= user1.getId() %>" name="userid">
   <input type="file" onchange="showImage();" name="pic" id="pic" accept="image/*" style="display: none;" >
    <label for="">Name: </label> 
    <div class="input">
        <input type="text" name="name" value="<%= user1.getName() %>" required=""/>
    </div>
    
    <label for="">Email: </label>
    <div class="input">
        <input type="email" name="email" value="<%= user1.getEmail() %>" required=""/>
    </div>
    
    <label for="">Password: </label>
    <div class="input">
        <i class="fa fa-lock" id="passid"></i>
        <input id="pass" type="password" name="password" value="<%= user1.getPassword() %>" required="">
    </div>
    
    <label for="">Confirm Password: </label>
    <div class="input">
        <i class="fa fa-lock" id="cskpassid"></i>
        <input id="cskpass" type="password" name="confirm" value="<%= user1.getPassword() %>" required=""/>
    </div>
    
    <button type="submit" style="margin:10px;background-color: rgb(8, 164, 70);
            font-size: medium; border:none; padding:5px;
            color: white; border-radius: 10px">
        <i class="fa fa-save"> Save</i></button>
</form>
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