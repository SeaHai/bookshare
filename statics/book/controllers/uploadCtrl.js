define([
  'app',
  'styles/uploadCtrl.css'
], Ready(function(app) {
  app.controller('uploadCtrl', [
    '$scope',
    '$http',
    'domain',
    function($scope, $http, domain) {
      $scope.book = {
        name: null,
        intro: null,
        cate: null,
        url: null
      }
      $scope.saveBook = function() {
        $http.post(domain + '/book/register', $scope.book)
          .success(function(res) {
            Messenger().post({id: 'message', type: 'success', message: res.info});
            if (res.status == 1) {
              $scope.book = {};
            }
          })
          .error(function() {

          })

      }
      $scope.note = {
        name: null,
        intro:null,
        url: null
      }
      $scope.saveNote = function() {
        $http.post(domain + '/note/register', $scope.note)
          .success(function(res) {
            Messenger().post({id: 'message', type: 'success', message: res.info});
            if (res.status == 1) {
              $scope.note = {};
            }
          })
          .error(function() {

          })

      }

      $scope.reset = function() {
        $scope.book = {};
        $scope.note = {};
      }

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
    }
  ])
}));
