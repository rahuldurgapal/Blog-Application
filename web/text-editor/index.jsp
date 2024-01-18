

<%@page import="java.io.StringWriter"%>
<%@page import="com.entity.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Post pt = (Post) session.getAttribute("post");
    if (pt == null) {
        response.sendRedirect("../index.jsp");
    }

%>


<%    boolean update = false;
    String title = pt.getTitle();
    String description = pt.getDescription();
    String html_content = "";
    String pic = pt.getPicture();
    int catid = pt.getCategory();
    int userid = pt.getUser();
    String date = pt.getDate();


%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Rich Text Editor</title>
        <!-- FontAwesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <!-- It is a Bootstrap CSS Link -->
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css'
              integrity='sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh'
              crossorigin='anonymous'>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
        <!-- Stylesheet -->
        <link rel="stylesheet" href="style.css" />
    </head>

    <body>
        <div class="container">
            <div class="save">
                <input type="text" id="fileName" value="<%= title%>">

                <div> 

                    <button id="saveFile" class="saveFile"><i class="fa fa-save"> SAVE</i></button>

                </div>
            </div>
            <div class="options">
                <!-- Text Format -->
                <button id="bold" class="option-button format" data-toggle="tooltip" data-placement="top" title="bold">
                    <i class="fa-solid fa-bold"></i>
                </button>
                <button id="italic" class="option-button format" data-toggle="tooltip" data-placement="top" title="italic">
                    <i class="fa-solid fa-italic"></i>
                </button>
                <button id="underline" class="option-button format" data-toggle="tooltip" data-placement="top" title="underline">
                    <i class="fa-solid fa-underline"></i>
                </button>
                <button id="strikethrough" class="option-button format" data-toggle="tooltip" data-placement="top" title="Strikethrough">
                    <i class="fa-solid fa-strikethrough"></i>
                </button>
                <button id="superscript" class="option-button script" data-toggle="tooltip" data-placement="top" title="Superscript">
                    <i class="fa-solid fa-superscript"></i>
                </button>
                <button id="subscript" class="option-button script" data-toggle="tooltip" data-placement="top" title="Subscript">
                    <i class="fa-solid fa-subscript"></i>
                </button>

                <!-- List -->
                <button id="insertOrderedList" class="option-button" data-toggle="tooltip" data-placement="top" title="Order List">
                    <div class="fa-solid fa-list-ol"></div>
                </button>
                <button id="insertUnorderedList" class="option-button" data-toggle="tooltip" data-placement="top" title="Unorder List">
                    <i class="fa-solid fa-list"></i>
                </button>

                <!-- Undo/Redo -->
                <button id="undo" class="option-button" data-toggle="tooltip" data-placement="top" title="Undo">
                    <i class="fa-solid fa-rotate-left"></i>
                </button>
                <button id="redo" class="option-button" data-toggle="tooltip" data-placement="top" title="Redo">
                    <i class="fa-solid fa-rotate-right"></i>
                </button>

                <!-- Link -->
                <button id="createLink" class="adv-option-button" data-toggle="tooltip" data-placement="top" title="AddLink">
                    <i class="fa fa-link"></i>
                </button>
                <button id="unlink" class="option-button" data-toggle="tooltip" data-placement="top" title="Remove Link">
                    <i class="fa fa-unlink"></i>
                </button>
                <button id="createImage" class="option-button" data-toggle="tooltip" data-placement="top" title="Insert Image">
                    <i class="fa fa-image"></i>
                </button>

                <button id="embadeCode" class="option-button" data-toggle="tooltip" data-placement="top" title="Embade Code">
                    <i class="fa fa-code"></i>
                </button>

                <!-- Alignment -->
                <button id="justifyLeft" class="option-button align" data-toggle="tooltip" data-placement="top" title="Alignment left">
                    <i class="fa-solid fa-align-left"></i>
                </button>
                <button id="justifyCenter" class="option-button align" data-toggle="tooltip" data-placement="top" title="Alignment Center">
                    <i class="fa-solid fa-align-center"></i>
                </button>
                <button id="justifyRight" class="option-button align" data-toggle="tooltip" data-placement="top" title="Alignment Right">
                    <i class="fa-solid fa-align-right"></i>
                </button>
                <button id="justifyFull" class="option-button align" data-toggle="tooltip" data-placement="top" title="Justify Content">
                    <i class="fa-solid fa-align-justify"></i>
                </button>
                <button id="indent" class="option-button spacing" data-toggle="tooltip" data-placement="top" title="Intend">
                    <i class="fa-solid fa-indent"></i>
                </button>
                <button id="outdent" class="option-button spacing" data-toggle="tooltip" data-placement="top" title="Outtend">
                    <i class="fa-solid fa-outdent"></i>
                </button>

                <!-- Headings -->
                <select id="formatBlock" class="adv-option-button" data-toggle="tooltip" data-placement="top" title="Heading">
                    <option value="H1">H1</option>
                    <option value="H2">H2</option>
                    <option value="H3">H3</option>
                    <option value="H4">H4</option>
                    <option value="H5">H5</option>
                    <option value="H6">H6</option>
                </select>

                <!-- Font -->
                <select id="fontName" class="adv-option-button" data-toggle="tooltip" data-placement="top" title="Font Name"></select>
                <select id="fontSize" class="adv-option-button" data-toggle="tooltip" data-placement="top" title="Font Size"></select>

                <!-- Color -->
                <div class="input-wrapper" data-toggle="tooltip" data-placement="top" title="text color">
                    <input type="color" id="foreColor" class="adv-option-button" />
                    <label for="foreColor">Font Color</label>
                </div>
                <div class="input-wrapper" data-toggle="tooltip" data-placement="top" title="background color">
                    <input type="color" id="backColor" class="adv-option-button" />
                    <label for="backColor">Highlight Color</label>
                </div>
            </div>
            <div id="text-input" contenteditable="true"></div>
        </div>

    </body>

