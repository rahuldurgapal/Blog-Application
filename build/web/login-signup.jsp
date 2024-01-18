<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String message = (String) session.getAttribute("message");
String success = (String) session.getAttribute("success");

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- It is an Awesome Font Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login-signup.css">
  
    <script src="js/login-signup.js" defer></script>
    <title>Login</title>
</head>

<body>
   
<!--    Login Form-->
    <div class="container" id="login">
        <h2>Welcome Back!</h2>
        <p>Log in to access your account</p>
<div class="message">
          <%
                if(message!=null)
                { %>
            <p class="error"><%=  message %></p>
        <%
            session.removeAttribute("message");
          }
                
                
                %>
                </div>   
        <form action="LoginServlet" method="post" class="box" id="loginForm">
            <div class="input">
                <i class="fa fa-envelope"></i>
                <input type="email" name="email" placeholder="Enter Email" required>
            </div>
            <div class="input password">
                <i class="fa fa-lock"></i>
                <input type="password" name="password" placeholder="Enter Your Password" required>
            </div>
            <button type="submit" class="input">Login</button>
            <p>Not a member? <a href="#signup" onclick="toggleForm('signup')">Signup Here</a></p>
        </form>
    </div>
    
    
<!--    Signup Form-->
    <div class="container" id="signup" style="display: none;">
        <h2>Join us today!</h2>
        <p>Signup now to become a member</p>
<div class="message">
        <%
                if(success!=null)
                { %>
                
            <p class="success"> <%=  success %></p>
        
        <%
            session.removeAttribute("success");
          }
                
                
                %>
                
                </div>
       
        <form action="SignupServlet" method="post" class="box" id="signupForm">
            <div class="input">
                <i class="fa fa-user"></i>
                <input type="name" name="name" placeholder="Enter Name" required>
            </div>
            <div class="input">
                <i class="fa fa-envelope"></i>
                <input type="email" name="email" placeholder="Enter Email" required>
            </div>
            <div class="input password">
                <i class="fa fa-lock"></i>
                <input type="password" name="password" placeholder="Enter Your Password" required>
            </div>
            <div class="input password">
                <i class="fa fa-lock"></i>
                <input type="password" name="confirm_password" placeholder="Re-Enter Your Password" required>
            </div>
            <button type="submit" class="input">Signup</button>
            <p>Already a member? <a href="#login" onclick="toggleForm('login')">Login Here</a></p>
        </form>
    </div>

</body>

</html>