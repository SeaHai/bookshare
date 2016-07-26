define([
  'app',
  'styles/homeCtrl.css'
], Ready(function(app){
  app.controller('homeCtrl', [
    '$scope',
    '$state',
    '$http',
    'domain',
    function($scope,$state,$http,domain){

      // 读取书籍
      $http.post(domain+'/book/select')
        .success(function(data){
          $scope.books=data;
        })
        .error(function(){

        })
      // 读取笔记
      $http.post(domain+'/note/select')
        .success(function(data){
          $scope.notes=data;
        })
        .error(function(){

        })

      // 跳转到书籍详情页
      $scope.goBookDetail=function(book){
        $state.go('book.bookDetail', {
            bid: book.bid
          });
      }

      // 跳转到笔记详情页
      $scope.goNoteDetail=function(note){
        $state.go('book.noteDetail', {
            nid: note.nid
          });
      }
    }
  ])
}));
