document.addEventListener("DOMContentLoaded", () => {
  const toggle = document.getElementById("notificationToggle");
  const dropdown = document.getElementById("notificationDropdown");

  if (!toggle || !dropdown) return;

  toggle.addEventListener("click", (e) => {
    e.stopPropagation(); // 外クリック扱いにしない
    dropdown.classList.toggle("is-open");
  });

  // 外クリックで閉じる
  document.addEventListener("click", (e) => {
    if (!toggle.contains(e.target) && !dropdown.contains(e.target)) {
      dropdown.classList.remove("is-open");
    }
  });
});