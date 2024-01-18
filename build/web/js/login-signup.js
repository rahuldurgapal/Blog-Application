window.onload = function () {
    var hash = window.location.hash;
    if (hash === '#signup') {
        toggleForm('signup');
    } else {
        toggleForm('login');
    }
};

function toggleForm(formId) {
    document.getElementById('login').style.display = formId === 'login' ? 'block' : 'none';
    document.getElementById('signup').style.display = formId === 'signup' ? 'block' : 'none';
}

const password = document.querySelectorAll('.password');

for (let i = 0; i < password.length; i++) {
    let l = password[i].querySelector('.fa');
    let val = password[i].querySelector('input');
    l.addEventListener('click', () => {
        if (l.classList.contains('fa-eye')) {
            l.classList.remove('fa-eye');
            l.classList.add('fa-eye-slash');
            val.type = 'text';
        } else if (l.classList.contains('fa-eye-slash')) {
            l.classList.remove('fa-eye-slash');
            l.classList.add('fa-eye');
            val.type = 'password';
        }
    });
    val.addEventListener('input', () => {
        if (val.value != '') {
            l.classList.remove('fa-lock');
            l.classList.add('fa-eye');
        } else {
            l.classList.remove('fa-eye');
            l.classList.add('fa-lock');
        }
    })
}

document.getElementById('loginForm').addEventListener('submit', function (event) {
    // Prevent the default form submission
    // Your custom submission logic here
    const formData = new FormData(this);
    if (check(formData, 'login')) {
        console.log('Custom login submission');
//        submitForm(formData, 'login');
    } else {
        event.preventDefault(); 
        document.getElementById('login').querySelector('.message').innerHTML = '<p>Insert data is not matched</p>'
    }
});

document.getElementById('signupForm').addEventListener('submit', function (event) {
     // Prevent the default form submission
    // Your custom submission logic here
    const formData = new FormData(this);

    // Log the form values
    if (check(formData, 'signup')) {
        console.log('Custom signup submission');
//        submitForm(formData, 'signup');
    } else {
        event.preventDefault();
        document.getElementById('signup').querySelector('.message').innerHTML = '<p>Insert data is not matched</p>'
    }
});

function check(formData, formName) {
    if (formName == 'signup') {
        if (formData.get('password') != formData.get('confirm_password') || formData.get('email') == '' || formData.get('password') == '')
            return false;
        return true;
    } else {
        if (formData.get('email') == '' || formData.get('password') == '')
            return false;
        return true;
    }
}



