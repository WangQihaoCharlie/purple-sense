<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<HTML>
<jsp:include page="includes.jsp"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy</title>
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
            font-family: Arial, sans-serif;
        }

        .btn-back {
            font-size: 16px;
            color: #007bff;
        }
        .btn-back i {
            margin-right: 8px;
        }
        .container {
            padding: 20px;
        }
        .privacy-text {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            line-height: 1.6;
        }
    </style>
</head>
<body>
<div class="container">
    <a class="btn btn-light btn-back" href="javascript:history.back();">
        <i class="fas fa-arrow-left"></i> Back
    </a>
</div>
<div class="container">
    <div class="privacy-text">
        Any personal information provided by the user to the application will be treated as confidential. Our group shall
        hold personal information in the strictest confidence and shall not disclose or use personal information, except
        under any regulatory or legal proceedings. In case such disclosure is required to be made by law or any regulatory
        authority, it will be made on a ‘need-to-know’ basis, unless otherwise instructed by the regulatory authority.

        <br><br>
        Our group understands that there are laws in the United States and other countries that protect personal information,
        and that we must not use personal information other than for the purposes for which it was originally used or make any
        disclosures of personal information to any third party or from one country to another without prior approval of an
        authorized representative of the Parent.
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var header = document.querySelector('.navbar');
        var container = document.querySelector('.container');
        var headerHeight = header.offsetHeight;

        container.style.marginTop = headerHeight + 'px';
    });
</script>
</body>
</html>

<script type="text/javascript">


</script>
