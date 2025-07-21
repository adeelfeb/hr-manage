// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"
// import Rails from "@rails/ujs"
// Rails.start()


// import "@rails/ujs"
// Rails.start()

document.addEventListener("DOMContentLoaded", () => {
    const notice = document.getElementById("flash-notice");
    if (notice) {
      setTimeout(() => {
        notice.classList.remove("show");
        notice.classList.add("hide");
        setTimeout(() => notice.remove(), 500); // Remove after transition
      }, 3000); // Hide after 3 seconds
    }
  });