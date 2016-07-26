DROP DATABASE IF EXISTS `bookshare`;
CREATE DATABASE `bookshare` DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use `bookshare`;

-- ----------------------------
-- Table structure for `bs_user`
-- ----------------------------
DROP TABLE IF EXISTS `bs_user`;
CREATE TABLE `bs_user` (
  `uid` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '用户密码',
  `create_time` int(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`uid`)
) ENGINE=INNODB;

-- ----------------------------
-- Records of bs_user
-- ----------------------------
INSERT INTO `bs_user` VALUES ('1', 'admin', 'aa3b7aed1bb3e422de7111b83e58e19c', '1460344131');
INSERT INTO `bs_user` VALUES ('2', 'Tom', 'aa3b7aed1bb3e422de7111b83e58e19c', '1460347075');
INSERT INTO `bs_user` VALUES ('3', 'mary', '5f216f7bcf54180d1829cd69a4f5043d', '1460348475');
INSERT INTO `bs_user` VALUES ('4', 'bob', '49e5a717e78daea1ad5b5d1620641727', '1460350559');
INSERT INTO `bs_user` VALUES ('5', 'test', '6f8779b29166568bc236545ff16f8912', '1460350800');

-- ----------------------------
-- Table structure for `bs_book`
-- ----------------------------
DROP TABLE IF EXISTS `bs_book`;
CREATE TABLE `bs_book` (
  `bid` int(10) NOT NULL AUTO_INCREMENT COMMENT '书籍id',
  `uid` int(10) NOT NULL COMMENT '用户id',
  `name` varchar(30) NOT NULL COMMENT '书名',
  `intro` varchar(500) NOT NULL COMMENT '书籍简介',
  `cate` varchar(20) NOT NULL COMMENT '书籍分类',
  `url` varchar(50) NOT NULL COMMENT '路径',
  `create_time` int(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`bid`),
  INDEX (`uid`),
  FOREIGN KEY (`uid`) REFERENCES bs_user(`uid`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

-- ----------------------------
-- Records of bs_book
-- ----------------------------
INSERT INTO `bs_book` VALUES ('1', '2', '《JavaScript DOM编程艺术》', '  本书讲述了javascript和dom的基础知识，但重点放在dom编程技术背后的思路和原则：预留退路、循序渐进和以用户为中心等，这些概念对于任何前端web开发工作都非常重要。本书将这些概念贯穿在书中的所有代码示例中，使你看到用来创建图片库页面的脚本、用来创建动画效果的脚本和用来丰富页面元素呈现效果的脚本，最后结合所讲述的内容创建了一个实际的网站。', 'javascript', '/uploads/2/book/20160411120222_498.txt', '1460347344');
INSERT INTO `bs_book` VALUES ('2', '2', '《PHP基础教程(第4版)》', '这本书以通俗易懂的语言向初学者介绍了PHP 语言的基本概念、使用方法和注意事项。全书通 过丰富的示例，引领读者逐步掌握这门流行的Web 开发语言，使读者能够上手编写适用于常用场景的PHP 脚本。适合有基本HTML 经验的读者阅读。', 'php', '/uploads/2/book/20160411121125_479.pdf', '1460347887');
INSERT INTO `bs_book` VALUES ('3', '5', '《java从入门到精通》（第3版）', '本书从初学者角度出发，通过通俗易懂的语言、丰富多彩的实例，详细介绍了使用Java语言进行程序开发应该掌握的各方面技术。全书共分28章，包括：初识Java，熟悉Eclipse开发工具，Java 语言基础，流程控制，字符串，数组，类和对象，包装类，数字处理类，接口、继承与多态，类的高级特性，异常处理，Swing程序设计，集合类，I/O输入输出，反射，枚举类型与泛型，多线程，网络通信，数据库操作，Swing表格组件，Swing树组件，Swing其他高级组件，高级布局管理器，高级事件处理，AWT绘图与音频播放，打印技术和企业进销存管理系统等。所有知识都结合具体实例进行介绍，涉及的程序代码给出了详细的注释，可以使读者轻松领会Java程序开发的精髓，快速提高开发技能。', 'java', '/uploads/5/book/20160411130056_920.rar', '1460350858');
INSERT INTO `bs_book` VALUES ('4', '5', '《PHP与MySQL程序设计(第4版)》', '《PHP基础教程(第4版)》中稍微提及了简单的PHP连接和使用MySQL数据库的方法，但对于实际应用中仍然不够。\n   W.JasonGilmore编著的《PHP与MySQL程序设计(第4版)》是全面讲述PHP与MySQL的经典之作，书中不但全面介绍了两种技术的核心特性，还讲解了如何高效地结合这两种技术构建健壮的数据驱动的应用程序。《PHP与MySQL程序设计(第4版)》涵盖了两种技术新版本中出现的最新特性，书中大量实际的示例和深入的分析均来自于作者在这方面多年的专业经验，可用于解决开发者在实际中所面临的各种挑战。    《PHP与MySQL程序设计(第4版)》内容全面深入，适合各层次PHP和MySQL开发人员阅读，既是优秀的学习教程，也可用作参考手册。', 'php', '/uploads/5/book/20160411130139_786.txt', '1460350900');
INSERT INTO `bs_book` VALUES ('5', '5', '《MySQL技术内幕:InnoDB存储引擎》', 'MySQL技术内幕:InnoDB存储引擎（源码级解析InnoDB实现原理和工作机制，MySQL领域超级畅销书，国内外专家联袂推荐）\n　　本书是国内目前唯一的一本关于innodb的著作，由资深mysql专家亲自执笔，中外数据库专家联袂推荐，权威性毋庸置疑。\n　　内容深入，从源代码的角度深度解析了innodb的体系结构、实现原理、工作机制，并给出了大量最佳实践，能帮助你系统而深入地掌握innodb，更重要的是，它能为你设计和管理高性能、高可用的数据库系统提供绝佳的指导。注重实战，全书辅有大量的案例，可操作性极强。\n　　全书首先全景式地介绍了mysql独有的插件式存储引擎，分析了mysql的各种存储引擎的优势和应用环境；接着以innodb的内部实现为切入点，逐一详细讲解了innodb存储引擎内部的各个功能模块，包括innodb存储引擎的体系结构、内存中的数据结构、基于innodb存储引擎的表和页的物理存储、索引与算法、文件、锁、事务、备份，以及innodb的性能调优等重要的知识；最后深入解析了innodb存储引擎的源代码结构，对大家阅读和理解innodb的源代码有重要的指导意义。', 'mysql', '/uploads/5/book/20160411135401_754.zip', '1460354042');
INSERT INTO `bs_book` VALUES ('6', '5', '《Android基础教程》', 'Android是谷歌公司开发的全新开源手机平台。本书是一部关于 android开发的基础教程，采用由浅入深、循序渐进的方式讨论android。书中还结合数独游戏等实例更加形象生动地讲解了 android开发的基本流程，且每章最后都有一个 “快速阅读指南 ”，更加方便了读者的阅读。. 本书内容完整丰富，具有较强的通用性，读者都能通过本书快速学习 android开发，提高相关技能。', 'android', '/uploads/5/book/20160411140536_648.doc', '1460354738');
INSERT INTO `bs_book` VALUES ('7', '5', '《UNIX 环境高级编程》', '《UNIX环境高级编程》是 Unix/ Linux 程序员案头必备的一本书籍。可以说，Linux程序员如果没有读过这本书，就好像基督教徒没有读过圣经一样，是很难让人理解的。这本书概括了 Linux编程所需的一切理论框架、主要系统函数、多进程编程、乃至 Linux网络通信。对于初学者，如果你能将《操作系统》这门课程结合着这本书来学习，试着用 Linux程序实践《操作系统》这门书中讲的进程间通信、进程调度、进程同步等内容，相信这将是一个一举两得的事情。哦，忘了告诉大家，上次 CNN采访 Google 总裁佩林的时候，水煮鱼看到佩林的书架上就有这本书的英文版，可见它真的是一本全球开发者必备的一本书。', 'linux', '/uploads/5/book/20160411140820_212.txt', '1460354902');
INSERT INTO `bs_book` VALUES ('8', '3', '《Android应用开发揭秘》', '这是一本参考手册，内容的完整性和系统性几乎无可挑剔，可作为广大Android开发者的案头必备书；这是一部权威指南，基础知识部分翔实而丰富，高级知识部分深入且饱含最佳实践，能从本质上提升开发者对Android的理解和开发水平。尤为值得一提的是，Android 2.0中新增了大量激动人心的新特性，不仅支持多点触摸设备、软键盘，而且还支持多账户在线管理、蓝牙……作为国内第一本基于Android 2.0的著作，本书可谓极具前瞻性，第一时间将这些新特性完美地呈现给了广大读者。', 'android', '/uploads/3/book/20160411140957_622.pdf', '1460354999');
INSERT INTO `bs_book` VALUES ('9', '3', '《深入PHP：面向对象、模式与实践(第3版)》', '《深入PHP：面向对象、模式与实践（第3版）》是PHP专家赞德斯经典力作的最新版本。书中主要介绍了如何使用面向对象技术和设计模式编写稳定的、可维护的代码，如何使用Subversion管理多个开发人员，如何使用Phing和PEAR进行构建和安装，以及将构建和测试过程自动化的策略，包括持续集成。\n这本书适合每位PHP开发人员进阶参考。可帮助他们掌握PHP面向对象设计和开发的精髓，并最终跻身高端PHP开发人员之列。', 'php', '/uploads/3/book/20160411141123_312.zip', '1460355084');
INSERT INTO `bs_book` VALUES ('10', '3', '《深入理解 Linux 内核》', '学习 Linux ，就要学习 Linux 的精华。而 Linux 的精华，则在于 Linux 的内核。《深入理解 Linux内核》就是一本辅助学习 Linux 内核的经典书籍。有的初学者，在没有人指导的情况下，就钻入 LinuxKernel代码的海洋中埋头苦学，结果学了半天仍然是一头雾水。当然了，在大师指导下学习就不一样了。本书以最新的 Linux 2.6版架构为基础，分门别类地向初学者介绍了 Linux 内核的架构、编程思想、以及功能模块。相信你在本书的指导下学习，对于你读懂Linux 操作系统的精华部分，会取得事半功倍的效果。事实上，不少知名公司招聘的题目里面，很多就出自这本书，可见它真的是论述Linux 内核的经典书籍。', 'linux', '/uploads/3/book/20160411143914_653.txt', '1460356756');
INSERT INTO `bs_book` VALUES ('11', '4', '《JavaScript高级程序设计（第3版）》', '本书是JavaScript 超级畅销书的最新版。ECMAScript 5 和HTML5 在标准之争中双双胜出，使大量专有实现和客户端扩展正式进入规范，同时也为JavaScript 增添了很多适应未来发展的新特性。本书这一版除增加5 章全新内容外，其他章节也有较大幅度的增补和修订，新内容篇幅约占三分之一。全书从JavaScript 语言实现的各个组成部分——语言核心、DOM、BOM、事件模型讲起，深入浅出地探讨了面向对象编程、Ajax 与Comet 服务器端通信，HTML5 表单、媒体、Canvas（包括WebGL）及Web Workers、地理定位、跨文档传递消息、客户端存储（包括IndexedDB）等新API，还介绍了离线应用和与维护、性能、部署相关的最佳开发实践。本书附录展望了未来的API 和ECMAScript Harmony 规范。\n本书适合有一定编程经验的Web 应用开发人员阅读，也可作为高校及社会实用技术培训相关专业课程的教材。', 'javascript', '/uploads/4/book/20160411144205_745.pdf', '1460356928');
INSERT INTO `bs_book` VALUES ('12', '4', '《Google Android SDK开发范例大全》', '本书以android手机应用程序开发为主题，通过130多个范例全面且深度地整合了手机、网络及服务等多个开发领域，为读者提高程序设计功力提供了很大的帮助。. 全书共分10章，主要以范例集的方式来讲述android的知识点，详细介绍了开发android的人机交互界面、android常用的开发控件、使用android手机收发短信等通信服务、开发android手机的自动服务功能和娱乐多媒体功能以及整合android与aoogle强大的网络服务等内容，随书光盘中包括了所有范例的程序代码。', 'android', '/uploads/4/book/20160411144341_428.pdf', '1460357023');
INSERT INTO `bs_book` VALUES ('13', '4', '《MySQL必知必会》', 'MySQL作为开源软件的代表，已经成为世界上最受欢迎的数据库管理系统之一。\n《MySQL必知必会》是经典畅销书《SQL必知必会》之后，作者应众多读者的请求编写的，专门针对MySQL用户。《MySQL必知必会》中继承了《SQL必知必会》的优点，没有过多阐述数据库基础理论，而是紧贴实战需要，直接从数据检索开始，逐步深入各种复杂的内容，包括联结的使用、子查询、正则表达式和基于全文本的搜索、存储过程、游标、触发器、表约束，等等。通过《MySQL必知必会》，读者能够掌握扎实的基本功，迅速成为MySQL高手。\n《SQL必知必会》作者新作、Amazon全五星评价、学习与参考皆宜', 'mysql', '/uploads/4/book/20160411144544_144.doc', '1460357146');
INSERT INTO `bs_book` VALUES ('14', '4', '《java核心技术卷一》', '本书是Java技术经典参考书，多年畅销不衰，第7版在保留以前版本风格的基础上，涵盖Java2开发平台标准版J2SE5.0的基础知识，主要内容包括面各对象程序设计、反射与代理、接口与内部类、事件监听器模型、使用Swing UI工具箱进行图形用户界面设计，异常处理、流输入/输出和对象序列化、泛型程序设计等。本书内容翔实、深入浅出，附有大量程序实例，极具实用价值，是Java初学者和Java程序员的必备参考书。', 'java', '/uploads/4/book/20160411144652_227.zip', '1460357213');
INSERT INTO `bs_book` VALUES ('15', '4', '《锋利的jQuery》', '每多学一点知识，就少写一行代码。\njQuery，顾名思议，也就是JavaScript和查询（Query），即是辅助JavaScript开发的库。\n本书循序渐进地对jQuery的各种方法和使用进行介绍，读者可以系统地掌握jQuery关于DOM操作、事件监听和动画、表单操作、Ajax，以及插件方面知识点，并结合每个章节后面的案例演示进行练习，达到掌握本章节知识点的目的。', 'javascript', '/uploads/4/book/20160411144826_864.rar', '1460357307');

-- ----------------------------
-- Table structure for `bs_note`
-- ----------------------------
DROP TABLE IF EXISTS `bs_note`;
CREATE TABLE `bs_note` (
  `nid` int(10) NOT NULL AUTO_INCREMENT COMMENT '笔记id',
  `uid` int(10) NOT NULL COMMENT '用户id',
  `name` varchar(30) NOT NULL COMMENT '笔记名',
  `intro` varchar(500) NOT NULL COMMENT '笔记简介',
  `url` varchar(50) NOT NULL COMMENT '路径',
  `create_time` int(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`nid`),
  INDEX (`uid`),
  FOREIGN KEY (`uid`) REFERENCES bs_user(`uid`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

-- ----------------------------
-- Records of bs_note
-- ----------------------------
INSERT INTO `bs_note` VALUES ('1', '4', 'JavaScript学习笔记[1]---入门', '<html>\n    <head>\n        <title>About JavaScript </title>\n    </head>\n    <body>\n        <h1>Learning JavaScript</h1>\n        <p>JavaScript is:</p>\n        <ul id=\"optionList\">\n            <li>a language that runs in the browser</li>\n            <li>simple, but powerful</li>\n            <li>misunderstood</li>\n        </ul>\n    </body>\n</html>', '/uploads/4/note/20160411150329_844.doc', '1460358210');
INSERT INTO `bs_note` VALUES ('2', '4', 'PHP的变量的范围', '局部变量：在函数中声明的变量，只能在自己的函数内部使用。  全局变量：在函数外声明，在变量声明以后，知道整个脚本结束前都可以使用，包括在函 数中和{}中都可使用。   PHP的变量分不出是声明还是使用，在PHP中使用全局变量 要通过global关键字将这个全局变量包含到函数中才能使用到，在global声明之后才是使用全局的变量  参数就是局部变量，这个局部变量可以调用时去赋值。', '/uploads/4/note/20160411150950_102.txt', '1460358591');
INSERT INTO `bs_note` VALUES ('3', '3', 'Android学习笔记', '在Android 拥戴者的奇特世界观中有个很有趣的对比： \nAndroid：开源的 Linux + Google 的封闭软件 + 私有的基带 + 运营商锁定 = 开放的 Android 手机 iPhone：开源的 BSD + 苹果的闭源软件 + 私有的基带 + 运营商锁定 = 封闭的苹果 iPhone \nAndroid：正义！一个平庸的应用商店，开发者依靠广告赚钱，商店并非独此一家，用户找不到好软件。（开发者只需一次性支付25美金） \niPhone：邪恶！一个出色的应用商店，开发者凭本事吃饭，商店独此一家，开店的要收点钱。顾客得到物美价廉的商品。（开发者需每年支付99美金） \nAndroid：自由！酷，每个人都在用。这个公司应该运营一切，而且很快就会实现，除非竞争者阻止他们在每部手机、每台电视和 PC 上推广开源而自由的文化。 \niPhone：奴役! 如此的不酷以至于每个人都在用。他们认为这个公司应该运营一切，除非竞争者阻止他们在开放的市场将手机、电视和电脑推销给每一个人。', '/uploads/3/note/20160411151242_325.pdf', '1460358763');
INSERT INTO `bs_note` VALUES ('4', '3', 'Nginx中文域名配置', 'Punycode？\nPunycode是一个根据RFC 3492标准而制定的编码系统,主要用於把域名从地方语言所采用的Unicode编码转换成为可用於DNS系统的编码。 \"中文域名\"后缀不被标准的解析服务器支持，需转化为punycode码进行解析。\n修改Nginx配置\nserver {\nlisten 80;\nserver_name blog.linuxeye.com linuxeye.xn--fiqs8s;\n...\n}\n保存，重载nginx：\nservice nginx reload', '/uploads/3/note/20160411152234_206.txt', '1460359355');
INSERT INTO `bs_note` VALUES ('5', '2', 'PHP的静态变量', '静态变量只能声明在函数中（类中），不能在全局声明 使用static在变量前   作用：一个变量可以在同一个函数在多次调用中同用      1.静态变量在静态代码段中保存   2.一个函数多次调用之间共用，但只在第一次调用函数时声明到内存，以后再调用，就不再声明，而直接使用', '/uploads/2/note/20160411153208_453.doc', '1460359929');
INSERT INTO `bs_note` VALUES ('6', '2', 'JAVA的面向对象编程', '面向对象主要针对面向过程。 面向过程的基本单元是函数。  \n什么是对象：EVERYTHING IS OBJECT（万物皆对象）  \n所有的事物都有两个方面： 有什么（属性）：用来描述对象。 能够做什么（方法）：告诉外界对象有那些功能。 后者以前者为基础。 \n大的对象的属性也可以是一个对象。  \n为什么要使用面向对象： \n首先，面向对象符合人类看待事物的一般规律。 \n对象的方法的实现细节是屏蔽的，只有对象方法的实现者了解细节。 方法的定义非常重要。方法有参数，也可能有返回值。', '/uploads/2/note/20160411153804_381.rar', '1460360284');
INSERT INTO `bs_note` VALUES ('7', '5', 'android安装环境', '1、安装所需的环境，J2SE的JDK和作为IDE的Eclipse。\n2、下载和安装Andriod的SDK：\n3、在Eclipse中安装和配置ATD\n安装完之后，我们看到工具栏里面增加了Andriod的图标，这就是第二步骤中我们用命令行开启的Andriod SDK和AVD的管理器，点击进去，可以配置我们的虚拟设备，点击New增加一个，下面两图，左图是增加后，点击Edit查看的配置，右图是选择虚拟机， 进行打开Start后Andriod虚拟机的截图', '/uploads/5/note/20160411154341_717.txt', '1460360622');

-- ----------------------------
-- Table structure for `bs_book_comment`
-- ----------------------------
DROP TABLE IF EXISTS `bs_book_comment`;
CREATE TABLE `bs_book_comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL COMMENT '用户id',
  `bid` int(10) NOT NULL COMMENT '书籍id',
  `content` varchar(200) NOT NULL COMMENT '书籍评论内容',
  `create_time` int(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX (`uid`),
  INDEX (`bid`),
  FOREIGN KEY (`uid`) REFERENCES bs_user(`uid`) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (`bid`) REFERENCES bs_book(`bid`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

-- ----------------------------
-- Records of bs_book_comment
-- ----------------------------
INSERT INTO `bs_book_comment` VALUES ('1', '4', '15', '刚看到第4章，忍不住上来写书评，这本书对于没有基础的我，实在是完美啊！！！写得非常通俗易懂，想学或者只是想了解下jquery的同学，我强烈推荐，不要错过哦！！！我都不知道说什么了，继续看下去，争取今天晚上看完。。。。。。', '1460357655');
INSERT INTO `bs_book_comment` VALUES ('2', '4', '11', '胜在够全面，但无论从细节方面和可读性方面都没有犀牛书好。尤其在对象的讲解上，和犀牛书差的不是一点半点。作用链倒是讲得比犀牛书简洁明了。这本书和Andrew S. Tanenbaum 那本《计算机网络》一样，在国内都是过誉了，原因大概是两本书正好出现在了同类优秀书籍在国内相对匮乏的时代。', '1460357744');
INSERT INTO `bs_book_comment` VALUES ('3', '4', '12', '书中的例子着实不少，各方面都有涉猎，省了不少时间去查其他方面相同的资料，对于Android初学者的帮助无疑是最大的，可以很快对Android有一个清楚的认识，明白Android可以实现什么功能，值得一读，赞一个！', '1460357806');
INSERT INTO `bs_book_comment` VALUES ('4', '4', '5', 'InnoDB存储引擎 介绍了MySQL的体系结构和各种常见的存储引擎以及它们之间的比较；非常实用！！赞一个赞一个。 　　包括InnoDB存储引擎的体系结构、内存中的数据结构、基于InnoDB存储引擎的表和页的物理存储、索引与算法、文件、锁、事务、备份与恢复，以及InnoDB的性能调优等重要的知识，收益以匪浅啦', '1460357883');
INSERT INTO `bs_book_comment` VALUES ('5', '4', '2', '突然想到补补课，去学些基本的东西~~~然后就找到这本书，看后发现：嗯，太基础了。刚开始coding的同学可以参看，因为太基础了，可能看过后再读一遍的意义不大，但是不管是有些基础还是0基础，来翻翻基础书是没什么问题的。因为有Python和C语言的基础，看php非常容易。总体来讲还是不错的。', '1460357932');
INSERT INTO `bs_book_comment` VALUES ('6', '3', '15', '看过几本关于jQuery的中文书，这其中包括一些“野书”和“名著”（《learning jQuery》《jQuery in Action》之类的翻译版），总体上感觉这本《锋利的jQuery》比较适合拿来当做jQuery的第一本书。作者是非常年轻的一名前端开发人员，但书写的详略得当，比较适合中国人的阅读习惯。', '1460359467');
INSERT INTO `bs_book_comment` VALUES ('7', '3', '1', '非常简单易懂啊！！循序渐进的跟看红砖书不一样，很快看完就知道能用js做什么，好评！', '1460359701');
INSERT INTO `bs_book_comment` VALUES ('8', '3', '3', '很好，值得推荐', '1460359767');
INSERT INTO `bs_book_comment` VALUES ('9', '3', '6', '做了个数独，算是看完，入门佳', '1460359803');
INSERT INTO `bs_book_comment` VALUES ('10', '3', '9', '了解了类与对象的共性，但下面的设计模式，有感于 php复杂太细化了，还是喜欢swift', '1460359839');
INSERT INTO `bs_book_comment` VALUES ('11', '2', '9', '#php入门之选#如果要读一本php的入门书，这本就够了', '1460359999');
INSERT INTO `bs_book_comment` VALUES ('12', '2', '12', '不错的书，如果英文可以的话直接看SDK文档就好。', '1460360058');
INSERT INTO `bs_book_comment` VALUES ('13', '2', '4', '随便抽了一些来看的，基本上还是蛮简单的，存储例程不是很懂', '1460360127');
INSERT INTO `bs_book_comment` VALUES ('14', '2', '8', '目前最佳Android开发类图书！', '1460360162');
INSERT INTO `bs_book_comment` VALUES ('15', '2', '14', '比Gosling的The Java Programming Language要容易入门的多，亮点在于书中随处可见的C++和Java的对比，总之，对于有一定C++基础或者OOP概念的人，这本是Java最佳入门书籍。', '1460360205');
INSERT INTO `bs_book_comment` VALUES ('16', '5', '11', '很不错，全面，深入，文笔也很好', '1460360823');
INSERT INTO `bs_book_comment` VALUES ('17', '5', '11', 'JavaScript学习必读，详细解释了JavaScript的工作原理。', '1460360838');
INSERT INTO `bs_book_comment` VALUES ('18', '5', '13', '对入门者很照顾的一本书，与其说是一本书不如说是一本小册子，不到250页的小册子，实践性很强，基本没有什么理论的堆砌，完完全全就是一本实践指南，教会你怎么用SQL语句操作MySQL。看完这本书基本就可以说是入门了。唯一缺点就是贵了点', '1460360885');

-- ----------------------------
-- Table structure for `bs_note_comment`
-- ----------------------------
DROP TABLE IF EXISTS `bs_note_comment`;
CREATE TABLE `bs_note_comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL COMMENT '用户id',
  `nid` int(10) NOT NULL COMMENT '笔记id',
  `content` varchar(200) NOT NULL COMMENT '笔记评论内容',
  `create_time` int(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX (`uid`),
  INDEX (`nid`),
  FOREIGN KEY (`uid`) REFERENCES bs_user(`uid`) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (`nid`) REFERENCES bs_note(`nid`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

-- ----------------------------
-- Records of bs_note_comment
-- ----------------------------
INSERT INTO `bs_note_comment` VALUES ('1', '4', '1', '很不错，值得学习', '1460358436');
INSERT INTO `bs_note_comment` VALUES ('2', '3', '3', '可以，挺简单易懂的', '1460358971');
INSERT INTO `bs_note_comment` VALUES ('3', '3', '2', '还没看完 我觉得外国人写的很由浅入深啊 怎么这么少人评价这本书', '1460359244');
INSERT INTO `bs_note_comment` VALUES ('4', '3', '4', '一般都不会用中文域名', '1460359406');
INSERT INTO `bs_note_comment` VALUES ('5', '2', '2', '很好，总结的不错', '1460360395');
INSERT INTO `bs_note_comment` VALUES ('6', '2', '4', '不太理解', '1460360421');
INSERT INTO `bs_note_comment` VALUES ('7', '2', '6', '比较面向过程的思想和面向对象的思想：  面向过程的思想：由过程、步骤、函数组成，以过程为核心；  面向对象的思想：以对象为中心，先开发类，得到对象，通过对象之间相互通信实现功能。 面向过程是先有算法，后有数据结构。  面向对象是先有数据结构，然后再有算法。', '1460360432');
INSERT INTO `bs_note_comment` VALUES ('8', '5', '4', '还可以，能在讲明白点吗', '1460360668');
INSERT INTO `bs_note_comment` VALUES ('9', '5', '7', '嗯，很好，已经照着装好了', '1460360714');
INSERT INTO `bs_note_comment` VALUES ('10', '5', '3', '还好吧', '1460360730');
INSERT INTO `bs_note_comment` VALUES ('11', '5', '5', '不错，看明白了', '1460360778');


