<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Correct answers
    String[] correctAnswers = {"option1", "option1", "option1", "option2", "option1"};

    // Initialize score
    int score = 0;

    // Evaluate answers if form is submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Retrieve submitted answers
        String[] userAnswers = {
            request.getParameter("q1"),
            request.getParameter("q2"),
            request.getParameter("q3"),
            request.getParameter("q4"),
            request.getParameter("q5")
        };

        // Calculate score
        for (int i = 0; i < correctAnswers.length; i++) {
            if (correctAnswers[i].equals(userAnswers[i])) {
                score++;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quiz</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #00a83f;
      padding: 20px;
      margin: 0;
    }
    .container {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin: 0 auto;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    header h1 {
      color: #00a83f;
      font-size: 24px;
      text-align: center;
    }
    .question {
      margin-bottom: 20px;
    }
    .question label {
      font-size: 16px;
      font-weight: bold;
      display: block;
      margin-bottom: 10px;
    }
    .question div {
      margin-bottom: 10px;
      display: flex;
      align-items: center;
    }
    .question input[type="radio"] {
      margin-right: 10px;
    }
    button {
      display: block;
      width: 100%;
      background-color: #00a83f;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #007d2d;
    }
  </style>
</head>
<body>

  <div class="container">
    <header>
      <h1>Quiz</h1>
    </header>

    <form method="POST" >

      <!-- Question 1 -->
      <div class="question">
        <label>1. What does HTML stand for?</label>
        <div><input type="radio" id="html1" name="q1" value="option1" <%= request.getParameter("q1") != null && request.getParameter("q1").equals("option1") ? "checked" : "" %>> <label for="html1">HyperText Markup Language</label></div>
        <div><input type="radio" id="html2" name="q1" value="option2" <%= request.getParameter("q1") != null && request.getParameter("q1").equals("option2") ? "checked" : "" %>> <label for="html2">HighText Markup Language</label></div>
        <div><input type="radio" id="html3" name="q1" value="option3" <%= request.getParameter("q1") != null && request.getParameter("q1").equals("option3") ? "checked" : "" %>> <label for="html3">Hyperlink Markup Language</label></div>
      </div>

      <!-- Question 2 -->
      <div class="question">
        <label>2. Which of the following is the correct HTML element for inserting a line break?</label>
        <div><input type="radio" id="br1" name="q2" value="option1" <%= request.getParameter("q2") != null && request.getParameter("q2").equals("option1") ? "checked" : "" %>> <label for="br1">&lt;br&gt;</label></div>
        <div><input type="radio" id="br2" name="q2" value="option2" <%= request.getParameter("q2") != null && request.getParameter("q2").equals("option2") ? "checked" : "" %>> <label for="br2">&lt;br /&gt;</label></div>
        <div><input type="radio" id="br3" name="q2" value="option3" <%= request.getParameter("q2") != null && request.getParameter("q2").equals("option3") ? "checked" : "" %>> <label for="br3">&lt;break&gt;</label></div>
      </div>

      <!-- Question 3 -->
      <div class="question">
        <label>3. How do you create a hyperlink in HTML?</label>
        <div><input type="radio" id="link1" name="q3" value="option1" <%= request.getParameter("q3") != null && request.getParameter("q3").equals("option1") ? "checked" : "" %>> <label for="link1">&lt;a href="url"&gt;link&lt;/a&gt;</label></div>
        <div><input type="radio" id="link2" name="q3" value="option2" <%= request.getParameter("q3") != null && request.getParameter("q3").equals("option2") ? "checked" : "" %>> <label for="link2">&lt;link href="url"&gt;links&lt;/link&gt;</label></div>
        <div><input type="radio" id="link3" name="q3" value="option3" <%= request.getParameter("q3") != null && request.getParameter("q3").equals("option3") ? "checked" : "" %>> <label for="link3">&lt;hyperlink href="url"&gt;link&lt;/hyperlink&gt;</label></div>
      </div>

      <!-- Question 4 -->
      <div class="question">
        <label>4. Which tag is used to define a table in HTML?</label>
        <div><input type="radio" id="table1" name="q4" value="option1" <%= request.getParameter("q4") != null && request.getParameter("q4").equals("option1") ? "checked" : "" %>> <label for="table1">&lt;td&gt;</label></div>
        <div><input type="radio" id="table2" name="q4" value="option2" <%= request.getParameter("q4") != null && request.getParameter("q4").equals("option2") ? "checked" : "" %>> <label for="table2">&lt;table&gt;</label></div>
        <div><input type="radio" id="table3" name="q4" value="option3" <%= request.getParameter("q4") != null && request.getParameter("q4").equals("option3") ? "checked" : "" %>> <label for="table3">&lt;tr&gt;</label></div>
      </div>

      <!-- Question 5 -->
      <div class="question">
        <label>5. How do you add an image to an HTML page?</label>
        <div><input type="radio" id="img1" name="q5" value="option1" <%= request.getParameter("q5") != null && request.getParameter("q5").equals("option1") ? "checked" : "" %>> <label for="img1">&lt;img src="image.jpg"&gt;</label></div>
        <div><input type="radio" id="img2" name="q5" value="option2" <%= request.getParameter("q5") != null && request.getParameter("q5").equals("option2") ? "checked" : "" %>> <label for="img2">&lt;image src="image.jpg"&gt;</label></div>
        <div><input type="radio" id="img3" name="q5" value="option3" <%= request.getParameter("q5") != null && request.getParameter("q5").equals("option3") ? "checked" : "" %>> <label for="img3">&lt;pic src="image.jpg"&gt;</label></div>
      </div>

      <!-- Submit Button -->
      <button type="submit">Submit</button>
    </form>

  <div class="result">
    <% if (request.getMethod().equalsIgnoreCase("POST")) { %>
        <p>You scored: <%= score %> out of 5</p>
        <!-- Form to submit score -->
        <form method="POST" action="QuizScoreServlet">
            <input type="hidden" name="score" value="<%= score %>">
            <button type="submit">Save Score</button>
        </form>
    <% } %>
</div>
  
   
  </div>

</body>
</html>