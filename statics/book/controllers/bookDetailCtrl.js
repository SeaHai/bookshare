define([
  'app',
  'styles/bookDetailCtrl.css'
], Ready(function(app){
  app.controller('bookDetailCtrl', [
    '$scope',
    '$state',
    '$stateParams',
    '$http',
    'domain',
    function($scope,$state,$stateParams,$http,domain){
      // 读取书籍
      $http.post(domain+'/book/select',{bid:$stateParams.bid})
        .success(function(data){
          $scope.book=data;
        })
        .error(function(){

        })
      // 读取书籍评论
      $http.post(domain+'/bookComment/select',{bid:$stateParams.bid})
        .success(function(data){
          if(data){
            $scope.bookcomments=data;
            $scope.bookCommentLen=$scope.bookcomments.length;
          }
        })
        .error(function(){

        })
      
      // 添加评论
      $scope.commentContent=null;
      $scope.addComment=function(){
        delete $scope.successInfo;
        delete $scope.errorInfo;
        $http.post(domain+'/bookComment/register',{
            bid:$stateParams.bid,
            content:$scope.commentContent
          })
          .success(function(res){
            $scope.commentContent=null;
            $('#collapseExample').collapse('hide');
            if(res.status==1){
              Messenger().post({id: 'message', type: 'success', message: res.info});
              $http.post(domain+'/bookComment/select',{bid:$stateParams.bid})
                .success(function(data){
                  if(data){
                    $scope.bookcomments=data;
                    $scope.bookCommentLen=$scope.bookcomments.length;
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
