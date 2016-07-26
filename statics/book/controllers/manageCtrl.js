define([
  'app',
  'styles/manageCtrl.css',
  'directives/pagination/pagination.js'
], Ready(function(app){
  app.controller('manageCtrl', [
    '$scope',
    '$http',
    'domain',
    '$state',
    function($scope,$http,domain,$state){

      // 退出
      $scope.logout=function(){
        $http.get(domain+'user/logout')
          .success(function(res){
            if(res.status==1){
              $scope.$emit('userData', res.result);
              $state.go('book.login');
            }
          })
          .error(function(){

          })
      }
      /**
       * 用户管理
       */
      $scope.userSelect = function (page, size, callback) {
        $http.post(domain+'/user/select',{page:page,size:size})
          .success(function (res) {
            callback && callback(res.result);
            $scope.users=res.result.info;
        });
      };

      $scope.person={
        username:null,
        password:null
      }
      $scope.book = {
        name: null,
        intro: null,
        cate: null,
        url: null
      }
      $scope.note = {
        name: null,
        intro:null,
        url: null
      } 
      $scope.bookComment = {
        bid: null,
        uid:null,
        content: null
      }
      $scope.noteComment = {
        nid: null,
        uid:null,
        content: null
      }
      //新增
      $scope.add=function(type){
        var obj;
        var domId;
        switch(type){
          case 'user':
            {
              obj=$scope.person;
              domId='#userModal';
            };
            break;
          case 'book':
            {
              obj=$scope.book;
              domId='#bookModal';
            };
            break;
          case 'note':
            {
              obj=$scope.note;
              domId='#noteModal';
            };
            break;
          case 'bookComment':
            {
              obj=$scope.bookComment;
              domId='#bookCommentModal';
            };
            break;
          case 'noteComment':
            {
              obj=$scope.noteComment;
              domId='#noteCommentModal';
            };
            break;
        }
        // 注册
        $http.post(domain+'/'+type+'/register',obj)
          .success(function(res){
            if(res.status==1){
              Messenger().post({id: 'message', type: 'success', message: res.info});
              $(domId).modal('hide');
            }else{
              Messenger().post({id: 'message', type: 'danger', message: res.info});
            }
            
          })
       
      }
      // 更新
      $scope.update=function(type,obj){
        delete obj.$$hashKey;
        $http.post(domain+'/'+type+'/update',angular.toJson(obj))
          .success(function(res){
            if (res.status) {
                  //提示
                  Messenger().post({id: 'message', type: 'success', message: res.info});
                  $state.reload();
              } else {
                  Messenger().post({id: 'message', type: 'danger', message: res.info});
              };
          })
      }
      // 删除
      $scope.delete=function(type,obj){
        var data=null;
        switch(type){
          case 'user':
            {
              data={
                uid:obj.uid
              }
            };
            break;
          case 'book':
            {
              data={
                bid:obj.bid
              }
            };
            break;
          case 'note':
            {
              data={
                nid:obj.nid
              }
            };
            break;
          case 'bookComment':
            {
              data={
                id:obj.id
              }
            };
            break;
          case 'noteComment':
            {
              data={
                id:obj.id
              }
            };
            break;
        }
        $http.post(domain+'/'+type+'/delete',data)
          .success(function(res){
            if (res.status) {
                  //提示
                  Messenger().post({id: 'message', type: 'success', message: res.info});
                  $state.reload();
              } else {
                  Messenger().post({id: 'message', type: 'danger', message: res.info});
              };
          })
      }
      

      /**
       * 书籍管理
       */
      $scope.bookSelect = function (page, size, callback) {
        $http.post(domain+'/book/selectAll',{page:page,size:size})
          .success(function (res) {
            callback && callback(res.result);
            $scope.books=res.result.info;
        });
      };
     
      // 文件上传
      $scope.upload = function(name) {
        var formData = new FormData();
        if(name=='book'){
          formData.append("bookFile",$('input[name="bookFile"]')[0].files[0]);
        }else{
          formData.append("noteFile",$('input[name="noteFile"]')[0].files[0]);
        }
        formData.append("name",name);
        $.ajax({
          url: domain+'/service/upload',
          type: 'POST',
          data: formData,
          async: false,
          cache: false,
          contentType: false,
          processData: false,
          success: function(res) {
            if(res.status==1){
              if(name=='book'){
                $scope.book.url=res.info;
              }
              else{
                $scope.note.url=res.info;
              }
            }else{
              Messenger().post({id: 'message', type: 'danger', message: res.info});
            }
          },
          error: function() {
            
          }
        });
      }

      /**
       * 笔记管理
       */
      $scope.noteSelect = function (page, size, callback) {
        $http.post(domain+'/note/selectAll',{page:page,size:size})
          .success(function (res) {
            callback && callback(res.result);
            $scope.notes=res.result.info;
        });
      };

      /**
       * 书籍评论管理
       */
      $scope.bookCommentSelect = function (page, size, callback) {
        $http.post(domain+'/bookComment/selectAll',{page:page,size:size})
          .success(function (res) {
            callback && callback(res.result);
            $scope.bookComments=res.result.info;
        });
      };

      /**
       * 笔记评论管理
       */
      $scope.noteCommentSelect = function (page, size, callback) {
        $http.post(domain+'/noteComment/selectAll',{page:page,size:size})
          .success(function (res) {
            callback && callback(res.result);
            $scope.noteComments=res.result.info;
        });
      };

    }
  ])
}));
