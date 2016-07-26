define([
  'app',
  'styles/bookDetailCtrl.css'
], Ready(function(app){
  app.controller('noteDetailCtrl', [
    '$scope',
    '$state',
    '$stateParams',
    '$http',
    'domain',
    function($scope,$state,$stateParams,$http,domain){

      // 读取书籍
      $http.post(domain+'/note/select',{nid:$stateParams.nid})
        .success(function(data){
          $scope.note=data;
        })
        .error(function(){

        })
      // 读取书籍评论
      $http.post(domain+'/noteComment/select',{nid:$stateParams.nid})
        .success(function(data){
          if(data){
            $scope.notecomments=data;
            $scope.noteCommentLen=$scope.notecomments.length;
          }
        })
        .error(function(){

        })

      // 添加评论
      $scope.commentContent=null;
      $scope.addComment=function(){
        delete $scope.successInfo;
        delete $scope.errorInfo;
        $http.post(domain+'/noteComment/register',{
            nid:$stateParams.nid,
            content:$scope.commentContent
          })
          .success(function(res){
            $scope.commentContent=null;
            $('#collapseExample').collapse('hide');
            if(res.status==1){
              Messenger().post({id: 'message', type: 'success', message: res.info});
              $http.post(domain+'/noteComment/select',{nid:$stateParams.nid})
                .success(function(data){
                  if(data){
                    $scope.notecomments=data;
                    $scope.noteCommentLen=$scope.notecomments.length;
                  }
                })
                .error(function(){

                }) 
            }else{
              Messenger().post({id: 'message', type: 'danger', message: res.info});
            }

          })
          .error(function(){

          });

      }

      
    }
  ])
}));
