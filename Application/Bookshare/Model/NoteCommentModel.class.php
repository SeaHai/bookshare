<?php

namespace Bookshare\Model;
use Think\Model\RelationModel;


class NoteCommentModel extends RelationModel {

    /* 笔记模型自动验证 */
    protected $_validate = array(
        
        array('content', '2,200', -1, self::EXISTS_VALIDATE, 'length'), //书名长度不合法

    );
    protected $_auto = array(
        // array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('create_time', NOW_TIME, self::MODEL_INSERT)
    );
    public function showRegError($code = 1){
        switch ($code) {
            case -1:  $error = '评论内容长度必须在2-200个字符之间！'; break;
            default:  $error = '未知错误';
        }
        return $error;
    } 
    
    /**
     * 上传一本笔记
     * @param  string $name 笔记名
     * @return integer          注册成功-书籍id，注册失败-错误编号
     */
    public function register($nid,$uid,$content){
        $data = array();
        if(isset($nid)){   // 书id
            $data['nid']   = $nid;
        }
        if(isset($uid)){   // 用户id
            $data['uid']   = $uid;
        }
        if(isset($content)){   // 内容
            $data['content']   = $content;
        }
        /* 添加用户 */
        if($this->create($data)){
            $id = $this->add();
            return $id ? $id : 0; //0-未知错误，大于0-注册成功
        } else {
            return $this->getError(); //错误详情见自动验证注释
        }
    }
    
}
