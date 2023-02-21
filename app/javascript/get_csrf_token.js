const getCsrfToken = () => {
  const metas = document.getElementsByTagName('meta');
  for (let meta of metas) {
      if (meta.getAttribute('name') === 'csrf-token') {
          return meta.getAttribute('content');
      }
  }
  return '';
}
