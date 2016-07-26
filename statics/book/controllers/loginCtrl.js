define([
  'app',
  'styles/loginCtrl.css'
], Ready(function(app){
  app.controller('loginCtrl', [
    '$scope',
    '$http',
    'domain',
    '$state',
    function($scope,$http,domain,$state){
      $scope.person={
        username:null,
        password:null
      }
      // 登录
      $scope.login=function(){
        $http.post(domain+'/user/login',$scope.person)
          .success(function(res){
            if(res.status==1){
              $scope.$emit('userData', res.result);
              if(res.result.uid==1){
                $state.go('book.manage');
              }else{
                $state.go('book.home');
              }
              
            }else{
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
