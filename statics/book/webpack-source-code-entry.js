require.config({
  baseUrl: '/statics/book',
  urlArgs: '?v=' + (+new Date())
});

require([
  'boot.js'
])
