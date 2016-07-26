<?php

namespace Bookshare\Controller;
use Common\Api\UserApi;

/**
 * 用户模型
 * @author hai
 */
class UserController extends BookshareController {

  /**
   * 登录接口
   * @param  string  $username   用户名
   * @param  integer $password  密码, SHA1加密
   */
  public function login($username='',$password=''){
    $uid=D('User')->getUid($username);
    if(!$uid){
      $this->ajaxReturn(array('status'=>0, 'info'=>D('User')->showRegError(-3)));
    }elseif(D('User')->verifyUser($uid, $password)){
      if($info = D('User')->where(array('uid'=>$uid))->find()){
        /* 登录生成SESSION */
        D('User')->autoLogin($info);

        $result = array('status'=>1, 'info'=>'登录成功', 'result' =>D('User')->info($uid));
      }else{
        $result = array('status'=>0, 'info'=>'未登录成功');
      }
    }else{
      $this->ajaxReturn(array('status'=>0, 'info'=>D('User')->showRegError(-5)));
    }
    
    $this->ajaxReturn($result);
  }

  /**
   * 注册
   * @param  string $username 用户名
   * @param  string $password 密码
   * @return 用户信息
   */
  public function register($username='',$password=''){
    $uid=D('User')->getUid($username);
    if($uid){
      $result = array('status'=>0, 'info'=>'用户名已存在');
    }else{
      $status=D('User')->register($username,$password,$safety=1);
      if($status>0){
        $uid=D('User')->getUid($username);
        $result = array('status'=>1, 'info'=>'注册成功', 'result' =>D('User')->info($uid));
      }else{
        $code=D('User')->getError();
        $result=array('status'=>0, 'info'=>D('User')->showRegError($code));
      }
    }
    $this->ajaxReturn($result);
  }

  /**
   * 是否登录
   */
  public function islogin(){
    $auth = session('user_auth');
    if($auth){
      $User = D('User');
      $result = array('status'=>1, 'info'=>'登录成功', 'result'=>$User->info($auth['uid']));
    }else{
      $result = array('status'=>0, 'info'=>'未登录成功');
    }
    $this->ajaxReturn($result);
  }

  /**
   * 退出登录
   * @internal
   */
  public function logout(){
    if(is_login()){
      D('User')->logout();
    }
    session('[destroy]');
    cookie(null);
    $this->ajaxReturn(array('status' => 1, 'info' => '退出成功'));
  }
	
  public function select($page='1',$size){
    $count=D('User')->count();
    $firstRow=($page-1)*$size;
    $this->ajaxReturn(array('status' => 1, 'result' =>array('count'=>$count,'info'=>D('User')->limit($firstRow.','.$size)->select())));
  }

  public function delete($uid){
    $res=D('User')->where(array('uid'=>$uid))->delete();
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'删除成功'));
    }else{
      $this->ajaxReturn(array('status'=>0,'info'=>'删除失败'));
    }
  }

  public function update(){
    $json_string=file_get_contents("php://input");
    $data = json_decode($json_string, true);
    $res=D('User')->where(array('uid'=>$data['uid']))->save($data);
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'修改成功'));
    }else{
      $code=D('User')->getError();
      if(!$code){
        $this->ajaxReturn(array('status'=>0, 'info'=>'数据未发生改变'));
      }else{
        $this->ajaxReturn(array('status'=>0, 'info'=>D('User')->showRegError($code)));
      }
    }
  }
}
