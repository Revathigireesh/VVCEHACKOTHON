<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Your Project</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #E8F5E9;
        }
        header {
            background-color: #29b313;
            color: #ecf0f1;
            padding: 1rem;
            text-align: center;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }
        body {
            padding-top: 70px;
        }
        .container {
            width: 60%;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 10px;
            position: relative;
            top: 60px;
            left: 50%;
            transform: translateX(-50%);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px;
        }
        .input-box {
            border-style: none;
            width: 90%;
            max-width: 500px; /* Optional: Prevents input from being too wide */
            background-color: #E8F5E9;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-sizing: border-box;
            font-size: 16px;
            box-shadow: 4px 4px 6px rgba(0, 0, 0, 0.2);
        }
        textarea.input-box {
            resize: none;
            height: 100px;
        }
        .button {
            background-color: #29b313;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            margin: 20px auto;
        }
        .button:hover {
            background-color: #248f11;
        }
        .input-box:focus {
    outline: none;
    border: 1px solid #ccc; /* Keeps the border visible without the black focus border */
}

        @media (max-width: 768px) {
            .container {
                width: 60%;
            }
            .input-box {
                width: 100%;
                font-size: 14px;
            }
            .button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
        @media (max-width: 480px) {
            header {
                font-size: 18px;
                padding: 0.5rem;
            }
            .container {
                top: 20px;
                padding: 15px;
            }
            .input-box {
                font-size: 12px;
            }
            .button {
                font-size: 12px;
                padding: 6px 12px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Upload Your Project</h1>
    </header>
    <div class="container">
    <form action="ProjectUpload" method="post">
        <input type="text" class="input-box" name="projectName" placeholder="Project Name" required>
        <textarea class="input-box" name="projectDescription" placeholder="Project Description" required></textarea>
        <textarea class="input-box" name="technologiesUsed" placeholder="Technologies Used (comma-separated)"></textarea>
        <input type="text" class="input-box" name="accessLink" placeholder="Project Access Link (URL)">
        <button class="button" type="submit">Upload</button>
        </form>
    </div>
</body>
</html>
