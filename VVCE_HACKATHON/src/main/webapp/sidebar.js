/**
 * 
 */
document.querySelectorAll('.dropdown-toggle').forEach((toggle) => {
  toggle.addEventListener('click', (e) => {
    e.preventDefault(); // Prevent the default link behavior
    const parentDropdown = toggle.closest('.nav-item.dropdown'); // Find the parent dropdown
    parentDropdown.classList.toggle('open'); // Toggle the 'open' class
  });
});
const sidebar = document.querySelector(".sidebar");
const sidebarToggler = document.querySelector(".sidebar-toggler");
const menuToggler = document.querySelector(".menu-toggler");

// Ensure these heights match the CSS sidebar height values
let collapsedSidebarHeight = "66px"; // Height in mobile view (collapsed)
let fullSidebarHeight = "calc(100vh - 32px)"; // Height in larger screen

// Toggle sidebar's collapsed state
sidebarToggler.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
});

// Update sidebar height and menu toggle text
const toggleMenu = (isMenuActive) => {
  sidebar.style.height = isMenuActive ? `${sidebar.scrollHeight}px` : collapsedSidebarHeight;
  menuToggler.querySelector("span").innerText = isMenuActive ? "close" : "menu";
}

// Toggle menu-active class and adjust height
menuToggler.addEventListener("click", () => {
  toggleMenu(sidebar.classList.toggle("menu-active"));
});

// (Optional code): Adjust sidebar height on window resize
window.addEventListener("resize", () => {
  if (window.innerWidth >= 1024) {
    sidebar.style.height = fullSidebarHeight;
  } else {
    sidebar.classList.remove("collapsed");
    sidebar.style.height = "auto";
    toggleMenu(sidebar.classList.contains("menu-active"));
  }
});



    const calendarGrid = document.querySelector(".calendar-grid");
  
    // Function to update the calendar dynamically
    const updateCalendar = (datesWithEvents) => {
      // Clear the current calendar grid (excluding days of the week)
      const daysOfWeek = Array.from(calendarGrid.children).slice(0, 7);
      calendarGrid.innerHTML = "";
      calendarGrid.append(...daysOfWeek); // Re-add days of the week headers
  
      // Add empty cells for alignment (for the first row)
      const offset = new Date(2024, 10, 1).getDay(); // Day of the week for Nov 1, 2024
      for (let i = 0; i < offset; i++) {
        calendarGrid.innerHTML += `<div class="date"></div>`;
      }
  
      // Add dates for November with dynamic events
      for (let date = 1; date <= 30; date++) {
        const hasEvent = datesWithEvents.includes(date);
        calendarGrid.innerHTML += `
          <div class="date ${hasEvent ? "event-date" : ""}" data-date="${date}">
            ${date}
          </div>
        `;
      }
    };
  
    // Highlight today's date (optional)
    const highlightToday = () => {
      const today = new Date();
      const month = today.getMonth(); // 0-based index
      const year = today.getFullYear();
      const date = today.getDate();
  
      // If today is in November 2024, highlight it
      if (month === 10 && year === 2024) {
        const todayElement = document.querySelector(`.date[data-date="${date}"]`);
        if (todayElement) {
          todayElement.style.background = "#29b313";
          todayElement.style.color = "#fff";
        }
      }
    };
  
    // Example usage: Add events for specific dates dynamically
    const datesWithEvents = [5, 10, 15, 20, 25]; // Dates with events
    updateCalendar(datesWithEvents);
    highlightToday();
  
    // Dynamically add more events after 3 seconds
    setTimeout(() => {
      datesWithEvents.push(18, 22); // Add more event dates
      updateCalendar(datesWithEvents); // Refresh calendar
      highlightToday();
    }, 3000);
