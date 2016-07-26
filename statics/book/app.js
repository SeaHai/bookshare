define(function() {

  var app = angular.module('book', [
    'ui.router',
    'ngFileUpload'
  ]);

  app.config([
    '$controllerProvider',
    '$compileProvider',
    '$filterProvider',
    '$provide',
    function($controllerProvider, $compileProvider, $filterProvider, $provide) {
      app.controller = $controllerProvider.register;
      app.directive = $compileProvider.directive;
      app.filter = $filterProvider.register;
      app.factory = $provide.factory;
      app.service = $provide.service;
      app.provider = $provide.provider;
      app.value = $provide.value;
      app.constant = $provide.constant;
      app.decorator = $provide.decorator;
    }
  ]);

  app.config([
    '$stateProvider',
    '$urlRouterProvider',
    '$locationProvider',
    '$httpProvider',
    function($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) {

      $locationProvider.html5Mode(true);

      $httpProvider.interceptors.push('HttpInterceptor');

      $urlRouterProvider.otherwise('/book/');

      $stateProvider
        .state('book', {
          abstract: true,
          url: '/book',
          template: '<div ui-view></div>',
          controller: 'rootCtrl',
          resolve: {
            deps: Chunk(function(resolve) {
              require([
                'controllers/rootCtrl.js'
              ], resolve);
            })
          }
        })
        .state('book.home', {
          url: '/',
          templateProvider: Chunk(function(resolve) {
            require([
              'views/home.html',
              'styles/homeCtrl.css',
              'controllers/homeCtrl.js'
            ], resolve);
          }),
          controller: 'homeCtrl'
        })
        .state('book.homeWithPath', {
          url: '/index',
          templateProvider: Chunk(function(resolve) {
            require([
              'views/home.html',
              'styles/homeCtrl.css',
              'controllers/homeCtrl.js'
            ], resolve);
          }),
          controller: 'homeCtrl'
        })
        .state('book.register',{
          url:'/register',
          templateProvider:Chunk(function(resolve){
            require([
              'views/register.html',
              'styles/registerCtrl.css',
              'controllers/registerCtrl.js'
            ],resolve);
          }),
          controller:'registerCtrl'
        })
        .state('book.login',{
          url:'/login',
          templateProvider:Chunk(function(resolve){
            require([
              'views/login.html',
              'styles/loginCtrl.css',
              'controllers/loginCtrl.js'
            ],resolve);
          }),
          controller:'loginCtrl'
        })
        .state('book.userDetail',{
          url:'/userDetail',
          templateProvider:Chunk(function(resolve){
            require([
              'views/user.html',
              'styles/userCtrl.css',
              'controllers/userCtrl.js'
            ],resolve);
          }),
          controller:'userCtrl'
        })
        .state('book.bookDetail',{
          url:'/bookDetail/:bid',
          templateProvider:Chunk(function(resolve){
            require([
              'views/bookDetail.html',
              'styles/bookDetailCtrl.css',
              'controllers/bookDetailCtrl.js'
            ],resolve);
          }),
          controller:'bookDetailCtrl'
        })
        .state('book.noteDetail',{
          url:'/noteDetail/:nid',
          templateProvider:Chunk(function(resolve){
            require([
              'views/noteDetail.html',
              'styles/noteDetailCtrl.css',
              'controllers/noteDetailCtrl.js'
            ],resolve);
          }),
          controller:'noteDetailCtrl'
        })
        .state('book.upload',{
          url:'/upload',
          templateProvider:Chunk(function(resolve){
            require([
              'views/upload.html',
              'styles/uploadCtrl.css',
              'controllers/uploadCtrl.js'
            ],resolve);
          }),
          controller:'uploadCtrl'
        })
        .state('book.manage',{
          url:'/manage',
          templateProvider:Chunk(function(resolve){
            require([
              'views/manage.html',
              'styles/manageCtrl.css',
              'controllers/manageCtrl.js'
            ],resolve);
          }),
          controller:'manageCtrl'
        })
        
    }
  ])

  return app;

})
