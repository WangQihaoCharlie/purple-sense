<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<HTML>
<title>Sign In</title>
<jsp:include page="includes.jsp"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Survey</title>
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

        :root {
            --navbar-height: 80px; /* 设置导航栏的高度 */
        }

        .navbar {
            background-color: #f8f9fa;
            height: var(--navbar-height);
        }

        .home-container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            width: 150%;
            height: calc(100vh - var(--navbar-height));
            max-width: 550px;
            margin-top: var(--navbar-height); /* 使用 CSS 变量来设置 top margin */
        }
    </style>
</head>
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="btn btn-light btn-back" href="javascript:history.back();">
            <i class="fas fa-arrow-left"></i> Back
        </a>
    </div>
</nav>

<div class="home-container">
    <div class="progress mb-3" role="progressbar" aria-label="Example with label" aria-valuenow="25" aria-valuemin="0"
         aria-valuemax="100">
        <div class="progress-bar" style="width: 25%">0%</div>
    </div>
    <div class="row align-items-center">
        <div class="col-auto">
            <h2 class="form-title" style="font-weight: bold" id="question_description">Question 1</h2>
        </div>
        <div class="col"></div>
        <div class="col">
            <div class="btn-group d-flex align-items-center" role="group">
                <button type="button" class="btn btn-outline-primary btn-sm" id="prev_btn">&lt; Prev</button>
                <button type="button" class="btn btn-outline-primary btn-sm" id="next_btn">Next &gt;</button>
            </div>
        </div>
    </div>
    <hr>
    <div>
        <div id="answer_area">
        </div>
    </div>
    <div class="modal" id="successModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Your Result has been saved.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            onclick="window.location.href = '/quiz_main.jsp'">Close
                    </button>
                </div>
            </div>
        </div>
    </div>

</div>
</HTML>

