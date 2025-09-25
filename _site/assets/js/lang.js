document.addEventListener('DOMContentLoaded', () => {
  const STORAGE_KEY = 'preferredLanguage';
  const HTML_LANG = document.documentElement.getAttribute('lang');
  const FALLBACK_LANG = 'ko';
  const containers = Array.from(document.querySelectorAll('[data-lang-toggle-container]'));
  const switchers = Array.from(document.querySelectorAll('[data-lang-switcher]'));
  const toggles = Array.from(document.querySelectorAll('[data-lang-toggle]'));
  const allBlocks = Array.from(document.querySelectorAll('.lang-content[data-lang]'));

  const languageLabels = {
    ko: { switchTo: '한국어로 보기', name: '한국어' },
    en: { switchTo: 'View in English', name: 'English' },
  };

  if (!allBlocks.length) {
    switchers.forEach((btn) => {
      btn.disabled = true;
      btn.classList.add('language-toggle__btn--disabled');
      btn.textContent = 'Language';
    });
    return;
  }

  const languages = Array.from(new Set(allBlocks.map((node) => node.dataset.lang).filter(Boolean)));
  const isToggleable = languages.length >= 2;

  const groups = allBlocks.reduce((acc, block) => {
    const group = block.dataset.langGroup || 'default';
    if (!acc.has(group)) {
      acc.set(group, []);
    }
    acc.get(group).push(block);
    return acc;
  }, new Map());

  const storedLang = localStorage.getItem(STORAGE_KEY);
  let preferredLang = languages.includes(HTML_LANG) ? HTML_LANG : null;
  if (!preferredLang && languages.includes(FALLBACK_LANG)) {
    preferredLang = FALLBACK_LANG;
  }

  const initialLang = storedLang && languages.includes(storedLang) ? storedLang : (preferredLang || languages[0]);
  let currentLang = initialLang;

  const getNextLanguage = (lang) => {
    if (!isToggleable) {
      return lang;
    }
    const index = languages.indexOf(lang);
    if (index === -1) {
      return languages[0];
    }
    return languages[(index + 1) % languages.length];
  };

  const updateSwitchers = (lang) => {
    const nextLang = getNextLanguage(lang);
    switchers.forEach((btn) => {
      if (!isToggleable) {
        const label = (languageLabels[lang] && languageLabels[lang].name) || lang.toUpperCase();
        btn.disabled = true;
        btn.classList.add('language-toggle__btn--disabled');
        btn.textContent = label;
        btn.dataset.langSwitchTo = '';
        btn.setAttribute('aria-label', label);
        return;
      }

      const label = (languageLabels[nextLang] && languageLabels[nextLang].switchTo) || `Switch to ${nextLang.toUpperCase()}`;
      btn.disabled = false;
      btn.classList.remove('language-toggle__btn--disabled');
      btn.textContent = label;
      btn.dataset.langSwitchTo = nextLang;
      btn.setAttribute('aria-label', label);
    });
  };

  const setActiveLang = (lang) => {
    currentLang = lang;

    if (isToggleable) {
      groups.forEach((blocks) => {
        blocks.forEach((block) => {
          block.style.display = block.dataset.lang === lang ? '' : 'none';
        });
      });
    } else {
      allBlocks.forEach((block) => {
        block.style.display = '';
      });
    }

    toggles.forEach((toggle) => {
      const isActive = toggle.dataset.langToggle === lang;
      toggle.classList.toggle('language-toggle__btn--active', isActive);
      toggle.setAttribute('aria-pressed', isActive ? 'true' : 'false');
    });

    document.documentElement.setAttribute('data-lang-current', lang);
    localStorage.setItem(STORAGE_KEY, lang);
    updateSwitchers(lang);
  };

  containers.forEach((container) => {
    if (!isToggleable && container.dataset.langToggleContainer !== 'always') {
      container.setAttribute('hidden', 'hidden');
    } else {
      container.removeAttribute('hidden');
    }
  });

  switchers.forEach((btn) => {
    btn.addEventListener('click', () => {
      if (btn.disabled) {
        return;
      }
      const nextLang = btn.dataset.langSwitchTo;
      if (nextLang && nextLang !== currentLang) {
        setActiveLang(nextLang);
      } else if (isToggleable) {
        setActiveLang(getNextLanguage(currentLang));
      }
    });
  });

  setActiveLang(initialLang);
});
