const THEME_ATTR = 'data-theme';
const DEFAULT_THEME = 'light';

document.addEventListener('DOMContentLoaded', () => {
  document.documentElement.setAttribute(THEME_ATTR, DEFAULT_THEME);
  document.documentElement.classList.add('theme-static');
});
