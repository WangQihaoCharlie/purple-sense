<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<HTML>
<title>Sign In</title>
<jsp:include page="includes.jsp"/>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz List</title>
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
            height: 100vh;
            max-width: 550px;
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

        #footer-survey i {
            color: blueviolet
        }

        .card {
            border-radius: 30px;
        }

        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>


<div class="home-container">
    <h2 class="form-title" style="font-weight: bold"> Please Fill these Survey </h2>


    <div class="card mb-3">
        <div style="padding: 5%">
            <label class="optional-label" style="font-weight: bold; color: #888888">New Forms</label>
            <div class="list-group" id="newForms">
                <p class="text-center text-muted initial-message">Loading...</p>
            </div>
        </div>
    </div>

    <div class="card mb-3">
        <div style="padding: 5%">
            <label class="optional-label" style="font-weight: bold; color: #888888">Past Forms</label>
            <div class="list-group" id="pastForms">
                <p class="text-center text-muted initial-message">Loading...</p>
            </div>
        </div>
    </div>


</div>
<footer class="footer">
    <div class="footer-item" onclick="window.location.replace('/home.jsp')" id="footer-home">
        <i class="fas fa-home"></i>
        <span>Home</span>
    </div>
    <div class="footer-item" id="footer-survey">
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


    function getSurveyInformation() {
        axios.post('/quiz', {"act": "getQuizMain"})
            .then(function (response) {
                console.log(response.data);
                displaySurveys(response.data);

            })
            .catch(function (error) {
                console.error('请求失败', error);
            });
    }

    // 页面加载完成后执行的函数
    document.addEventListener('DOMContentLoaded', function () {
        // 初始化时显示 Loading...
        document.querySelectorAll('.initial-message').forEach(function (element) {
            element.textContent = 'Loading...';
        });

        // 获取问卷信息并显示
        getSurveyInformation();
    });
    async function fetchQuestionsCount(quiz_id) {
        try {
            const response = await axios.post('/quiz', { "act": "getQuizItem", "quiz_id": quiz_id });
            const questions = response.data;
            return questions['quiz_item'][questions['quiz_item'].length - 1]['item_id']; // 返回问题数量
        } catch (error) {
            console.error('Failed to fetch questions count:', error);
            return 0; // 如果请求失败，返回 0 问题
        }
    }

    async function displaySurveys(data) {
        const newFormsContainer = document.querySelector('#newForms.list-group');
        const pastFormsContainer = document.querySelector('#pastForms.list-group');

        // 清空旧的列表项
        newFormsContainer.innerHTML = '';
        pastFormsContainer.innerHTML = '';

        if (data.length === 0) {
            displayEmptyMessage(newFormsContainer);
            displayEmptyMessage(pastFormsContainer);
            return;
        }

        // 获取所有问卷的问题数量
        const surveysWithQuestionCountPromises = data.map(async (survey) => {
            const createTime = new Date(survey.create_time);
            const daysDifference = Math.floor((new Date() - createTime) / (1000 * 60 * 60 * 24));
            const questionCount = await fetchQuestionsCount(survey.quiz_id); // 获取问题数量
            return { survey, daysDifference, questionCount };
        });

        const surveysWithQuestionCount = await Promise.all(surveysWithQuestionCountPromises);

        surveysWithQuestionCount.forEach(({ survey, daysDifference, questionCount }) => {
            // 创建 list group item
            const listItem = document.createElement('a');
            listItem.classList.add('list-group-item', 'list-group-item-action');
            listItem.href = `/quiz_item.jsp?quiz_id=` + survey.quiz_id; // 设置跳转链接

            const flexContainer = document.createElement('div');
            flexContainer.classList.add('d-flex', 'w-100', 'justify-content-between');

            const title = document.createElement('h5');
            title.classList.add('mb-1');
            title.textContent = survey.quiz_name;

            const small = document.createElement('small');
            small.classList.add('text-body-secondary');
            small.textContent = daysDifference + ` days ago`;

            flexContainer.appendChild(title);
            flexContainer.appendChild(small);

            const smallPrint = document.createElement('small');
            smallPrint.textContent = questionCount+` questions`; // 使用动态获取的数量

            listItem.appendChild(flexContainer);
            listItem.appendChild(smallPrint);

            // 根据创建时间分类放入不同的列表
            if (daysDifference <= 20) {
                newFormsContainer.appendChild(listItem);
            } else {
                pastFormsContainer.appendChild(listItem);
            }
        });
    }


    // 显示空状态的提示
    function displayEmptyMessage(container) {
        container.innerHTML = '<p class="text-center text-muted">Nothing Here</p>';
    }

    // 处理请求错误
    function displayError() {
        document.querySelectorAll('.initial-message').forEach(function (element) {
            element.textContent = 'Failed to load data.';
        });
    }



</script>
