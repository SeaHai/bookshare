<?php

namespace Bookshare\Model;
use Bookshare\Api\UserApi;
use Think\Model\RelationModel;


class UserModel extends RelationModel {

    /* 用户模型自动验证 */
    protected $_validate = array(
        /* 验证用户名 */
        array('username', '2,20', -1, self::EXISTS_VALIDATE, 'length'), //用户名长度不合法
        array('username', '', -2, self::EXISTS_VALIDATE, 'unique'), //用户名被占用

        /* 验证密码 */
        array('password', '4,20', -4, self::EXISTS_VALIDATE, 'length'), //密码长度不合法
    );
    protected $_auto = array(
        // array('create_uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
    );
    public function showRegError($code = 1){
        switch ($code) {
            case -1:  $error = '用户名长度必须在2-20个字符之间！'; break;
            case -2:  $error = '用户名被占用！'; break;
            case -3:  $error = '用户名不存在！'; break;
            case -4:  $error = '密码长度必须在4-20个字符之间！'; break;
            case -5:  $error = '密码错误！'; break;
            default:  $error = '未知错误';
        }
        return $error;
    } 
    
    /**
     * 注册一个新用户
     * @param  string $username 用户名
     * @param  string $password 用户密码
     * @param  boolean $safety  是否客户端APP加密
     * @return integer          注册成功-用户信息，注册失败-错误编号
     */
    public function register($username, $password, $safety){
        $data = array();
        if(isset($username)){   // 用户名
            $data['username']   = $username;
        }
        if(isset($password)){   // 密码
            $data['password']   = $password;
        }
        
        /* 添加用户 */
        if($this->create($data)){
            if($safety){ // safety by client
                $this->password = think_ucenter_md5($password, UC_AUTH_KEY, $safety);
            }
            $uid = $this->add();
            return $uid ? $uid : 0; //0-未知错误，大于0-注册成功
        } else {
            return $this->getError(); //错误详情见自动验证注释
        }
    }

    /**
     * 注销当前用户
     * @return void
     */
    public function logout(){
        session('user_auth', null);
    }

    /**
     * 自动登录用户
     * @param  integer $user 用户信息数组
     */
    public function autoLogin($user){
        /* 更新登录信息 */
        $data = array(
            'uid'             => $user['uid'],
            'username'        => $user['username']
        );
        $this->save($data);

        /* 记录登录SESSION和COOKIES */
        $auth = array(
            'uid'             => $user['uid'],
            'username'        => $user['username']
        );

        session('user_auth', $auth);
    }
    /**
     * 获取用户信息
     * @param  string  $uid         用户ID或用户名
     * @return array                用户信息
     */
    public function info($uid){
        $map = array();
        $map['uid'] = $uid;
        $user = $this->where($map)->field('uid,username')->find();
        if(is_array($user)){
            return array('uid'=>$user['uid'],'username'=> $user['username']);
        } else {
            return -3; //用户不存在或被禁用
        }
    }

    /**
     * 验证用户密码
     * @param int $uid 用户id
     * @param string $password_in 密码
     * @return true 验证成功，false 验证失败
     */
    public function verifyUser($uid, $password_in){
        $password = $this->where(array('uid'=>$uid))->getFieldById($uid, 'password');
        if(think_ucenter_md5($password_in, UC_AUTH_KEY,1) === $password){
            return true;
        }
        return false;
    }
    
    /**
     * 更新用户密码
     * @param int $uid 用户id
     * @param string $password 新密码
     */
    public function updatePwd($uid, $old_password, $password, $safety){
        
        /* 验证用户密码 */
        $old = $this->getFieldById($uid, 'password');
        if(think_ucenter_md5($old_password, UC_AUTH_KEY, $safety) === $old){
            $data = array('password'    => think_ucenter_md5($password, UC_AUTH_KEY, $safety));
            return $this->where(array('uid'=>$uid))->save($data);
        }
        return false; //密码错误
    }
    
    /**
     * 重置用户密码
     * @param int $uid 用户id
     * @param string $password 新密码
     */
    public function resetPwd($uid, $password, $safety){
        $data = array(
            'password'  => think_ucenter_md5($password, UC_AUTH_KEY, $safety)
        );
        return $this->where(array('uid'=>$uid))->save($data);
    }

    /**
     * 根据用户名获取uid
     * @param  [string] $username 用户名
     */
    public function getUid($username){
        return $this->where(array('username'=>$username))->getField('uid');
    }


}
