define([
  'app',
  'styles/userCtrl.css'
], Ready(function(app){
  app.controller('userCtrl', [
    '$scope',
    '$state',
    '$http',
    'domain',
    function($scope,$state,$http,domain){
      $http.get(domain+'/user/isLogin')
        .success(function(res){
          if(res.status==1){
            var data=res.result;
          $http.post(domain+'/book/select',{uid:data.uid})
            .success(function(data){
              $scope.books=data;
            })
            .error(function(){

            })
          $http.post(domain+'/note/select',{uid:data.uid})
            .success(function(data){
              $scope.notes=data;
            })
            .error(function(){

            })
          $http.post(domain+'/bookComment/select',{uid:data.uid})
            .success(function(data){
              $scope.bookcomments=data;
            })
            .error(function(){

            })
          $http.post(domain+'/noteComment/select',{uid:data.uid})
            .success(function(data){
              $scope.notecomments=data;
            })
            .error(function(){

            })
            }
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
