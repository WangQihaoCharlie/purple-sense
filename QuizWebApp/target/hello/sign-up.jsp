<%@ page contentType="text/html;charset=UTF-8" session="false" %>

<HTML>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <jsp:include page="includes.jsp"/>

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .sign-up-container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            width: 150%;
            max-width: 550px;
        }

        .sign-up-container:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .form-title {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .form-floating > input,
        .form-floating > select,
        .form-floating > textarea {
            border-radius: 5px;
        }

        .input-group-text {
            border-radius: 5px 0 0 5px;
        }

        .optional-label {
            margin-top: 1rem;
            margin-bottom: 0.5rem;
            color: #888;
            font-size: 0.9rem;
        }

        .row .col {
            padding-right: 5px;
            padding-left: 5px;
        }

        .form-select.reduced-width {
            max-width: 250px;
        }

        /* 新增的 CSS 样式 */
        .btn-back {
            position: fixed; /* 使用固定定位 */
            top: 20px; /* 距离页面顶部的距离 */
            left: 20px; /* 距离页面左侧的距离 */
            z-index: 1000; /* 确保按钮位于其他内容之上 */
        }

        /* 调整内容的样式和布局 */
        .sign-up-container {
            margin-top: 60px; /* 留出按钮位置的空间 */
            padding: 2rem;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            max-width: 550px;
            margin-left: auto; /* 使内容居中 */
            margin-right: auto; /* 使内容居中 */
        }

        /* 调整导航栏的 z-index，避免被按钮遮挡 */
        .navbar {
            z-index: 999; /* 比按钮的 z-index 小 */
        }


    </style>
</head>
<body>

<div class="sign-up-container">

    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="btn btn-light btn-back" href="javascript:history.back();">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>
    </nav>

    <h2 class="form-title" style="font-weight: bold">Welcome to Join <span
            style="color: blueviolet">Purple Sense!</span></h2>

    <div class="container mb-3" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);padding: 10px">
        <label for="role" class="form-label">You Are</label>

        <div class="row align-items-center">
            <div class="row align-items-center">
                <div class="col-auto">
                </div>
                <div class="col">
                    <select class="form-select" id="role" name="role">
                        <option selected>Guardian</option>
                        <option>Volunteer</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#guardianModal"
                            id="guardianButton" data-bs-placement="top" title="This is a red tooltip">
                        Children Sign Up
                    </button>

                    <div class="modal fade" id="guardianModal" tabindex="-1" aria-labelledby="guardianModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Sign Up for Your Children</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);padding: 10px">
                                        <div id="childrenInputsContainer" onload="loadChildrenData()">
                                            <div class="children-input mb-3">
                                                <div class="row">
                                                    <div class="col">
                                                        <label class="optional-label" style="font-weight: bold;">Children
                                                            #1</label>
                                                    </div>
                                                    <div class="col-auto">
                                                        <button type="button" class="btn-close" aria-label="Close"
                                                                onclick="removeInput(this)"></button>
                                                    </div>
                                                </div>
                                                <div class="form-floating">
                                                    <input type="text" class="form-control children-username"
                                                           placeholder="Your Kid's Username">
                                                    <label>Username</label>
                                                </div>
                                                <div class="form-floating">
                                                    <input type="password" class="form-control children-password"
                                                           placeholder="Your Kid's Password">
                                                    <label>Password</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-block btn-outline-secondary mt-3"
                                            onclick="addMore()">Add More
                                    </button>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
                                    <button type="button" class="btn btn-primary" onclick="saveChildrenData()">Save
                                        changes
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <label class="optional-label" style="font-weight: bold">Below Are Required Fields</label>

    <div style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);padding: 10px">
        <div class="mb-3">
            <div class="form-floating">
                <input type="text" class="form-control" id="username" placeholder="Username">
                <label for="username">Username</label>
            </div>
        </div>

        <div class="mb-3">
            <div class="form-floating">
                <input type="password" class="form-control" id="password" placeholder="Password">
                <label for="password">Password</label>
            </div>
        </div>
    </div>
    <label class="optional-label" style="font-weight: bold">Below Are Optional Fields</label>

    <div style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);padding: 10px">
        <div class="row">
            <div class="col-xm mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email">
            </div>
            <div class="col-xm mb-3">

                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phone">
            </div>
            <div class="col-xm mb-3">


                <label for="nickname" class="form-label">Nickname</label>
                <input type="text" class="form-control" id="nickname">
            </div>

            <div class="col-xm mb-3">
                <label for="birthYear" class="form-label">Birth Year</label>
                <input type="text" class="form-control" id="birthYear" placeholder="YYYY">
            </div>
            <div class="col-xm mb-3">
                <label for="gender" class="form-label">Gender</label>
                <select class="form-select" id="gender">
                    <option selected>Male</option>
                    <option>Female</option>
                    <option>Non-Binary</option>
                </select>
            </div>


            <div class="col-xm mb-3">
                <label for="inputCity" class="form-label">City</label>
                <input type="text" class="form-control" id="inputCity">
            </div>
            <div class="col-xm mb-3">
                <label for="state" class="form-label">State</label>
                <select id="state" class="form-select">
                </select>
            </div>
            <div class="col-xm mb-3">
                <label for="inputZip" class="form-label">Zip</label>
                <input type="text" class="form-control" id="inputZip">
            </div>

        </div>

        <div style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);padding: 10px">
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="terms">
                <label class="form-check-label" for="terms">I agree to the <a href="sign_form.jsp">terms and
                    condition</a></label>
            </div>
        </div>

    </div>
    <button type="submit" id="signup-button" class="btn btn-primary w-100" onclick="submit_register_form()" disabled>Sign Up</button>
