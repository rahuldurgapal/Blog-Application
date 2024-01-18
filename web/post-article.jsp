

<%@page import="com.Dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDetail user1 = (UserDetail) session.getAttribute("user");
    if (user1 == null) {
        session.setAttribute("message", "please login first !!");
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
        <main>
            <div class="container">
                <form action="PostServlet" method="post" enctype="multipart/form-data">
                    <h1 style="text-align: center;">Blog Form</h1>
                    <hr>
                    <input type="hidden" value="<%= user1.getId()  %>" name="userid">
                    <div class="input">
                        <input type="file" name="file" id="cover-img" accept="image/*" required="require">
                    </div>
                    <div class="input">
                        <input type="text" name="title" id = "title" placeholder="Title name" required="require">
                    </div>
                    <div class="input">
                        <textarea type="text" name="description" id="description" rows="5" placeholder="Descriptions . . ."  required="require"></textarea>
                        <p id="result"></p>
                    </div>
                    <div class="input">




                        <select name="category" id="categoriesSelect" required="require">
                            <option value="" selected>Select a Catagories</option>
                            <%
                                List<Category> cat = CategoryDao.getCategory();
                                for (Category ct : cat) {

                            %>

                            <option value="<%=  ct.getId()%>"><%= ct.getName()%></option>


                            <% }%>
                            <option value="-1">other</option>
                        </select>

                    </div>
                    <div id="otherOptionContainer" class="input" style="display: none;">
                        <input type="text" name="cat" id="otherOptionInput" placeholder="Other option"/>
                    </div>
                    <button type="submit" style="padding: 10px; font-weight: bolder;">Next >> </button>
                </form>
                <script>
                    document.getElementById('categoriesSelect').addEventListener('change', function () {
                        let selectedValue = this.value;
                        let otherOptionContainer = document.getElementById('otherOptionContainer');

                        // Check if the selected value is "Other"
                        if (selectedValue === '-1') {
                            otherOptionContainer.style.display = 'block';
                        } else {
                            otherOptionContainer.style.display = 'none';
                        }
                    });
                </script>
                <div class="blog">
                    <img src="https://payu.in/blog/wp-content/uploads/2019/01/Blog-Cover.gif" alt=""
                         class="cover-img">
                    <h1 class="title">
                        Your Blog Title
                    </h1>
                    <p class="description">
                        Your Blog Descriptions
                    </p>
                    <div class="info">
                        <p class="name"></p>
                        <div class="rate">
                            <div class="like">
                                <i class="fa fa-thumbs-up"></i> Likes waiting
                            </div>
                            <div class="comment"><i class="fa fa-comment"></i> Comments waiting</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        
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

<script>
    var myText = document.getElementById("description");
    var result = document.getElementById("result");
    var title = document.getElementById('title');
    var cover = document.getElementById('cover-img');
    var description = document.querySelector('.blog .description');
    var blog_title = document.querySelector('.blog .title');
    var blog_cover = document.querySelector('.blog .cover-img');
    var blog_name = document.querySelector('.blog .name');
    var limit = 250;

    updateCounter();

    myText.addEventListener("input", function () {
        var textLength = myText.value.length;

        if (textLength > limit) {
            myText.value = myText.value.slice(0, limit);
            textLength = limit; // Update textLength after trimming
        }


        updateCounter();
        // Apply styling based on the limit
        description.textContent = textLength == 0 ? "Your Blog Descriptions" : myText.value;
        myText.style.borderColor = textLength >= limit ? "#ff2851" : "#31821b";
        result.style.color = textLength >= limit ? "#ff2851" : "#31821b";
    });

    title.addEventListener("input", function () {
        var textLength = title.value.length;
        blog_title.textContent = textLength == 0 ? "Your Blog Title" : title.value;
    })

    cover.addEventListener('change', function () {
        var file = cover.files[0];

        if (file) {
            var reader = new FileReader();

            reader.onload = function (e) {
                blog_cover.src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            blog_cover.src = "https://payu.in/blog/wp-content/uploads/2019/01/Blog-Cover.gif";
        }
    })

    function name_time() {
        var currentDate = new Date();
        var options = {year: 'numeric', month: 'long', day: 'numeric'};
        var formattedDate = currentDate.toLocaleDateString('en-US', options);
        var username = 'Arjun Tripathi'
        blog_name.innerHTML = `${username} - <span>${formattedDate}</span>`;
    }

    function updateCounter() {
        var textLength = myText.value.length;
        result.textContent = textLength + "/" + limit;
    }
    name_time();


</script>
