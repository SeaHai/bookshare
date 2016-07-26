define([
    'app',
    'directives/pagination/pagination.html'
], Ready(function(app, template) {
    app.directive('pagination', [
      function() {
        return {
            replace: true,
            template: template,
            scope:{
                method:'=method'
            },
            transclude: true,
            link: function(scope, ele, attrs) {
                scope.currentPage = 1; //当前页数
                scope.count = 0; //总条数
                scope.pageSize = attrs.size; //分页大小
                scope.totalPage = 1; //总页数
                scope.pages = []; //分页数组
                if (!scope.method) {
                    throw new Error('load method is undefined');
                }
                scope.next = function() {
                    if (scope.currentPage < scope.totalPage) {
                        scope.currentPage++;
                        scope.getData();
                    }
                };
                scope.prev = function() {
                    if (scope.currentPage > 1) {
                        scope.currentPage--;
                        scope.getData();
                    }
                };
                //调用
                scope.getData = function(page) {
                    page && (scope.currentPage = page);
                    scope.method(scope.currentPage, scope.pageSize, function(data) {
                        scope.totalPage = Math.ceil(data.count / scope.pageSize);
                        if (scope.currentPage > 1 && scope.currentPage < scope.totalPage) {
                            scope.pages = [
                                scope.currentPage - 1,
                                scope.currentPage,
                                scope.currentPage + 1
                            ];
                        } else if (scope.currentPage == 1 && scope.totalPage > 1) {
                            scope.pages = [
                                scope.currentPage,
                                scope.currentPage + 1
                            ];
                        } else if (scope.currentPage == scope.totalPage && scope.totalPage > 1) {
                            scope.pages = [
                                scope.currentPage - 1,
                                scope.currentPage
                            ];
                        }
                        // scope.lists = data.info;
                    });
                };
                scope.getData();
            }
        }
      }
  ]);
}));