</html>


<script>
    let optionsButtons = document.querySelectorAll(".option-button");
    let advancedOptionButton = document.querySelectorAll(".adv-option-button");
    let fontName = document.getElementById("fontName");
    let fontSizeRef = document.getElementById("fontSize");
    let writingArea = document.getElementById("text-input");
    let linkButton = document.getElementById("createLink");
    let imageButton = document.getElementById("createImage");
    let embadedCode = document.getElementById("embadeCode");
    let alignButtons = document.querySelectorAll(".align");
    let spacingButtons = document.querySelectorAll(".spacing");
    let formatButtons = document.querySelectorAll(".format");
    let scriptButtons = document.querySelectorAll(".script");
    let saveButton = document.getElementById("saveFile");
    let updateButton = document.getElementById("updateFile");

    let append = false;

    //List of fontlist
    let fontList = [
        "Arial",
        "Verdana",
        "Times New Roman",
        "Garamond",
        "Georgia",
        "Courier New",
        "cursive",
    ];

    //Initial Settings
    const initializer = () => {
        //function calls for highlighting buttons
        //No highlights for link, unlink,lists, undo,redo since they are one time operations
        highlighter(alignButtons, true);
        highlighter(spacingButtons, true);
        highlighter(formatButtons, false);
        highlighter(scriptButtons, true);

        //create options for font names
        fontList.map((value) => {
            let option = document.createElement("option");
            option.value = value;
            option.innerHTML = value;
            fontName.appendChild(option);
        });

        //fontSize allows only till 7
        for (let i = 1; i <= 7; i++) {
            let option = document.createElement("option");
            option.value = i;
            option.innerHTML = i;
            fontSizeRef.appendChild(option);
        }

        //default size
        fontSizeRef.value = 3;
    };

    window.addEventListener('keydown', event => {
        if ((event.ctrlKey || event.metaKey) && (event.key === 'b' || event.key === 'B')) {
            event.preventDefault();
            document.querySelector('#bold').click();
        }
        if ((event.ctrlKey || event.metaKey) && (event.key === 'i' || event.key === 'I')) {
            event.preventDefault();
            document.querySelector('#italic').click();
        }
        if ((event.ctrlKey || event.metaKey) && (event.key === 'u' || event.key === 'U')) {
            event.preventDefault();
            document.querySelector('#underline').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.shiftKey && (event.key === 'l' || event.key === 'L')) {
            event.preventDefault();
            document.querySelector('#justifyLeft').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.shiftKey && (event.key === 'e' || event.key === 'E')) {
            event.preventDefault();
            document.querySelector('#justifyCenter').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.shiftKey && (event.key === 'r' || event.key === 'R')) {
            event.preventDefault();
            document.querySelector('#justifyRight').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.shiftKey && (event.key === 'f' || event.key === 'F')) {
            event.preventDefault();
            document.querySelector('#justifyFull').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.key === '+') {
            event.preventDefault();
            document.querySelector('#superscript').click();
        }
        if ((event.ctrlKey || event.metaKey) && event.key === '=') {
            event.preventDefault();
            document.querySelector('#subscript').click();
        }
    });


    //main logic
    const modifyText = (command, defaultUi, value) => {
        //execCommand executes command on selected text
        document.execCommand(command, defaultUi, value);
    };

    //For basic operations which don't need value parameter
    optionsButtons.forEach((button) => {
        button.addEventListener("click", () => {
            modifyText(button.id, false, null);
        });
    });

    //options that require value parameter (e.g colors, fonts)
    advancedOptionButton.forEach((button) => {
        button.addEventListener("change", () => {
            modifyText(button.id, false, button.value);
        });
    });

    //link
    linkButton.addEventListener("click", () => {
        let userLink = prompt("Enter a URL");
        //if link has http then pass directly else add https
        if (/http/i.test(userLink)) {
            modifyText(linkButton.id, false, userLink);
        } else {
            userLink = "http://" + userLink;
            modifyText(linkButton.id, false, userLink);
        }
    });

    imageButton.addEventListener("click", () => {
        let alt = prompt('Please enter image alt text:');
        if (alt !== null) {
            let url = prompt('Please enter image URL:');
            if (url !== null) {
                let width = prompt('Enter image width:', 'auto');
                if (width !== null) {
                    let imgTag = '<img src="' + (url.length > 0 ? url : '') + '"' +
                            (width !== 'auto' ? ' width="' + width + '"' : '') +
                            (alt.length > 0 ? ' alt="' + alt + '"' : '') +
                            '>';
                    document.execCommand('insertHTML', false, imgTag);
                }
            }
        }
    });

    embadedCode.addEventListener('click', () => {
        let videoCode = prompt('Enter the YouTube video embed code:');
        if (videoCode !== null) {
            // You can further validate the videoCode to ensure it's a valid YouTube embed code.
            document.execCommand('insertHTML', false, videoCode);
        }
    });

    //Highlight clicked button
    const highlighter = (className, needsRemoval) => {
        className.forEach((button) => {
            button.addEventListener("click", () => {
                //needsRemoval = true means only one button should be highlight and other would be normal
                if (needsRemoval) {
                    let alreadyActive = false;

                    //If currently clicked button is already active
                    if (button.classList.contains("active")) {
                        alreadyActive = true;
                    }

                    //Remove highlight from other buttons
                    highlighterRemover(className);
                    if (!alreadyActive) {
                        //highlight clicked button
                        button.classList.add("active");
                    }
                } else {
                    //if other buttons can be highlighted
                    button.classList.toggle("active");
                }
            });
        });
    };

    const highlighterRemover = (className) => {
        className.forEach((button) => {
            button.classList.remove("active");
        });
    };



    saveButton.addEventListener("click", () => {
        let contentToSave = "";

       
            contentToSave = '<div class="notes_block"> '+document.getElementById('text-input').innerHTML+'</div>';
           
       

        const fileName = document.getElementById('fileName').value + ".html";
        const title = document.getElementById('fileName').value;
        const description = '<%= description%>';
        const category = <%=  catid%>;
        const pic = '<%= pic%>';
        const user = <%= userid%>;
        const date = '<%= date %>';


    const xhr = new XMLHttpRequest();
    xhr.open('POST', '../TestServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log(document.getElementById('text-input'));
            console.log(document.getElementById('text-input').innerHTML);
            console.log(contentToSave);
            alert(xhr.responseText);
            location.replace("../index.jsp");
        }
    };

    
    const data = 'content=' + encodeURIComponent(contentToSave) +
                 '&title=' + encodeURIComponent(title) +
                 '&filename=' + encodeURIComponent(fileName) +
                 '&description=' + encodeURIComponent(description) +
                 '&picture=' + encodeURIComponent(pic) +
                 '&category=' + encodeURIComponent(category) +
                 '&user=' + encodeURIComponent(user) +
                 '&date=' + encodeURIComponent(date);

    xhr.send(data);




    });




    window.addEventListener('beforeunload', (e) => {
        e.preventDefault();
        e.returnValue = 'Are you sure you want to leave this page? Your data may be lost.';
    });


    window.onload = () => {

        initializer();
    }
</script>