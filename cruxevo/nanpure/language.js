// App-specific document routes; never use another game's legal language map.
(() => {
  const params = new URLSearchParams(window.location.search);
  const requested = params.getAll('lang');
  if (!requested.length) return;
  const filename = window.location.pathname.split('/').pop();
  const kind = filename.startsWith('terms') ? 'terms' : 'privacy';
  const routes = {
    en: `${kind}.html#en`,
    ja: `${kind}.html#ja`,
    'zh-Hant': `${kind}.zh-Hant.html`,
    es: `${kind}.es.html`,
    de: `${kind}.de.html`,
    fr: `${kind}.fr.html`,
    'pt-BR': `${kind}.pt-BR.html`,
    ko: `${kind}.ko.html`,
  };
  const locale = requested.length === 1 && Object.hasOwn(routes, requested[0]) ? requested[0] : 'en';
  window.location.replace(routes[locale]);
})();
