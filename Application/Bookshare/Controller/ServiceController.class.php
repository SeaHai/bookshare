<?php

namespace Bookshare\Controller;
use Bookshare\Controller\Fileupload;
// 自用服务
class ServiceController extends BookshareController{

  // 上传服务
  public function upload($name){
    if(is_login()){
      $uid=is_login();
    }
    $up = new Fileupload;
    $path="./uploads/".$uid.'/'.$name;
    //设置属性(上传的位置， 大小， 类型， 名是是否要随机生成)
    $up -> set("path", $path);
    $up -> set("maxsize", 2000000);
    $up -> set("allowtype", array('rar','zip','txt','doc','pdf'));
    $up -> set("israndname", true);
    /**
     * 使用对象中的upload方法， 就可以上传文件， 
     * 方法需要传一个上传表单的名子 pic, 如果成功返回true, 失败返回false
     */
    if($up -> upload($name.'File')) {
      //获取上传后文件名字
      $fileName=$up->getFileName();

      $result=array('status'=>1,'info'=>substr($path,1).'/'.$fileName);
    
    } else {
      //获取上传失败以后的错误提示
      $result=array('status'=>0,'info'=>$up->getErrorMsg());
    }
    $this->ajaxReturn($result);
  }

  public function download($url){
    $file_path = $url;  
    $buffer = 102400; //一次返回102400个字节  
    $file_count = 0; 
    if (!file_exists($file_path)) {  
        echo "<script type='text/javascript'> alert('对不起！该文件不存在或已被删除！'); </script>";  
  
        return;  
    }  
    $fp = fopen($file_path, "r");  
    $file_size = filesize($file_path);  
    $file_data = '';  
    while(!feof($fp) && $file_count < $file_size){
      $file_data = fread($fp,$buffer);
      $file_count += $buffer;
      echo $file_data;
     } 
    fclose($fp);  
 
    //Begin writing headers  
    header("Pragma: public");  
    header("Expires: 0");  
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");  
    header("Cache-Control: public");  
    header("Content-Description: File Transfer");  
    header("Content-type:application/octet-stream;");  
    header("Accept-Ranges:bytes");  
    header("Accept-Length:{$file_size}");  
    header("Content-Disposition:attachment; filename=".basename($url));  
    header("Content-Transfer-Encoding: binary");  
  }

}
