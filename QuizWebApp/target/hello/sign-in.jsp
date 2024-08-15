<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<!DOCTYPE html>

<html lang="en">

<head>
    <jsp:include page="includes.jsp"/>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        .container {
            margin: auto;
            background-color: #f5f5f5;

        }

        .forgot-password {
            border-color: transparent;
            color: #007bff;
        }

        .bubble-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* 调整为负数，使其位于后面 */
        }

        .bubble {
            position: absolute;
            border-radius: 50%;
            opacity: 0.7;
            animation: float 5s linear infinite;
        }

        @keyframes float {
            0% {
                transform: translateY(0) scale(1);
                opacity: 0.7;
            }
            100% {
                transform: translateY(-1000px) scale(0.1);
                opacity: 0;
            }
        }

        .is-invalid {
            border-color: red;
        }
    </style>

</head>
<body>

<div class="container">
    <div class="bubble-container">

        <div class="login-container">

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="text-center mt-5" style="font-weight: bold">Welcome To <span style="color: blueviolet">Purple Sense!</span>
                    </h2>
                    <p class="text-center mt-5" style="color: #999999; font-size: smaller">Please sign in or sign
                        up</p>

                    <form>
                        <div class="form-floating mb-3">
                            <input class="form-control" id="username" placeholder="username">
                            <label for="username">Username</label>
                        </div>
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" placeholder="Password">
                            <label for="password">Password</label>
                        </div>
                        <div style="padding: 10px"></div>
                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" id="terms">
                            <label class="form-check-label" for="terms">Remember Me</label>
                        </div>
                        <div style="padding: 15px"></div>

                        <button type="button" class="btn btn-primary btn-block" onclick="submit_sign_form(event)">Login
                        </button>
                        <div style="padding: 10px"></div>
                        <label class="form-check-label" for="terms">Don't have an account? <a
                                href="${pageContext.request.contextPath}/sign-up.jsp">sign
                            up</a></label>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>


<script type="text/javascript">

    window.onload = function () {
        generateBubbles();
    };

    window.onpageshow = function () {
        var username = localStorage.getItem("username");

        if (username != null) {
            $('#username').val(username);
        }

    }

    function submit_sign_form(event) {
        event.preventDefault(); // Add this line to prevent default form submission

        const username = $('#username').val();
        const password = $('#password').val();

        const sign_json = {
            "act": "signIn",
            "user_name": username,
            "password": password
        }
        axios.post('/user?act=input', sign_json)
            .then(function (response) {
                console.log(response.data);
                if (response.data === 'Invalid user name or password') {
                    // Handle invalid credentials scenario
                    handleInvalidCredentials();
                } else {
                    // Handle successful login scenario
                    handleSuccessfulLogin();
                }
            })
            .catch(function (error) {
                console.error('请求失败', error);
                // Assuming error.response.data contains the error message
                if (error.response.data === 'Invalid user name or password') {
                    // Handle invalid credentials scenario
                    handleInvalidCredentials();
                } else {
                    // Handle other errors if needed
                }
            });
    }

    function handleInvalidCredentials() {
        // Add 'is-invalid' class to the input fields
        document.getElementById('username').classList.add('is-invalid');
        document.getElementById('password').classList.add('is-invalid');

        // Create a new div element for the invalid feedback
        var feedbackDiv = document.createElement('div');
        feedbackDiv.className = 'invalid-feedback';
        feedbackDiv.textContent = 'Invalid Username or Password.';

        // Append the new div element to the parent element of the username input
        var usernameInput = document.getElementById('password');
        usernameInput.parentElement.appendChild(feedbackDiv);
    }


    function handleSuccessfulLogin() {
        // Remove 'is-invalid' class from the input fields (if needed)
        document.getElementById('username').classList.remove('is-invalid');
        document.getElementById('password').classList.remove('is-invalid');
        // Redirect to home page or do other actions
        window.location.href = "/home.jsp";
    }

    function generateBubbles() {
        const bubbleContainer = document.querySelector('.bubble-container');
        const colors = ['#FF6347', '#00BFFF', '#FFD700', '#98FB98', '#FFA07A']; // Array of bubble colors
        const sizes = ['20px', '30px', '40px', '50px']; // Array of bubble sizes

        // Generate 30 bubbles
        for (let i = 0; i < 30; i++) {
            const bubble = document.createElement('div');
            const size = sizes[Math.floor(Math.random() * sizes.length)];
            const color = colors[Math.floor(Math.random() * colors.length)];

            bubble.className = 'bubble';
            bubble.style.width = size;
            bubble.style.height = size;
            bubble.style.background = color;

            // Random position
            bubble.style.left = Math.random() * 100 + 'vw';
            bubble.style.animationDuration = Math.random() * 6 + 5 + 's'; // Vary animation duration slightly

            bubbleContainer.appendChild(bubble);
        }
    }

</script>