</div>
</body>
</html>

<script type="text/javascript">

    window.onload = function () {
        // Add an event listener to the checkbox
        document.getElementById('terms').addEventListener('change', toggleSignupButton);

        // Optional: Ensure the button state is correct on page load
        document.addEventListener('DOMContentLoaded', toggleSignupButton);

    }

    const jsonFile = "https://gist.githubusercontent.com/mshafrir/2646763/raw/8b0dbb93521f5d6889502305335104218454c2bf/states_hash.json";
    const selectElement = document.getElementById('state');

    // 使用 Axios 获取 JSON 数据
    axios.get(jsonFile)
        .then(response => {
            const data = response.data;

            // 使用 Object.entries 将对象转换为 [key, value] 数组的形式
            Object.entries(data).forEach(([key, value]) => {
                const option = document.createElement('option');
                option.value = key;
                option.textContent = value;
                selectElement.appendChild(option);
            });

            // 设置默认选中的州为 Michigan
            selectElement.value = 'MI'; // Michigan 的对应值
        })
        .catch(error => {
            console.error('Error fetching JSON: ', error);
        });


    document.getElementById('role').addEventListener('change', function () {
        var role = this.value;
        var button = document.getElementById('guardianButton');
        if (role === 'Guardian') {
            button.classList.remove('d-none');
            this.classList.add('reduced-width');
        } else {
            button.classList.add('d-none');
            this.classList.remove('reduced-width');
        }
    });

    let count = 1;

    function addMore() {
        const container = document.getElementById('childrenInputsContainer');

        count++;
        // 创建一个新的 children 输入框组
        const childrenInput = document.createElement('div');
        childrenInput.classList.add('children-input', 'mb-3');
        childrenInput.innerHTML = `
            <div class="row">
                <div class="col">
                        <label class="optional-label" style="font-weight: bold;">Children #` + count + `</label>
                </div>
                <div class="col-auto">
                    <button type="button" class="btn-close" aria-label="Close" onclick="removeInput(this)"></button>
                </div>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control children-username" placeholder="Your Kid's Username">
                <label>Username</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control children-password" placeholder="Your Kid's Password">
                <label>Password</label>
            </div>
    `;
        container.appendChild(childrenInput);
    }



    function removeInput(button) {
        const inputContainer = button.parentNode.parentNode.parentNode;
        const length = document.getElementById("childrenInputsContainer").children.length;

        if (length === 1) {
            return;
        }

        count--;
        inputContainer.parentNode.removeChild(inputContainer);
    }


    function loadChildrenData() {
        let children_input_container = document.getElementById("childrenInputsContainer");
        children_input_container.innerHTML = ''; // 清空容器中原有的内容

        children_data.forEach(function (child, index) {
            let childrenInputHtml = `
            <div class="children-input mb-3">
                <div class="row">
                    <div class="col">
                        <label class="optional-label" style="font-weight: bold;">Children #` + count + `</label>
                    </div>
                    <div class="col-auto">
                        <button type="button" class="btn-close" aria-label="Close" onclick="removeInput(this)"></button>
                    </div>
                </div>
                <div class="form-floating">
                    <input type="text" class="form-control children-username" placeholder="Your Kid's Username" value="` + child.kid_username + `}">
                    <label>Username</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control children-password" placeholder="Your Kid's Password" value="` + child.kid_password + `">
                    <label>Password</label>
                </div>
            </div>
        `;
            children_input_container.insertAdjacentHTML('beforeend', childrenInputHtml);
        });
    }

    const children_data = []

    function saveChildrenData() {
        let children_input_container = document.getElementById("childrenInputsContainer");
        const children_info_arr = Array.from(children_input_container.children);

        children_info_arr.forEach(function (children_info) {
            let kid_username = children_info.children[1].firstElementChild.value;
            let kid_password = children_info.children[2].firstElementChild.value;
            console.log(kid_username)
            console.log(kid_password)

            children_data.push({kid_username, kid_password})
        });
        $("#guardianModal").modal('hide')
        // 此处密码应该加密存储，但是后端不接受加密的密码，所以暂时搁置
    }

    function submit_register_form() {
        const role = $('#role').val();
        const username = $('#username').val();
        const password = $('#password').val();
        const email = $('#email').val();
        const phone = $('#phone').val();
        const nickname = $('#nickname').val();
        const birthYear = $('#birthYear').val();
        const gender = $('#gender').val();
        const city = $('#inputCity').val();
        const state = $('#state').val();
        const zip = $('#inputZip').val();

        let user_register_data = {
            "act": "addUser",
            "users": [
                {
                    "user_type": (role === 'Guardian') ? "2" : "1",
                    "user_name": username,
                    "password": password,
                    "email": email,
                    "nickname": nickname,
                    "birth_year": birthYear,
                    "gender": (gender === 'Male') ? "1" : "2",
                    "city": city,
                    "state": state,
                    "zip": zip,
                    "phone1": phone.substring(0, 3),
                    "phone2": phone.substring(3, 6),
                    "phone3": phone.substring(6, 10),
                    "phone": phone
                },

            ],
        }

        let existingUsers = user_register_data['users'] || [];

        if (role === "Guardian" && children_data.length === 0) {
            showInvalid("You have to Sign up for your child as a Guardian");
            return;
        } else if (username === '' || password === '') {
            showInvalid("Please Enter Username or Password");
            return;
        } else if (password.length < 6) {
            showInvalid("Password must be longer than 6 digits");
            return;
        } else if (username.includes(" ")) {
            showInvalid("Space is not allowed in username");
            return;
        }

// 删除不符合条件的子用户数据
        for (let i = children_data.length - 1; i >= 0; i--) {
            let child = children_data[i];
            if (child["kid_username"].includes(" ")) {
                showInvalid("Child username cannot contain spaces: " + child["kid_username"]);
                children_data.splice(i, 1);
                return;
            }
            if (child["kid_password"].length < 6) {
                showInvalid("Child password must be longer than 6 digits: " + child["kid_username"]);
                children_data.splice(i, 1);
                return;
            }
        }

// 添加符合条件的子用户数据
        user_register_data['users'] = existingUsers.concat(
            children_data.map((child, index) => ({
                "user_id": existingUsers.length + index,
                "user_type": "3",
                "user_name": child["kid_username"],
                "password": child["kid_password"]
            }))
        );

        console.log(username);




        axios.post('/user?act=create', user_register_data)
            .then(function (response) {
                console.log(user_register_data);

                console.log(response.data)
                if (response.data === "OK") {
                    window.location.replace("/sign-in.jsp");
                } else if (response.data.includes("Duplicate")) {  // 使用 includes 方法
                    showInvalid("Sorry but your username has been taken");
                } else if (response.data.includes("Invalid user name")){
                    showInvalid("The username you set for your children is invalid");
                } else {
                    // 处理其他非预期情况
                    showInvalid("An unexpected error occurred.");
                }
            })
            .catch(function (error) {
                // 处理请求失败的情况
                console.error('请求失败', error);
                showInvalid("An unexpected error occurred while processing your request.");
            });

        localStorage.setItem("username", username);

    }


    function toggleSignupButton() {
        var checkbox = document.getElementById('terms');
        var button = document.getElementById('signup-button');
        button.disabled = !checkbox.checked;
    }

    function showInvalid(message) {
        // Get the username and password input elements
        var usernameInput = document.getElementById('username');
        var passwordInput = document.getElementById('password');

        // Remove existing error feedback for username and password
        removeExistingFeedback(usernameInput);
        removeExistingFeedback(passwordInput);

        // Add 'is-invalid' class to the input fields
        usernameInput.classList.add('is-invalid');
        passwordInput.classList.add('is-invalid');

        // Create a new div element for the invalid feedback
        var feedbackDiv = document.createElement('div');
        feedbackDiv.className = 'invalid-feedback';
        feedbackDiv.textContent = message;

        // Append the new div element to the parent element of the username input
        passwordInput.parentElement.appendChild(feedbackDiv);
    }

    // Helper function to remove existing feedback
    function removeExistingFeedback(inputElement) {
        // Get the parent element of the input field
        var parentElement = inputElement.parentElement;

        // Remove any existing feedback div
        var existingFeedback = parentElement.querySelector('.invalid-feedback');
        if (existingFeedback) {
            parentElement.removeChild(existingFeedback);
        }

        // Remove 'is-invalid' class from the input field
        inputElement.classList.remove('is-invalid');
    }


</script>
