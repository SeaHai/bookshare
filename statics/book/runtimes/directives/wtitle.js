define([
  'app'
], Ready(function(app){
  app.directive('wtitle', [
    '$timeout',
    '$document',
    'protocol',
    function($timeout, $document, protocol){
      return {
        restrict: 'AC',
        link: function($scope, $element, $attrs){
          var watch = $scope.$watch(function(){
            return $element.text().replace(/(^\s*)|(\s*$)/g, '');
          }, function(title){
            // 空标题不显示
            if(/^\s*$/.test(title)){
              return;
            }
            $document[0].title = title;
            var $body = angular.element($document[0].body);
            var $iframe = angular.element('<iframe style="visibility:hidden;" src="' + protocol + require('images/iframe.png') + '"></iframe>');
            $iframe.on('load', function(){
              $timeout(function(){
                $iframe.off('load').remove();
                $scope.waitWtitle && $scope.waitWtitle();
              }, 5);
            });
            $body.append($iframe);
          });

          $scope.$on('$destroy', watch);
        }
      };
    }
  ]);
}));
