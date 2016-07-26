<?php

return array(

  /* 模块相关配置 */
  'MODULE_DENY_LIST' => array('Common'),

  'MODULE_ALLOW_LIST' => array('Bookshare'),

  'DEFAULT_MODULE' => 'Bookshare',
  'DEFAULT_CONTROLLER'   => 'Book', // 默认控制器名称

  /* URL配置 */
  'URL_CASE_INSENSITIVE'  => true,    //默认false 表示URL区分大小写 true则表示不区分大小写
  'URL_MODEL'             => 2,       //URL模式

  /* 数据库相关配置 */
  'DB_TYPE'         => 'mysql',   // 数据库类型
  'DB_DEPLOY_TYPE'    => 0,     // 设置分布式数据库支持
  'DB_RW_SEPARATE'    => false,  // 读写分离
  'DB_TYPE'         => 'mysql',       // 数据库类型
  'DB_HOST'         => '',   // 服务器地址
  'DB_NAME'         => '',      // 数据库名
  'DB_USER'         => '',      // 用户名
  'DB_PWD'          => '',  // 密码
  'DB_PORT'         => '3306',      // 端口
  'DB_PREFIX'       => 'bs_',         // 数据库表前缀

);
