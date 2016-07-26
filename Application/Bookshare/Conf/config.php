<?php

return array(

  /* 模板相关配置 */
  'TMPL_PARSE_STRING' => array(
    '__STATICS__'     => __ROOT__ . '/statics/book'
  ),

  'URL_ROUTER_ON'   => true, //开启路由
    'URL_ROUTE_RULES' => array( //定义路由规则
        'recipe/:id\d' => 'Recipe/detail',
        'share/:uid\d' => 'Share/detail',
            '/cate-(\w+)/' => 'Recipe/cate?ename=:1',
  ),

  /* Cookie设置 */
  'COOKIE_EXPIRE'         =>  3600,    // Cookie有效期
  'COOKIE_DOMAIN'         =>  '',      // Cookie有效域名
  'COOKIE_PATH'           =>  '/',     // Cookie路径
  'COOKIE_PREFIX'         =>  '',      // Cookie前缀 避免冲突
  'COOKIE_HTTPONLY'       =>  true,      // Cookie httponly设置

);
