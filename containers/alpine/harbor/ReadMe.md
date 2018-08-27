# easypack
##让Linux下没有难装的流行开源软件
##Make popular OSS easily installed in linux

![这里写图片描述](http://img.blog.csdn.net/20160809065608330)

在Easypack中的Alpine容器中，我们将会挑选一些非常流行的工具进行自定义设定以及进行最佳实践的整理，基本思路都是在官方镜像的最新版本之上进行强化。本次为持续集成利器Habor。
#强化之处
* 尺寸较小，base镜像均基于alpine
* 可以自由调整版本，官方镜像的最新版往往滞后一段时间


#Autobuild
与dockerhub结合，自动构建，时刻保证最新版本。每月两次版本调整。

#当前版本
当前版本：1.1.2
vmware官方稳定最新版本：1.1.2



#安装步骤
## 1、Harbor 介绍

> Docker容器应用的开发和运行离不开可靠的镜像管理，虽然Docker官方也提供了公共的镜像仓库，但是从安全和效率等方面考虑，部署我们私有环境内的Registry也是非常必要的。Harbor是由VMware公司开源的企业级的Docker Registry管理项目，它包括权限管理(RBAC)、LDAP、日志审核、管理界面、自我注册、镜像复制和中文支持等功能。

## 2.环境、软件准备

* Docker：version 1.12.6
* Docker-compose： version 1.13.0
* Harbor： version 1.1.2

**注意事项**
  Harbor的所有服务组件都是在Docker中部署的，所以官方安装使用Docker-compose快速部署，所以我们需要安装Docker、Docker-compose。由于Harbor是基于Docker Registry V2版本，所以就要求Docker版本不小于1.10.0，Docker-compose版本不小于1.6.0。

# Harbor 服务搭建

## 1. 下载Harbor安装文件 

从 github harbor 官网 [release](https://github.com/vmware/harbor/releases) 页面下载指定版本的安装包。

```shell
1、在线安装包
    $ wget https://github.com/vmware/harbor/releases/download/v1.1.2/harbor-online-installer-v1.1.2.tgz
    $ tar xvf harbor-online-installer-v1.1.2.tgz
2、离线安装包
    $ wget https://github.com/vmware/harbor/releases/download/v1.1.2/harbor-offline-installer-v1.1.2.tgz
    $ tar xvf harbor-offline-installer-v1.1.2.tgz
```
## 2.配置Harbor 
解压缩之后，目录下回生成harbor.conf文件，该文件就是Harbor的配置文件
在本项目中已经配置好了,可以直接使用！

```harbor.conf
## Configuration file of Harbor

# hostname设置访问地址，可以使用ip、域名，不可以设置为127.0.0.1或localhost
hostname = 10.236.63.76

# 访问协议，默认是http，也可以设置https，如果设置https，则nginx ssl需要设置on
ui_url_protocol = http

# mysql数据库root用户默认密码root123，实际使用时修改下
db_password = root123

max_job_workers = 3 
customize_crt = on
ssl_cert = /data/cert/server.crt
ssl_cert_key = /data/cert/server.key
secretkey_path = /data
admiral_url = NA

# 邮件设置，发送重置密码邮件时使用
email_identity = 
email_server = smtp.mydomain.com
email_server_port = 25
email_username = sample_admin@mydomain.com
email_password = abc
email_from = admin <sample_admin@mydomain.com>
email_ssl = false

# 启动Harbor后，管理员UI登录的密码，默认是Harbor12345
harbor_admin_password = Harbor12345

# 认证方式，这里支持多种认证方式，如LADP、本次存储、数据库认证。默认是db_auth，mysql数据库认证
auth_mode = db_auth

# LDAP认证时配置项
#ldap_url = ldaps://ldap.mydomain.com
#ldap_searchdn = uid=searchuser,ou=people,dc=mydomain,dc=com
#ldap_search_pwd = password
#ldap_basedn = ou=people,dc=mydomain,dc=com
#ldap_filter = (objectClass=person)
#ldap_uid = uid 
#ldap_scope = 3 
#ldap_timeout = 5

# 是否开启自注册
self_registration = on

# Token有效时间，默认30分钟
token_expiration = 30

# 用户创建项目权限控制，默认是everyone（所有人），也可以设置为adminonly（只能管理员）
project_creation_restriction = everyone

verify_remote_cert = on
```

## 启动 Harbor

修改完配置文件后，在的当前目录执行./install.sh，Harbor服务就会根据当期目录下的docker-compose.yml开始下载依赖的镜像，检测并按照顺序依次启动各个服务，Harbor依赖的镜像及启动服务如下：

```


```

启动完成后，我们访问刚设置的hostname即可 http://10.236.63.76/，默认是80端口，如果端口占用，我们可以去修改docker-compose.yml文件中，对应服务的端口映射。

![](https://img-blog.csdn.net/20170621153931923?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYWl4aWFveWFuZzE2OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

4) 登录 Web Harbor 
用户名admin，默认密码（或已修改密码）登录系统。

#CSDN详细
https://blog.csdn.net/aixiaoyang168/article/details/73549898
