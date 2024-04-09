<!DOCTYPE html>
<html>
<head>
    <title>Hello Aniket!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-top: 50px;
        }
        p {
            color: #666;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Hello Aniket</h1>
    <p>
        It is now <%= new java.util.Date() %>
    </p>
    <p>
        You are coming from <%= request.getRemoteAddr() %>
    </p>
</body>
</html>
