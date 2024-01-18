
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
        <div class="input">
            <input type="text" placeholder="Search your blog with name, catagories">
            <button>SEARCH</button>
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