<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Coding By CodingNepal - youtube.com/@codingnepal -->
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vedha-2024</title>
   <link rel="stylesheet" href="d.css">
  <!-- Linking Google fonts for icons -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0">
</head>
<style>
@charset "UTF-8";
  @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}

body {
  min-height: 100vh;
  background:  #e8f5e9;
}

.sidebar {
  position: fixed;
  width: 270px;
  margin: 16px;
  border-radius: 16px;
  background: #29b313;
  height: calc(100vh-32px);
  transition: all 0.4s ease;
}

.sidebar.collapsed {
  width: 85px;
  height:750px ;
}

.sidebar .sidebar-header {
  display: flex;
  position: relative;
  padding: 25px 20px;
  align-items: center;
  justify-content: space-between;
}

.sidebar-header .toggler {
  height: 35px;
  width: 35px;
  color: #29b313;
  border: none;
  cursor: pointer;
  display: flex;
  background: #fff;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  transition: 0.4s ease;
}

.sidebar-header .sidebar-toggler {
  position: absolute;
  right: 20px;
}

.sidebar-header .menu-toggler {
  display: none;
}
.nav-item.dropdown .dropdown-menu {
  display: none;
  list-style: none;
  margin: 0;
  padding: 0;
  padding-left: 20px;
  transition: all 0.3s ease;
}

.nav-item.dropdown.open .dropdown-menu {
  display: block;
}

.nav-item.dropdown .dropdown-menu li a {
  text-decoration: none;
  color: white;
  display: block;
  padding: 8px 0;
  font-size: 0.9rem;
}

.nav-item.dropdown .dropdown-menu li a:hover {
  color: #000000;
}

/* Rotate the dropdown icon when the menu is open */
.nav-item.dropdown.open .dropdown-icon {
  transform: rotate(180deg);
  transition: transform 0.3s ease;
}

.sidebar.collapsed .sidebar-header .toggler {
  transform: translate(-4px, 15px);
}

.sidebar-header .toggler:hover {
  background: #dde4fb;
}

.sidebar-header .toggler span {
  font-size: 1.75rem;
  transition: 0.4s ease;
}

.sidebar.collapsed .sidebar-header .toggler span {
  transform: rotate(180deg);
}

.sidebar-nav .nav-list {
  list-style: none;
  display: flex;
  gap: 4px;
  padding: 0 15px;
  flex-direction: column;
  transform: translateY(15px);
  transition: 0.4s ease;
}

.sidebar.collapsed .sidebar-nav .primary-nav {
  transform: translateY(65px);
}

.sidebar-nav .nav-link {
  color: #fff;
  display: flex;
  gap: 12px;
  white-space: nowrap;
  border-radius: 8px;
  padding: 12px 15px;
  align-items: center;
  text-decoration: none;
  transition: 0.4s ease;
}

.sidebar.collapsed .sidebar-nav .nav-link {
  border-radius: 12px;
}

.sidebar .sidebar-nav .nav-link .nav-label {
  transition: opacity 0.3s ease;
}

.sidebar.collapsed .sidebar-nav .nav-link .nav-label {
  opacity: 0;
  pointer-events: none;
}

.sidebar-nav .nav-link:hover {
  color: #29b313;
  background: #fff;
}

.sidebar-nav .nav-item {
  position: relative;
  bottom:35px;
}

.sidebar-nav .nav-tooltip {
  position: absolute;
  top: -10px;
  opacity: 0;
  color: #29b313;
  display: none;
  pointer-events: none;
  padding: 6px 12px;
  border-radius: 8px;
  white-space: nowrap;
  background: #fff;
  left: calc(100% + 25px);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  transition: 0s;
}
.sidebar.collapsed .sidebar-nav .nav-tooltip {
  display: block;
}
.sidebar-nav .nav-item:hover .nav-tooltip {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(50%);
  transition: all 0.4s ease;
}
.sidebar-nav .secondary-nav {
  position: absolute;
  bottom: 30px;
  width: 100%;
}
/* Responsive media query code for small screens */
@media (max-width: 1024px) {
  .sidebar {
    position: static;
    position: fixed;
  top: 0; /* Align to the very top */
  left: 0; /* Align to the left edge */
    height: 70px;
    margin: 10px;
    overflow-y: hidden;
    scrollbar-width: none;
    width: calc(100% - 26px);
    max-height: calc(100vh - 26px);
  }
  .sidebar.menu-active {
    overflow-y: auto;
  }
  .sidebar-nav .nav-item {
  position: relative;
  top:15px;
}
  .sidebar .sidebar-header {
    position: sticky;
    top: 0;
    z-index: 20;
    border-radius: 16px;
    background: #29b313;
    padding: 8px 10px;
  }
  .sidebar-header .sidebar-toggler,
  .sidebar-nav .nav-item:hover .nav-tooltip {
    display: none;
  }
  .sidebar-header .menu-toggler {
    display: flex;
    height: 30px;
    width: 30px;
  }
  .sidebar-header .menu-toggler span {
    font-size: 1.3rem;
  }
  .sidebar .sidebar-nav .nav-list {
    padding: 0 10px;
  }
  .sidebar-nav .nav-link {
    gap: 10px;
    padding: 10px;
    font-size: 0.94rem;
  }
  .sidebar-nav .nav-link .nav-icon {
    font-size: 1.37rem;
  } 
}
/* Calender*/
.dashboard {
  display: flex;
}
.welcome-message {
  margin-left: 0; /* Align with the sidebar */
  padding: 20px;
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  text-align: center;
}
.welcome-message h1 {
  font-size: 24px;
  color: #29b313;
  margin-bottom: 10px;
}

