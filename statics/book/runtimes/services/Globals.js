define([
  'app'
], Ready(function(app){
  app.constant('batch', 20);  //条数
  app.constant('domain', ''); //域名
  app.constant('prefix', 'bs_'); //数据库前缀

  var protocol = '';

  if(!/^https?:/.test('@@staticsUrl')){
    protocol = window.location.protocol;
  }
  app.constant('protocol', protocol);

}));
