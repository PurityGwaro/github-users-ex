const Theme = {
  init() {
    const savedTheme = localStorage.getItem("app-theme");
    if (savedTheme) {
      this.applyTheme(savedTheme);
    }

    window.addEventListener("phx:update-theme", (e) => {
      const newTheme = e.detail.theme;
      this.applyTheme(newTheme);
    });
  },

  applyTheme(theme) {
    const htmlElement = document.documentElement;

    htmlElement.classList.remove("dark", "light");

    if (theme === "dark") {
      htmlElement.classList.add("dark");
    }

    localStorage.setItem("app-theme", theme);
  },
};

export default Theme;
