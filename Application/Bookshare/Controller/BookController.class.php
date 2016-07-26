<?php

namespace Bookshare\Controller;

class BookController extends BookshareController{

  public function _empty(){

    $this->display('index');
  }
  
  public function index(){

    $this->display();
  }
  /**
   * 查询全部书籍
   */
  public function select($uid='',$bid=''){
    $Book=M('Book');
    if(!$uid&&!$bid){
      $data=$Book->order('create_time desc')->select();
      foreach ($data as $key => $value) {
        $user=D('User')->field('username')->where(array('uid'=>$value['uid']))->find();
        $value['username']=$user['username'];
        $result[$key]=$value;
      }
    }elseif($uid){
      $result=$Book->where(array('uid'=>$uid))->order('create_time asc')->select();
    }elseif($bid){
      $result=$Book->where(array('bid'=>$bid))->find();
    }
    $this->ajaxReturn($result);
  }

  /**
   * 新增书籍
   */
  public function register($name='',$intro='',$cate='',$url=''){
    if(!$name || !$intro || !$cate || !$url){
      $result = array('status'=>0, 'info'=>'缺少参数');
    }
    $model = D('Book');
    $status = $model->register($name,$intro,$cate,$url);
    if($status>0){
      $result = array('status'=>1, 'info'=>'添加成功');
    }else{
      $code=$model->getError();
      $result=array('status'=>0, 'info'=>$model->showRegError($code));
    }
    $this->ajaxReturn($result);
  }

  public function selectAll($page='1',$size){
    $count=D('Book')->count();
    $firstRow=($page-1)*$size;
    $this->ajaxReturn(array('status' => 1, 'result' =>array('count'=>$count,'info'=>D('Book')->limit($firstRow.','.$size)->select())));
  }

  public function delete($bid){
    $res=D('Book')->where(array('bid'=>$bid))->delete();
    if($res){
      $this->ajaxReturn(array('status'=>1,'info'=>'删除成功'));
    }else{
      $this->ajaxReturn(array('status'=>0,'info'=>'删除失败'));
    }
  }

  public function update(){
    $json_string=file_get_contents("php://input");
    $data = json_decode($json_string, true);
    $res=D('Book')->where(array('bid'=>$data['bid']))->save($data);
    if($res>0){
      $this->ajaxReturn(array('status'=>1,'res'=>$res,'info'=>'修改成功'));
    }elseif($res==0){
      $this->ajaxReturn(array('status'=>0, 'info'=>'数据未发生改变'));
    }else{
      $code=D('Book')->getError();
      $this->ajaxReturn(array('status'=>0, 'info'=>D('Book')->showRegError($code)));
    }
  }

}
