<?php

namespace Bookshare\Api;
use Bookshare\Api\Api;
use Bookshare\Model\UserModel;


class UserApi extends Api{
	/**
	 * 构造方法，实例化操作模型
	 */
	protected function _init(){
		$this->model = new UserModel();
	}
	
	/**
	 * 注册一个新用户
	 * @param  string $username 用户名
	 * @param  string $password 用户密码
	 * @param  integer $safety  是否客户端加密
	 * @return integer          注册成功-用户信息，注册失败-错误编号
	 */
	public function register($username, $password){
		return $this->model->register($username, $password,$safety);
	}
	
	/**
	 * 用户登录认证
	 * @param  string  $user 用户信息
	 */
	public function autoLogin($user){
		return $this->model->autoLogin($user);
	}
	
	/**
   * 根据用户名获取uid
   * @param  [string] $username 用户名
   */
  public function getUid($username){
     return $this->model->getUid($username);
  }

	/**
	 * 获取用户信息
	 * @param  string  $uid         用户ID或用户名
	 * @return array                用户信息
	 */
	public function info($uid){
		return $this->model->info($uid);
	}
	
	/**
	 * 验证用户密码
	 * @param int $uid 用户id
	 * @param string $password_in 密码
	 * @return true 验证成功，false 验证失败
	 */
	protected function verifyUser($uid, $password_in){
		return $this->model->verifyUser($uid,$password_in);
	}

	/**
	 * 更新用户密码
	 * @param int $uid 用户id
	 * @param string $password 新密码
	 */
	public function updatePwd($uid, $old_password, $password, $safety){
		return $this->model->updatePwd($uid, $old_password, $password, $safety);
	}
	
	/**
	 * 重置用户密码
	 * @param int $uid 用户id
	 * @param string $password 新密码
	 */
	public function resetPwd($uid, $password, $safety){
		return $this->model->resetPwd($uid, $password, $safety);
	}
}