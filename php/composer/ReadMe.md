# [Composer三步曲：安装、使用、发布](https://segmentfault.com/a/1190000011858458)

## 先决条件

```
yum -y install php
# 查看是否安装php
php -v
```



> 原文是在我自己博客中，小伙伴也可以点[阅读原文](https://www.cxiansheng.cn/server/316)进行跳转查看，还有好听的背景音乐噢~

![composer](https://www.cxiansheng.cn/usr/uploads/2017/11/905996380.jpg "composer")

在现代化的PHP开发当中，离开不了各种各样的组件，那么如何快速在项目中安装和找到这些组件呢？composer正是为这一目的而出现，如果你还不知道composer，那么你就out了。那么什么是composer，它的作用是什么？如何使用？本文将一一揭晓。

## 组件

在说composer之前，我们先来了解一下什么组件。因为组件和composer之间密切相关，要想知道composer是如何工作的，我们要先清楚什么是组件。

### 什么是组件

组件是打包的代码，用于我们在实际项目中解决某个问题。比如你要输出一段漂亮的数据，摆脱`var_dump`和`print_r`函数，那么我们就可以使用组件[var-dumper](https://packagist.org/packages/symfony/var-dumper)组件；我们要写日志，就可以使用[monolog](http://monolog/)来实现。这些组件，已经有PHP开发者开发出来，我们在项目中当有这样的场景的时候，直接拿来用就可以。

### 为什么要使用组件

一句话来概括：别人已经造好的轮子，我们为什么不拿来用呢？我们完全不用重复实现已经实现了的功能，应该要把更多时间用在项目的长远目标上。

### 组件的特点

我们在使用PHP组件的时候，要先判断这个组件是否是我们需要的，是否有一些功能还不严谨，就像在菜市场买菜，好坏都有。那么好的组件，基本上都具有这些特征：

#### 作用单一

组件的作用单一，能很好的解决一个问题。就像我们平时在项目中写方法一样，一个方法只做一件事情。

#### 小型

PHP组件代码不多，因为它只为了解决某个问题而生产。

#### 合作

PHP组件之间可以进行良好的合作。PHP的组件之间可以进行合作，以便解决更复杂的问题。而且组件都会放在专属的命名空间中，当我们引入的时候，也不会与其他组件造成冲突。

#### 测试良好

PHP组件因为体型很小，所以测试起来也很方便。

#### 文档完善

PHP组件的文档应该很完善，可以让开发者们快速了解这个组件的安装、使用。

### 获取组件

我们在简单了解了组件之后，应该会知道组件的好处了。那么我们如何快速找到组件呢？依赖百度和google搜索类库吗？不不，我们已经有了一个专门放置组件的网站[Packagist](https://packagist.org/)，这个网站就像一个巨大的**组件仓库**，我们可以在里面搜索任何我们想要的组件，http、dump、route都有，而且这里的组件都是经过开发者们严格测试过的。如果在搜索的时候不知道哪个组件好的话，就去选择那些使用量高、访问较多的吧，因为一般这些基本上都会没有什么大问题。当然不排除还有一些使用量不高但是仍然很优异的组件，这就需要我们去挖掘了。

## Composer

在了解了组件之后，我们来说正题———Composer。如果说Packagist是组件库，那么composer就是PHP组件管理工具了。composer是PHP组件的依赖管理器，它在命令行中使用。通常在你需要使用什么组件的时候，你只需要告诉composer，composer就会自动帮你安装在你的项目中，只需要一个命令，就是这么简单、强势。

## 安装

国内小伙伴在安装composer的时候，可能会遇到很多问题。我在当初安装composer的时候，也走了不少弯路，现在这里推荐一个快速安装composer的方法，打开命令行，执行以下命令：  
在使用这些命令之前，首先确认已经安装了php，并且把php设置在了全局变量中，打开命令行输入`php -v`能够看到php版本信息


```
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"

php composer-setup.php

php -r "unlink('composer-setup.php');"
```

以上三条，请依次输入，作用分别是

1.  下载安装脚本 － composer-setup.php － 到当前目录。
2.  执行安装过程。
3.  删除安装脚本。  
    具体安装过程，请查看[composer中国镜像网站](https://pkg.phpcomposer.com/#how-to-install-composer)的具体描述。

如何全局安装请看：

![composer全局安装](https://www.cxiansheng.cn/usr/uploads/2017/11/886475152.png "composer全局安装")

设置完之后，在命令行输入composer 可以看到composer版本信息。

## 使用

上述中介绍了如何安装composer，本章就来说下composer如何使用。我们先模拟下载一个PHP组件，首先我们在[Packagist](https://packagist.org/)网站搜索dump，我们可以看到一个列表

![8J6WVNX57PG9(4_1{8RGSW6.png](https://www.cxiansheng.cn/usr/uploads/2017/11/363421820.png "8J6WVNX57PG9(4_1{8RGSW6.png")

这个列表里面展示的是查询出来的所有dump组件包了，我们看到第一个`symfony/var-dumper`，composer和组件之间达成了协定，组件名字的第一个信息，以上述为例`symfony`表示厂商名，`var-dumper`表示包名。我们在命令行安装组件的时候，要采用这种形式：


```
// vendor：厂商名 package：包名
composer require vendor/package
```

所以我们安装symfony/var-dumper的时候，命令行输入：


```
composer require symfony/var-dumper
```

composer会自动替我们找到var-dumper的稳定版给我们安装。我们可以看到安装成功提示：

![成功提示](https://www.cxiansheng.cn/usr/uploads/2017/11/3365676691.png "成功提示")

我们打开目录可以看到，在目录下生成了三个文件

![目录](https://www.cxiansheng.cn/usr/uploads/2017/11/2296180336.png "目录")

vendor目录是我们的组件目录，composer.json执行命令的结果文件，composer.lock列出了所有的php组件，以及具体版本号。

现在我们来使用一下这个dump组件，在根目录中新建一个php文件：


```
<?php 

require "vendor/autoload.php"; 

dump(['1','2','3']);

dump(123);
```

首先引入自动加载器，然后使用dump方法来输出变量，dump方法正是我们dump组件包里的一个输出变量的函数，下图是运行文件后看到的结果，输出了不一样的打印样式：

![T77%L{L_[P$I~9SJWS3ML@H.png](https://www.cxiansheng.cn/usr/uploads/2017/11/874379156.png "T77%L{L_[P$I~9SJWS3ML@H.png")

## 发布

上面composer的安装和使用已经介绍完毕，接下来，我们试试看发布一个简单PHP组件。其实很简单，就像自己每天写功能，把一些公用的方法封装起来一样；

### 厂商和包名

在上文的使用中提到过，在我们开发PHP组件之前，我们可以先定义一下自己即将发布的PHP组件的厂商和包名，比如我要开发一个遍历目录下所有文件的组件，那么我可以将我的组件名定义为`mingzhongshui/searchfile`,mingzhonghsui便是我的厂商名，searchfile是包名，这个组件名将是全局唯一的名称，以防和其他组件冲突。另外，我们在选择厂商名之前，可以先在packages中搜索一下，看看有没有一样的。

### 命名空间

每个组件都应有自己的命名空间，这个命名空间并不需要与组件的厂商和包名一致。厂商名和包名只是为了让composer识别组件，而命名空间则是需要在PHP代码中使用组件。

### 组件的目录结构

* **src/** 组件的源码
* **tests/** 组件的测试代码
* **composer.json** composer配置文件，用于描述组件。同时还会告诉composer加载器，把符合PSR-4标准的规范的命名空间对应到scr/目录
* **README.md** 这个markdown文件里可以写组件的开发者以及组件用途、用法等
* **LICENSE** 组件的软件许可证
* **CHANGELOG.md** 版本改动记录

### conposer.json

composer.json文件是PHP组件中必不可少的文件，这个文件里面的内容必须是纯JSON格式，因为composer会根据这个文件中的内容去加载、安装PHP组件，我在这里简单贴一下composer.json的示例内容，这个composer.json文件就是我们刚刚下载dump组件中的：


```
{
    "name": "symfony/var-dumper",
    "type": "library",
    "description": "Symfony mechanism for exploring and dumping PHP variables",
    "keywords": ["dump", "debug"],
    "homepage": "https://symfony.com",
    "license": "MIT",
    "authors": [
        {
            "name": "Nicolas Grekas",
            "email": "p@tchwork.com"
        },
        {
            "name": "Symfony Community",
            "homepage": "https://symfony.com/contributors"
        }
    ],
    "require": {
        "php": "^5.5.9|>=7.0.8",
        "symfony/polyfill-mbstring": "~1.0"
    },
    "require-dev": {
        "ext-iconv": "*",
        "twig/twig": "~1.34|~2.4"
    },
    "conflict": {
        "phpunit/phpunit": "<4.8.35|<5.4.3,>=5.0"
    },
    "suggest": {
        "ext-iconv": "To convert non-UTF-8 strings to UTF-8 (or symfony/polyfill-iconv in case ext-iconv cannot be used).",
        "ext-symfony_debug": ""
    },
    "autoload": {
        "files": [ "Resources/functions/dump.php" ],
        "psr-4": { "Symfony\\Component\\VarDumper\\": "" },
        "exclude-from-classmap": [
            "/Tests/"
        ]
    },
    "minimum-stability": "dev",
    "extra": {
        "branch-alias": {
            "dev-master": "3.3-dev"
        }
    }
}
```

里面根据字面意思应该能理解一部分，我在这里详细解释一番：

* **name** 厂商名和包名
* **description** 这个组件的一些简短描述。这个值也会在packages中显示
* **keywords** 关键字。用于在packages找到这个组件
* **homepage** 组件网站的url
* **license** 软件许可证。我们可以在[https://choosealicense.com/中...](https://choosealicense.com/%E4%B8%AD%E4%BA%86%E8%A7%A3%E5%88%B0%E5%85%B3%E4%BA%8E%E8%AE%B8%E5%8F%AF%E8%AF%81%E7%9A%84%E8%AF%A6%E7%BB%86%E8%AF%B4%E6%98%8E)
* **authors** 表示这个组件的开发人员信息，是一个数组。每个作者信息至少有姓名和网站url
* **require** 这个组件所需的其他PHP组件
* **require-dev** 和require相似，表示开发或者测试时需要用到的PHP组件
* **suggest** 和require相似，表示建议安装的PHP组件，composer默认不会自动安装这里的组件
* **autoload** 表示告诉composer加载器 如何加载这个组件

### 实现组件

以上就是composer.json配置里面常用的参数介绍，接下来，我们就开发完成一个组件。我为了演示，写好了一个组件，在本章一开始就提到的**searchfile**，内容很简单：


```
<?php
namespace Mingzhongshui\File;

/**
 * Query directory file
 */
class SearchFile
{
    /**
     * List Folder Contents
     * @param  path $folderName Folder name
     */
    public function searchAllFile ( $folderName )
    {
        $result = array();
        $handle = opendir($folderName);
        if ( $handle ) {
            while ( ( $file = readdir ( $handle ) ) !== false ) {
                if ( $file != '.' && $file != '..') {
                    $sonPath = $folderName . DIRECTORY_SEPARATOR . $file;
                    if ( is_dir ( $sonPath ) ){
                        $result['dir'][$sonPath] = $this->searchAllFile ( $sonPath );
                    } else {
                        $result['file'][] = $sonPath;
                    }
                }
            }
            closedir($handle);
        }
        return $result;
    }
}
```

一个简单的查询目录所有文件的组件，我已经把它放在了github仓库中————地址是[searchFile](https://github.com/charm-v/searchFile)。

### 发布组件

我们可以通过github仓库的形式提交到packages，首先我们得有一个packagist的账号，可以通过github登陆packagist，登陆之后，在页面右上角会有一个submit提交按钮，输入组件所在的github仓库地址

![submit](https://www.cxiansheng.cn/usr/uploads/2017/11/2987758748.png "submit")

然后点击check，之后点击submit，packagist会自动创建组件页面

![packsearchFile](https://www.cxiansheng.cn/usr/uploads/2017/11/517462596.png "packsearchFile")  
![packsearchFile](https://www.cxiansheng.cn/usr/uploads/2017/11/517462596.png "packsearchFile")

我们可以看到，packagist自动从组件的composer.json中获取到了组件的名称、描述、关键字等信息。至此，我们的组件就发布成功了。

### 使用组件

在命令行输入


```
composer require mingzhongshui/searchfile
```

他会自动帮你安装searchfile组件，如果出现报错可以使用开发版本：


```
composer require mingzhongshui/searchfile:dev-master
```

使用这个的原因是，有时候composer用的是国内的镜像，他还没有同步到源镜像中。

### 设置钩子

当我们把PHP组件发布到packagist之后，如果我们要更新我们已经发布的组件时候该如何做呢？这时候有一个懒办法，设置github钩子使它自动同步更新packagist的组件。  
访问`https://packagist.org/about#how-to-update-packages`，这个地址是设置钩子的说明，我们找到设置钩子的url `https://packagist.org/api/bitbucket?username=mingzhongshui&apiToken=API_TOKEN`，这里的mingzhongshui是我packagist账户名，根据自己的真实情况替换即可；API_TOKEN指的是自己packagist账户中的API TOKEN，在`https://packagist.org/profile/`页面中。

打开自己的github PHP组件主页，在setting中找到Webhooks，添加钩子，保存

![设置github钩子](https://www.cxiansheng.cn/usr/uploads/2017/11/2312210052.png "设置github钩子")

即可。

## 总结

以上就是关于composer安装、使用以及发布的介绍。那么我们有一个问题，我们在实际中如何快速找到**优秀**的PHP组件呢，外国有位[猿友ziadoz](https://github.com/ziadoz)已经整理好了一些优秀的组件，并且列了一个列表，在github的链接为[awesome-php](https://github.com/ziadoz/awesome-php)，有需要什么组件的话，可以来这里看一下，作为参考。好了，以上就是关于composer的周边故事。