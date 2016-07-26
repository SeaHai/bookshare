<?php

namespace Bookshare\Controller;

class NoteController extends BookshareController{

  /**
   * 查询笔记
   */
  public function select($uid='',$nid=''){
    $Note=M('Note');
    if(!$uid&&!$nid){
      $data=$Note->order('create_time desc')->select();
      foreach ($data as $key => $value) {
        $user=D('User')->field('username')->where(array('uid'=>$value['uid']))->find();
        $value['username']=$user['username'];
        $result[$key]=$value;
      }
    }elseif($uid){
      $result=$Note->where(array('uid'=>$uid))->order('create_time desc')->select();
    }elseif($nid){
      $result=$Note->where(array('nid'=>$nid))->find();
    }
    $this->ajaxReturn($result);
  }

  /**
   * 新增笔记
   */
  public function register($name='',$intro='',$url=''){
    if(!$name || !$intro || !$url){
      $result = array('status'=>0, 'info'=>'缺少参数');
    }
    $model = D('Note');
    $status = $model->register($name,$intro,$url);
    if($status>0){
      $result = array('status'=>1, 'info'=>'添加成功');
    }else{
      $code=$model->getError();
      $result=array('status'=>0, 'info'=>$model->showRegError($code));
    }
    $this->ajaxReturn($result);
  }

  public function selectAll($page='1',$size){
    $count=D('Note')->count();
    $firstRow=($page-1)*$size;
    $this->ajaxReturn(array('status' => 1, 'result' =>array('count'=>$count,'info'=>D('Note')->limit($firstRow.','.$size)->select())));
  }

  public function delete($nid){
    $res=D('Note')->where(array('nid'=>$nid))->delete();
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'删除成功'));
    }else{
      $this->ajaxReturn(array('status'=>0,'info'=>'删除失败'));
    }
  }

  public function update(){
    $json_string=file_get_contents("php://input");
    $data = json_decode($json_string, true);
    $res=D('Note')->where(array('nid'=>$data['nid']))->save($data);
    if($res>0){
      $this->ajaxReturn(array('status'=>1,'res'=>$res,'info'=>'修改成功'));
    }elseif($res==0){
      $this->ajaxReturn(array('status'=>0, 'info'=>'数据未发生改变'));
    }else{
      $code=D('Note')->getError();
      $this->ajaxReturn(array('status'=>0, 'info'=>D('Note')->showRegError($code)));
    }
  }
}