.welcome-message p {
  font-size: 16px;
  color: #555;
}
@media (max-width: 1024px) {
  .welcome-message {
    margin-left: 0; /* Remove margin to align properly */
    margin-top: 90px; /* Add spacing below the sidebar */
  }
}
/* middle*/
.main-content {
  margin-left: 300px; /* Leave space for the fixed sidebar */
  display: flex;
  flex: 1;
  padding: 20px;
  gap: 20px; /* Space between sections */
  flex-wrap: wrap;
  justify-content: flex-end; /* Align items to the left */
  align-items: flex-start; /* Align items to the top */
}

.video-recommendations {
  flex: 2; /* Takes more space */
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  display: none;
}
.video-recommendations.active {
    display: block; /* Show dynamically when content is available */
  }
.calendar {
  width: 350px;
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 20px;
}
.content {
  margin-left: 270px; /* Leave space for the sidebar */
  padding: 20px;
  display: flex;
  justify-content: flex-end; /* Align items to the right */
  align-items: flex-start; /* Optional: aligns items vertically */
}
.calendar-header {
  text-align: center;
  font-weight: 600;
  margin-bottom: 20px;
  font-size: 18px;
}

.calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 8px;
}

.day {
  font-weight: bold;
  text-align: center;
  color: #29b313;
}

.date {
  text-align: center;
  padding: 8px;
  background: #f1f1f1;
  border-radius: 4px;
}
t
.date:hover {
  background: #29b313;
  color: #fff;
  cursor: pointer;
}
@media (max-width: 768px) {
  .main-content {
      margin-left: 0; /* No need for extra margin on smaller screens */
      padding: 10px;
      flex-direction: column; /* Stack sections vertically */
    }
    .video-recommendations {
      width: 100%; /* Full width */
    }
    .calendar {
      width: 70%; /* Full width */
      margin-top: 100px; /* Add spacing below video recommendations */
      display: block;
      margin-left: 80px;
    }
    }
    /* Initially, hide the dropdown */
.sidebar-nav .nav-item .sub-menu {
  display: none;
  list-style: none;
  padding-left: 20px;
  margin-top: 5px;
  transition: all 0.3s ease-in-out;
}

.sidebar-nav .nav-item .sub-menu li {
  padding: 8px 0;
}

.sidebar-nav .nav-item .sub-menu li a {
  color: #fff;
  font-size: 14px;
  text-decoration: none;
  display: block;
  padding: 6px 15px;
}

.sidebar-nav .nav-item .sub-menu li a:hover {
  background-color: #29b313;
  color: #fff;
}

/* Arrow icon - the downward chevron */
.sidebar-nav .nav-item i.arrow {
  position: absolute;
  right: 20px;
  top: 15px;
  font-size: 20px;
  color: #fff;
  cursor: pointer;
  transition: transform 0.3s ease;
}

/* When dropdown is shown */
.sidebar-nav .nav-item.active .sub-menu {
  display: block; /* Show the sub-menu when the parent is active */
}

.sidebar-nav .nav-item.active i.arrow {
  transform: rotate(180deg); /* Rotate the arrow when the menu is open */
}

.sidebar-nav .nav-item.active .nav-link {
  background: #1e7b10; /* Highlight the parent link when active */
  color: #fff;
}
    
