<?php

namespace Bookshare\Controller;

class NoteCommentController extends BookshareController{

  /**
   * 查询笔记
   */
  public function select($uid='',$nid=''){
    $NoteComment=M('NoteComment');
    if(!$uid&&!$nid){
      $data=$NoteComment->order('create_time desc')->select();
    }elseif($uid){
      $notecomment=$NoteComment->where(array('uid'=>$uid))->order('create_time desc')->select();
      foreach ($notecomment as $key => $value) {
        $note=D('Note')->field('name')->where(array('nid'=>$value['nid']))->find();
        $value['notename']=$note['name'];
        $data[$key]=$value;
      }
    }elseif($nid){
      $data=$NoteComment->where(array('nid'=>$nid))->order('create_time desc')->select();
    }
    foreach ($data as $key => $value) {
      $user=D('User')->field('username')->where(array('uid'=>$value['uid']))->find();
      $value['username']=$user['username'];
      $result[$key]=$value;
    }
    $this->ajaxReturn($result);
  }
  /**
   * 保存评论
   */
  /**
   * 保存评论
   */

  public function register($nid,$uid,$content){
    if(!$nid || !$content){
      $result = array('status'=>0, 'info'=>'缺少参数');
    }
    if(!$uid){
      $uid=is_login();
    }
    $model = D('NoteComment');
    $status = $model->register($nid,$uid,$content);
    if($status>0){
      $result = array('status'=>1, 'info'=>'评论成功');
    }else{
      $code=$model->getError();
      $result=array('status'=>0, 'info'=>$model->showRegError($code));
    }
    $this->ajaxReturn($result);
  }

  public function selectAll($page='1',$size){
    $count=D('NoteComment')->count();
    $firstRow=($page-1)*$size;
    $this->ajaxReturn(array('status' => 1, 'result' =>array('count'=>$count,'info'=>D('NoteComment')->limit($firstRow.','.$size)->select())));
  }
  
  public function delete($id){
    $res=D('NoteComment')->where(array('id'=>$id))->delete();
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'删除成功'));
    }else{
      $this->ajaxReturn(array('status'=>0,'info'=>'删除失败'));
    }
  }

  public function update(){
    $json_string=file_get_contents("php://input");
    $data = json_decode($json_string, true);
    $res=D('NoteComment')->where(array('id'=>$data['id']))->save($data);
    if($res>0){
      $this->ajaxReturn(array('status'=>1,'res'=>$res,'info'=>'修改成功'));
    }elseif($res==0){
      $this->ajaxReturn(array('status'=>0, 'info'=>'数据未发生改变'));
    }else{
      $code=D('NoteComment')->getError();
      $this->ajaxReturn(array('status'=>0, 'info'=>D('NoteComment')->showRegError($code)));
    }
  }
}
