<?php

namespace Bookshare\Controller;

class BookCommentController extends BookshareController{

  /**
   * 查询笔记
   */
  public function select($uid='',$bid=''){
    $BookComment=M('BookComment');
    if(!$uid&&!$bid){
      $data=$BookComment->order('create_time desc')->select();
    }elseif($uid){
      $bookcomment=$BookComment->where(array('uid'=>$uid))->order('create_time desc')->select();
      foreach ($bookcomment as $key => $value) {
        $book=D('Book')->field('name')->where(array('bid'=>$value['bid']))->find();
        $value['bookname']=$book['name'];
        $data[$key]=$value;
      }
    }elseif($bid){
      $data=$BookComment->where(array('bid'=>$bid))->order('create_time desc')->select();
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

  public function register($bid,$uid,$content){
    if(!$bid || !$content){
      $result = array('status'=>0, 'info'=>'缺少参数');
    }
    $model = D('BookComment');
    if(!$uid){
      $uid=is_login();
    }
    $status = $model->register($bid,$uid,$content);
    if($status>0){
      $result = array('status'=>1, 'info'=>'评论成功');
    }else{
      $code=$model->getError();
      $result=array('status'=>0, 'info'=>$model->showRegError($code));
    }
    $this->ajaxReturn($result);
  }
  
  public function selectAll($page='1',$size){
    $count=D('BookComment')->count();
    $firstRow=($page-1)*$size;
    $this->ajaxReturn(array('status' => 1, 'result' =>array('count'=>$count,'info'=>D('BookComment')->limit($firstRow.','.$size)->select())));
  }
  
  public function delete($id){
    $res=D('BookComment')->where(array('id'=>$id))->delete();
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'删除成功'));
    }else{
      $this->ajaxReturn(array('status'=>0,'info'=>'删除失败'));
    }
  }

  public function update(){
    $json_string=file_get_contents("php://input");
    $data = json_decode($json_string, true);
    // 更新数据
    $res=D('BookComment')->where(array('id'=>$data['id']))->save($data);
    if($res>0){
      $this->ajaxReturn(array('status'=>1,'res'=>$res,'info'=>'修改成功'));
    }elseif($res==0){
      // 数据未发生更改
      $this->ajaxReturn(array('status'=>0, 'info'=>'数据未发生改变'));
    }else{
      // 修改时填入的数据不合法，提示错误信息
      $code=D('BookComment')->getError();
      $this->ajaxReturn(array('status'=>0, 'info'=>D('BookComment')->showRegError($code)));
    }
  }
}