</style>
<body>
  <aside class="sidebar">
    <!-- Sidebar header -->
    <header class="sidebar-header">
      <button class="toggler sidebar-toggler">
        <span class="material-symbols-rounded">chevron_left</span>
      </button>
      <button class="toggler menu-toggler">
        <span class="material-symbols-rounded">menu</span>
      </button>
    </header>

    <nav class="sidebar-nav">
      <!-- Primary top nav -->
      <ul class="nav-list primary-nav">
        <li class="nav-item">
          <a href="#" class="nav-link">
            <span class="nav-icon material-symbols-rounded">dashboard</span>
            <span class="nav-label">Dashboard</span>
          </a>
          <span class="nav-tooltip">Dashboard</span>
        </li>
        <li class="nav-item dropdown">
  <a href="#" class="nav-link dropdown-toggle">
    <span class="material-symbols-rounded">calendar_today</span>
    <span class="nav-label">Learning Path</span>
    <!-- Add the dropdown icon -->
    <span class="material-symbols-rounded dropdown-icon">expand_more</span>
  </a>
  <span class="nav-tooltip">Learning Path</span>
  <ul class="dropdown-menu" name="mode" action="/VVCE_HACKATHON/CoursesByMode" method="get">
    <li><a href="/VVCE_HACKATHON/CoursesByMode?mode=Video">Video Based</a></li>
<li><a href="Cheatsheet.html">Cheat Sheet</a></li>
<li><a href="HandsOn.html">Hands-On</a></li>
   <li><a href="Article.html">Reading Documents</a></li>
  </ul>
</li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <span class="material-symbols-rounded">notifications</span>
              <span class="nav-label">Resource Library</span>
            </a>
            <span class="nav-tooltip">Resource Library</span>
          </li>
          <li class="nav-item">
            <a href="Feedback.html" class="nav-link">
              <span class="material-symbols-rounded">group</span>
              <span class="nav-label">Feedback</span>
            </a>
            <span class="nav-tooltip">Feedback</span>
          </li>
          <li class="nav-item">
            <a href="Quiz.jsp" class="nav-link">
              <span class="material-symbols-rounded">insert_chart</span>
              <span class="nav-label">Practice Quiz</span>
            </a>
            <span class="nav-tooltip">Practice Quiz</span>
          </li>
          <li class="nav-item">
              <a href="MyPreferences.html" class="nav-link">
                <span class="material-symbols-rounded">tune</span>
                <span class="nav-label">My Preferences</span>
              </a>
              <span class="nav-tooltip">My Preferences</span>
            </li>
            <li class="nav-item">
              <a href="Gamefication.html" class="nav-link">
                <span class="material-symbols-rounded">sports_esports</span>
                <span class="nav-label">Game Zone</span>
              </a>
              <span class="nav-tooltip">Game Zone</span>
            </li>
          <li class="nav-item">
              <a href="ProjectCollaboration.html" class="nav-link">
                <span class="material-symbols-rounded">groups</span>
                <span class="nav-label">Project Collaboration</span>
              </a>
              <span class="nav-tooltip">Project Collaboration</span>
            </li>
          <li class="nav-item">
            <a href="DashboardProfilesettings.html" class="nav-link">
              <span class="material-symbols-rounded">settings</span>
              <span class="nav-label">Profile Settings</span>
            </a>
            <span class="nav-tooltip">Profile Settings</span>
          </li>
      </ul>
    </nav>
  </aside>
  <div class="welcome-message">
    <h1>Welcome to Your Dashboard!</h1>
    <p>Your personalized space to track progress, access resources, and stay updated.</p>
  </div>
  
  <div class="main-content">
    <div class="video-recommendations">
      <h2>Recommended Videos</h2>
      <p>Video content goes here...</p>
    </div>
    <div class="calendar">
      <div class="calendar-header">November 2024</div>
      <div class="calendar-grid">
        <!-- Days of the week -->
        <div class="day">Sun</div>
        <div class="day">Mon</div>
        <div class="day">Tue</div>
        <div class="day">Wed</div>
        <div class="day">Thu</div>
        <div class="day">Fri</div>
        <div class="day">Sat</div>
        
        <!-- Dates (1-31) -->
        <div class="date"></div> <!-- Blank cells for offset -->
        <div class="date">1</div>
        <div class="date">2</div>
        <div class="date">3</div>
        <div class="date">4</div>
        <div class="date">5</div>
        <div class="date">6</div>
        <div class="date">7</div>
        <div class="date">8</div>
        <div class="date">9</div>
        <div class="date">10</div>
        <div class="date">11</div>
        <div class="date">12</div>
        <div class="date">13</div>
        <div class="date">14</div>
        <div class="date">15</div>
        <div class="date">16</div>
        <div class="date">17</div>
        <div class="date">18</div>
        <div class="date">19</div>
        <div class="date">20</div>
        <div class="date">21</div>
        <div class="date">22</div>
        <div class="date">23</div>
        <div class="date">24</div>
        <div class="date">25</div>
        <div class="date">26</div>
        <div class="date">27</div>
        <div class="date">28</div>
        <div class="date">29</div>
        <div class="date">30</div>
      </div>
    </div>
  </div>  
<script src="sidebar.js"></script>
</body>
</html>