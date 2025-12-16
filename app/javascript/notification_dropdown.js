document.addEventListener("turbolinks:load", () => {
  const toggle = document.getElementById("notificationToggle");
  const dropdown = document.getElementById("notificationDropdown");

  if (!toggle || !dropdown) return;

  toggle.addEventListener("click", (e) => {
    e.stopPropagation();
    dropdown.classList.toggle("is-open");
  });

  document.addEventListener("click", (e) => {
    if (!toggle.contains(e.target) && !dropdown.contains(e.target)) {
      dropdown.classList.remove("is-open");
    }
  });
});