<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<HTML>
<title>Home</title>
<jsp:include page="includes.jsp"/>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
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

        .home-container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            width: 150%;
            max-width: 550px;
        }

        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .placeholder {
            background-color: #f0f0f0;
            display: inline-block;
            height: 1em;
            width: 100%;
            border-radius: 4px;
        }

        .placeholder-glow {
            animation: glow 1.5s infinite alternate;
        }

        @keyframes glow {
            from {
                opacity: 0.5;
                box-shadow: 0 0 8px #34d8eb;
            }
            to {
                opacity: 1;
                box-shadow: 0 0 16px #34d8eb;
            }
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .footer {
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: #ffffff;
            border-top: 1px solid #dcdcdc;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 60px;
            box-shadow: 0 -1px 5px rgba(0, 0, 0, 0.1);
        }

        .footer-item {
            text-align: center;
            flex: 1;
        }

        .footer-item i {
            font-size: 24px;
            color: #666;
            display: block;
        }

        .footer-item span {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            color: #666;
        }

        .footer-item:hover span,
        .footer-item:hover i {
            color: blueviolet;
        }

        #footer-home i {
            color: blueviolet;
        }

    </style>

</head>

<div class="home-container">
    <h2 class="form-title" style="font-weight: bold" id="greeting">Loading... </h2>
    <div class="row align-items-center">
        <div class="col-auto">
            <h5 style="font-weight: lighter; color: #888888; font-size: xx-small"> Warm Greeting From Purple Sense</h5>
        </div>
        <div class="col"></div>

        <div class="col-auto">
            <button type="button" class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                Order
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Order By Time</a></li>
            </ul>
        </div>
    </div>

    <hr>
    <!-- Placeholder Card -->
    <div id="placeholderCard" class="card" aria-hidden="true">
        <div class="col-md-4 col-12">
            <svg class="bd-placeholder-img img-fluid rounded-start" width="100%" height="250"
                 xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Image"
                 preserveAspectRatio="xMidYMid slice" focusable="false">
                <title>Placeholder</title>
                <rect width="100%" height="100%" fill="#868e96"></rect>
                <text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image</text>
            </svg>
        </div>
        <div class="card-body">
            <h5 class="card-title placeholder-glow">
                <span class="placeholder col-6"></span>
            </h5>
            <p class="card-text placeholder-glow">
                <span class="placeholder col-7"></span>
                <span class="placeholder col-4"></span>
                <span class="placeholder col-4"></span>
                <span class="placeholder col-6"></span>
                <span class="placeholder col-8"></span>
            </p>
            <a class="btn btn-primary disabled placeholder col-6" aria-disabled="true"></a>
        </div>
    </div>

    <!-- Actual Content Container -->
    <div id="contentContainer" style="display: none;">
        <!-- Content will be dynamically filled here -->
    </div>

</div>


<footer class="footer">
    <div class="footer-item" id="footer-home">
        <i class="fas fa-home"></i>
        <span>Home</span>
    </div>
    <div class="footer-item" onclick="window.location.replace('/quiz_main.jsp')" id="footer-survey">
        <i class="fas fa-compass"></i>
        <span>Survey</span>
    </div>
    <div class="footer-item" onclick="window.location.replace('/user.jsp')" id="footer-user">
        <i class="fas fa-user"></i>
        <span>User</span>
    </div>
</footer>
</HTML>

<script type="text/javascript">

    window.onload = function () {
        loadResult();

    };


    function getGreeting() {
        const currentHour = new Date().getHours();
        let greeting;

        if (currentHour >= 5 && currentHour < 12) {
            greeting = "Good Morning！";
        } else if (currentHour >= 12 && currentHour < 18) {
            greeting = "Good Afternoon！";
        } else {
            greeting = "Good Evening！";
        }

        return greeting;
    }

    function displayGreeting() {
        const greeting = getGreeting();
        const greetingElement = document.getElementById("greeting");

        if (greetingElement) {
            greetingElement.textContent = greeting;
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        displayGreeting();
    });

    let events = {}

    function loadResult() {
        // 显示占位符
        document.getElementById('placeholderCard').style.display = 'block';
        document.getElementById('contentContainer').style.display = 'none';

        axios.post('/home', {"act": "getData"})
            .then(function (response) {
                console.log(response.data);
                // 构建实际内容
                let events = response.data.events;
                let content = '';

                events.forEach(event => {
                    content += `
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-md-4">
                                <svg class="bd-placeholder-img img-fluid rounded-start" width="100%" height="250" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Image" preserveAspectRatio="xMidYMid slice" focusable="false">
                                    <rect width="100%" height="100%" fill="#868e96"></rect>
                                    <text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image</text>
                                </svg>
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">` + event.title + `</h5>
                                    <p class="card-text">` + event.content + `</p>
                                    <p class="card-text"><small class="text-body-secondary">Last updated ` + event.create_time + `</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                });

                // 替换占位符为实际内容
                document.getElementById('contentContainer').innerHTML = content;
                document.getElementById('placeholderCard').style.display = 'none';
                document.getElementById('contentContainer').style.display = 'block';
            })
            .catch(function (error) {
                console.error('请求失败', error);
                // 处理请求失败的情况
            });
    }

    // Delete table rows but remain the header
    function deleteTable(table) {
        var rows = table.rows.length;
        for (var i = 1; i < rows; i++) {
            table.deleteRow(1);
        }
    }

    // Set table data
    function setTable(table, data) {
        var label_style = '<label style="width:90%;color:blue;" onclick="alert(123)">';
        for (var i = 0; i < data.length; i++) {
            var row = table.insertRow();
            var c1 = row.insertCell();
            var c2 = row.insertCell();
            c1.innerHTML = label_style + data[i]['title'] + '</label>';
            c2.innerText = data[i]['create_time'].substring(0, 10);
        }
    }

    // Show Bulletin
    function showBulletin() {
        bulletin.style.display = 'block';
        activity.style.display = 'none';
        a1.style.textDecoration = 'underline';
        a2.style.textDecoration = 'none';
    }

    // Show Activity
    function showActivity() {
        bulletin.style.display = 'none';
        activity.style.display = 'block';
        a1.style.textDecoration = 'none';
        a2.style.textDecoration = 'underline';
    }

</script>
