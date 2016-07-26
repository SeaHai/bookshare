define([
  'app',
  'runtimes/services/Globals',
  'runtimes/services/EventBus',
  'runtimes/services/HttpInterceptor',
  'runtimes/directives/wtitle',
  'styles/rootCtrl.css'
], Ready(function(app) {
  app.controller('rootCtrl', [
    '$scope',
    '$state',
    '$window',
    'protocol',
    '$http',
    'domain',
    function($scope, $state, $window, protocol,$http,domain) {

      $scope.animate = 'fadeIn fadeOut';

      $scope.fromInternal = function() {
        return $state.previous && /^book\..*$/.test($state.previous.name);
      };

      $scope.lastStateIs = function(stateName) {
        return $state.previous && $state.previous.name === stateName;
      };

      $scope.goBack = function() {
        if ($scope.fromInternal()) {
          $window.history.back();
        } else {
          $state.go('book.home');
        }
      };

      $http.get(domain+'/user/isLogin')
        .success(function(res){
          if(res.status==1){
            $scope.user=res.result;
          }
        })
        .error(function(){
          
        })
      $scope.goUserDetail = function(){
        if($scope.user){
          $state.go('book.userDetail');
        }else{
          $state.go('book.login');
        }
      };
      $scope.$on('userData',function(evt,data){
        $scope.user=data;
      })

      
    }
  ]);
}));