<script type="text/javascript">
    let current_question = 1;
    let questions = {};
    let userAnswers = [];

    // 在 load_question() 函数中，更新页面上的问题和答题区域
    async function load_questions() {
        try {
            const url = new URL(window.location.href);
            const params = new URLSearchParams(url.search);
            const quiz_id = params.get('quiz_id');
            console.log(quiz_id);

            // 请求数据
            const response = await axios.post('/quiz', {"act": "getQuizItem", "quiz_id": quiz_id});
            questions = response.data;

            console.log(questions['quiz_item'][questions['quiz_item'].length - 1]['item_id']);

            // 初始化用户答案数组
            userAnswers = initializeUserAnswers(questions['quiz_item']);
            console.log(userAnswers)
            // 加载当前问题
            load_question();
        } catch (error) {
            console.error('请求失败', error);
        }
    }

    // 初始化用户答案数组
    function initializeUserAnswers(quizItems) {
        const userAnswers = [];

        quizItems.forEach(item => {
            if (item.item_row === 0) {
                // 处理 item_row 为 0 的问题
                userAnswers.push({
                    item_id: item.item_id,
                    answer: item.answer || '' // 如果有答案，则使用答案；否则为空字符串
                });
            } else {
                // 处理其他 item_row 的问题
                // 确保每个问题的 ID 出现在 userAnswers 中
                const existingAnswer = userAnswers.find(answer => answer.item_id === item.item_id);
                if (!existingAnswer) {
                    userAnswers.push({
                        item_id: item.item_id,
                        answer: '' // 默认答案为空
                    });
                }
            }
        });

        return userAnswers;
    }


    // 加载当前问题及答案区域
    function load_question() {
        // 清空答题区域
        $('#answer_area').empty();

        if (current_question === questions['quiz_item'][questions['quiz_item'].length - 1]['item_id'] + 1) {
            $('#question_description').text("Thanks for answering");

            const prevBtn = document.getElementById('prev_btn');
            const nextBtn = document.getElementById('next_btn');

            if (prevBtn && nextBtn) {
                const btnGroup = prevBtn.parentElement;

                if (btnGroup) {
                    btnGroup.removeChild(prevBtn);
                    btnGroup.removeChild(nextBtn);

                    const combinedBtn = document.createElement('button');
                    combinedBtn.type = 'button';
                    combinedBtn.className = 'btn btn-outline-primary btn-sm';
                    combinedBtn.innerHTML = 'Submit';
                    combinedBtn.onclick = submitQuiz;

                    btnGroup.appendChild(combinedBtn);
                }
            }
            return;
        }

        // 找到当前问题
        const currentItems = questions['quiz_item'].filter(item => item.item_id === current_question);
        const questionItem = currentItems.find(item => item.item_row === 0);

        // 更新问题标题
        $('#question_description').text("Question " + current_question + ": " + questionItem['item_content']);

        // 根据题型加载不同的表单元素
        const itemType = questionItem['item_type'];
        const current_answer = getUserAnswer(current_question);


        switch (itemType) {
            case 0: // 单选题
                currentItems.filter(item => item.item_row !== 0).forEach(item => {
                    $('#answer_area').append(
                        '<div class="form-check">' +
                        '<input class="form-check-input" type="radio" name="answer" id="answer_option' + item.item_row + '" value="' + item.item_row + '">' +
                        '<label class="form-check-label" for="answer_option' + item.item_row + '">' + item.item_content + '</label>' +
                        '</div>'
                    );
                });
                if (current_answer !== '') {
                    $(`input[name="answer"][value="`+ current_answer+`"]`).prop('checked', true);
                }
                break;
            case 1: // 多选题
                currentItems.filter(item => item.item_row !== 0).forEach(item => {
                    $('#answer_area').append(
                        '<div class="form-check">' +
                        '<input class="form-check-input" type="checkbox" id="answer_option' + item.item_row + '" value="' + item.item_row + '">' +
                        '<label class="form-check-label" for="answer_option' + item.item_row + '">' + item.item_content + '</label>' +
                        '</div>'
                    );
                });
                const selectedOptions = current_answer.split(','); // 多选答案用逗号分隔
                selectedOptions.forEach(option => {
                    $(`input[type="checkbox"][value="`+option+`"]`).prop('checked', true);
                });
                break;
            case 2: // 填空题
                $('#answer_area').append(
                    '<div class="form-floating mb-3">' +
                    '<textarea class="form-control" placeholder="Answer Area" id="answer_textarea" style="height: 100px"></textarea>' +
                    '<label for="answer_textarea"> Please Answer Here</label>' +
                    '</div>'
                );
                if (current_answer !== null) {
                    $('#answer_textarea').val(current_answer);
                }
                break;
            default:
                break;
        }

        // 调用函数来更新按钮状态
        button_handler();
    }

    // 处理按钮的启用和禁用状态
    function button_handler() {
        if (current_question === 1) {
            $('#prev_btn').prop('disabled', true);
        } else {
            $('#prev_btn').prop('disabled', false);
        }


        const progress = Math.ceil(current_question / questions['quiz_item'][questions['quiz_item'].length - 1]['item_id'] * 100);
        $('.progress-bar').css('width', progress + `%`).text(progress + `%`);
        console.log(current_question);
    }

    // 处理上一个问题
    function prevQuestion() {
        saveAnswer();
        if (current_question > 1) {
            current_question--;
            load_question(); // 加载当前问题
        }
    }

    // 处理下一个问题
    function nextQuestion() {
        saveAnswer();
        // 检查用户是否已经回答了当前题目
        const currentAnswer = getUserAnswer(current_question);
        if (currentAnswer === undefined || currentAnswer === '') {
            alert('Please answer the current question before proceeding.');
            return;
        }
        if (current_question < questions['quiz_item'][questions['quiz_item'].length - 1]['item_id'] + 1) {
            current_question++;
            load_question(); // 加载当前问题
        }
    }

    // 获取用户的答案
    function getUserAnswer(item_id) {
        const answerObj = userAnswers.find(ans => ans.item_id === item_id);
        return answerObj ? answerObj.answer : '';
    }


    // 保存当前问题的答案
    function saveAnswer() {
        const currentItems = questions['quiz_item'].filter(item => item.item_id === current_question);
        const itemType = currentItems[0]['item_type'];

        switch (itemType) {
            case 0: // 单选题
                const selectedOption = $('input[name="answer"]:checked').val();
                updateUserAnswer(current_question, selectedOption);
                break;
            case 1: // 多选题
                const selectedOptions = $('input[type="checkbox"]:checked').map(function () {
                    return this.value;
                }).get().join(',');
                updateUserAnswer(current_question, selectedOptions);
                break;
            case 2: // 填空题
                const textAnswer = $('#answer_textarea').val();
                updateUserAnswer(current_question, textAnswer);
                break;
            default:
                break;
        }
    }

    // 更新用户答案
    function updateUserAnswer(item_id, answer) {
        const answerIndex = userAnswers.findIndex(ans => ans.item_id === item_id);
        if (answerIndex !== -1) {
            userAnswers[answerIndex].answer = answer;
        }
    }

    // 提交问卷
    async function submitQuiz() {
        try {
            const url = new URL(window.location.href);
            const params = new URLSearchParams(url.search);
            const quiz_id = params.get('quiz_id');

            const payload = {
                act: "setQuizData",
                quiz_id: quiz_id,
                data: userAnswers
            };

            const response = await axios.post('/quiz', payload);
            console.log('提交成功', response);

            // 显示成功模态框
            $('#successModal').modal('show'); // 使用jQuery的方式显示模态框

        } catch (error) {
            console.error('提交失败', error);
        }
    }


    $(document).ready(function () {
        // 加载问题并初始化按钮状态
        load_questions();

        // 绑定按钮点击事件
        $('#prev_btn').click(prevQuestion);
        $('#next_btn').click(nextQuestion);
    });

</script>
