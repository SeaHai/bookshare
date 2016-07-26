define([
  'app',
  'styles/registerCtrl.css'
], Ready(function(app){
  app.controller('registerCtrl', [
    '$scope',
    '$state',
    '$http',
    'domain',
    function($scope,$state,$http,domain){

      // 注册
      $scope.person={
        username:null,
        password:null
      }
      $scope.register=function(){
        $http.post(domain+'/user/register',$scope.person)
          .success(function(res){
            if(res.status==1){
              $scope.$emit('userData',res.result);
              $state.go('book.home');
              $http.post(domain+'/user/login',$scope.person)
                .success(function(res){
                  if(res.status==1){
                    $scope.$emit('userData', res.result);
                    $state.go('book.home'); //注册成功，跳转到首页
                  }else{
                    // 注册失败，显示错误信息
                    Messenger().post({id: 'message', type: 'danger', message: res.info});
                  }
              })
              .error(function(){
              
              })
            }else{
              // 输入信息不合法，显示错误信息
              Messenger().post({id: 'message', type: 'danger', message: res.info});
            }
          })
          .error(function(){

          })
      }

      // 退出
      $scope.logout=function(){
        $http.get(domain+'user/logout')
          .success(function(res){
            if(res.status==1){
              $state.reload();//刷新当前页面
            }
          })
          .error(function(){

          })
      }
    }
  ])
}));
