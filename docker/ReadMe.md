# 安装步骤

## 快速安装

下载

```

# 下载安装脚本
wget https://raw.githubusercontent.com/caozhilong/easypack/master/docker/easypack_docker.sh

# 授权
chmod 777 easypack_docker.sh

# 执行安装
 ./easypack_docker.sh

```

安装docker-compose

```
sudo pip install -U docker-compose

curl -L https://raw.githubusercontent.com/docker/compose/1.8.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
```




# Ubuntu下Docker CE的安装

本文用于记录Ubuntu 17.10下Docker CE的安装。

# 安装依赖

关于Docker CE版本在Ubuntu下安装有如下限制

## 64位的OS

需要Ubuntu64bit的OS, 确认方法如下

```hljs
devops@ubuntu:~$ uname -m
x86_64
devops@ubuntu:~$
```


## 版本

支持如下Ubuntu的版本

1.  Artful 17.10 
2.  Xenial 16.04 (LTS)
3.  Trusty 14.04 (LTS)

注意：其中Artful 17.10只支持Docker CE17.11 Edge以及以后版本，因为Artful本身也是在2017年10月发行的过渡版本

发行代码的确认方式，比如Artful

```hljs
devops@ubuntu:~$ lsb_release -cs
artful
devops@ubuntu:~$
```


## 硬件

Ubuntu对Docker CE的支持除了需要是64位的OS之外，x86的CPU也是需要的。除了x86之外，还有如下的支持类型

* armhf
* s390x（IBM Z）
* ppc64le （IBM Power）

```hljs
devops@ubuntu:~$ uname -m
x86_64
devops@ubuntu:~$
```

# 安装

## apt-get update

使用apt-get update更新源中的软件列表

```hljs
devops@ubuntu:~$ sudo su
[sudo] password for devops: 
root@ubuntu:/home/devops# apt-get update
Hit:1 http://cn.archive.ubuntu.com/ubuntu artful InRelease                  
Get:2 http://cn.archive.ubuntu.com/ubuntu artful-updates InRelease [78.6 kB]                          
Hit:3 http://cn.archive.ubuntu.com/ubuntu artful-backports InRelease                    
Get:4 http://security.ubuntu.com/ubuntu artful-security InRelease [78.6 kB]
Get:5 http://cn.archive.ubuntu.com/ubuntu artful-updates/main i386 Packages [212 kB]
Get:6 http://cn.archive.ubuntu.com/ubuntu artful-updates/main amd64 Packages [216 kB]
Get:7 http://cn.archive.ubuntu.com/ubuntu artful-updates/universe i386 Packages [89.0 kB]
Get:8 http://cn.archive.ubuntu.com/ubuntu artful-updates/universe amd64 Packages [89.9 kB]
Fetched 764 kB in 4s (163 kB/s)                                                        
Reading package lists... Done
root@ubuntu:/home/devops#
```


## 安装所需的package

> 命令：apt-get install apt-transport-https ca-certificates curl software-properties-common

执行日志

```hljs
root@ubuntu:/home/devops# apt-get install apt-transport-https ca-certificates curl software-properties-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ca-certificates is already the newest version (20170717).
software-properties-common is already the newest version (0.96.24.17).
The following additional packages will be installed:
  libcurl3
The following NEW packages will be installed:
  apt-transport-https
The following packages will be upgraded:
  curl libcurl3
2 upgraded, 1 newly installed, 0 to remove and 53 not upgraded.
Need to get 383 kB of archives.
After this operation, 247 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://cn.archive.ubuntu.com/ubuntu artful-updates/main amd64 apt-transport-https amd64 1.5.1 [34.7 kB]
Get:2 http://cn.archive.ubuntu.com/ubuntu artful-updates/main amd64 curl amd64 7.55.1-1ubuntu2.3 [152 kB]                              
Get:3 http://cn.archive.ubuntu.com/ubuntu artful-updates/main amd64 libcurl3 amd64 7.55.1-1ubuntu2.3 [196 kB]                          
Fetched 383 kB in 14s (26.2 kB/s)                                                                                                      
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = "en_HK:en",
    LC_ALL = (unset),
    LC_CTYPE = "UTF-8",
    LANG = "en_HK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_HK.UTF-8").
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
Selecting previously unselected package apt-transport-https.
(Reading database ... 63866 files and directories currently installed.)
Preparing to unpack .../apt-transport-https_1.5.1_amd64.deb ...
Unpacking apt-transport-https (1.5.1) ...
Preparing to unpack .../curl_7.55.1-1ubuntu2.3_amd64.deb ...
Unpacking curl (7.55.1-1ubuntu2.3) over (7.55.1-1ubuntu2.2) ...
Preparing to unpack .../libcurl3_7.55.1-1ubuntu2.3_amd64.deb ...
Unpacking libcurl3:amd64 (7.55.1-1ubuntu2.3) over (7.55.1-1ubuntu2.2) ...
Setting up apt-transport-https (1.5.1) ...
Setting up libcurl3:amd64 (7.55.1-1ubuntu2.3) ...
Processing triggers for libc-bin (2.26-0ubuntu2) ...
Processing triggers for man-db (2.7.6.1-2) ...
Setting up curl (7.55.1-1ubuntu2.3) ...
root@ubuntu:/home/devops#
```

# 添加GPG key

使用如下命令添加docker官方的GPG key，

> 命令：curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

执行日志

```hljs
root@ubuntu:/home/devops# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
OK
root@ubuntu:/home/devops#
```


此key的数字签名为9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88，所以可以用其最后8位进行确认

```hljs
root@ubuntu:/home/devops# apt-key fingerprint 0EBFCD88
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]

root@ubuntu:/home/devops#
```


# 设定stable源仓库

使用如下命令设定x86安装类型的stable源仓库

> 命令：add-apt-repository “deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable”

如果是其他类型的化，对应关系参看如下，将上述命令中的arch=amd64进行替换即可

类型                  | 设定值    
------------------- | -------
x86                 | amd64  
armhf               | armhf  
s390x（IBM Z）        | s390x  
ppc64le （IBM Power） | ppc64el

执行日志：

```hljs
root@ubuntu:/home/devops# add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
root@ubuntu:/home/devops#
```

# apt-get update

再次使用apt-get update更新源中的软件列表

```hljs
root@ubuntu:/home/devops# apt-get update
Hit:1 http://cn.archive.ubuntu.com/ubuntu artful InRelease                        
Get:2 http://security.ubuntu.com/ubuntu artful-security InRelease [78.6 kB]       
Get:3 http://cn.archive.ubuntu.com/ubuntu artful-updates InRelease [78.6 kB]                                            
Hit:4 http://cn.archive.ubuntu.com/ubuntu artful-backports InRelease                                                                   
Get:5 https://download.docker.com/linux/ubuntu artful InRelease [51.9 kB]
Get:6 https://download.docker.com/linux/ubuntu artful/stable amd64 Packages [1462 B]
Fetched 211 kB in 2s (85.8 kB/s)
Reading package lists... Done
root@ubuntu:/home/devops#
```


# 安装docker-ce

```
root@ubuntu:/home/devops# apt-get install docker-ce
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  aufs-tools cgroupfs-mount libltdl7
The following NEW packages will be installed:
  aufs-tools cgroupfs-mount docker-ce libltdl7
0 upgraded, 4 newly installed, 0 to remove and 53 not upgraded.
Need to get 29.9 MB of archives.
After this operation, 150 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://cn.archive.ubuntu.com/ubuntu artful-updates/universe amd64 aufs-tools amd64 1:4.1+20161219-1ubuntu0.1 [102 kB]
Get:2 https://download.docker.com/linux/ubuntu artful/stable amd64 docker-ce amd64 17.12.1~ce-0~ubuntu [29.8 MB]
Get:3 http://cn.archive.ubuntu.com/ubuntu artful/universe amd64 cgroupfs-mount all 1.4 [6320 B]
Get:4 http://cn.archive.ubuntu.com/ubuntu artful/main amd64 libltdl7 amd64 2.4.6-2 [38.8 kB]
Fetched 29.9 MB in 8s (3536 kB/s)                                                                                                      
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = "en_HK:en",
    LC_ALL = (unset),
    LC_CTYPE = "UTF-8",
    LANG = "en_HK.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_HK.UTF-8").
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
Selecting previously unselected package aufs-tools.
(Reading database ... 63874 files and directories currently installed.)
Preparing to unpack .../aufs-tools_1%3a4.1+20161219-1ubuntu0.1_amd64.deb ...
Unpacking aufs-tools (1:4.1+20161219-1ubuntu0.1) ...
Selecting previously unselected package cgroupfs-mount.
Preparing to unpack .../cgroupfs-mount_1.4_all.deb ...
Unpacking cgroupfs-mount (1.4) ...
Selecting previously unselected package libltdl7:amd64.
Preparing to unpack .../libltdl7_2.4.6-2_amd64.deb ...
Unpacking libltdl7:amd64 (2.4.6-2) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../docker-ce_17.12.1~ce-0~ubuntu_amd64.deb ...
Unpacking docker-ce (17.12.1~ce-0~ubuntu) ...
Setting up aufs-tools (1:4.1+20161219-1ubuntu0.1) ...
Processing triggers for ureadahead (0.100.0-20) ...
Setting up cgroupfs-mount (1.4) ...
Processing triggers for libc-bin (2.26-0ubuntu2) ...
Processing triggers for systemd (234-2ubuntu12.1) ...
Setting up libltdl7:amd64 (2.4.6-2) ...
Processing triggers for man-db (2.7.6.1-2) ...
Setting up docker-ce (17.12.1~ce-0~ubuntu) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.
Processing triggers for ureadahead (0.100.0-20) ...
Processing triggers for libc-bin (2.26-0ubuntu2) ...
Processing triggers for systemd (234-2ubuntu12.1) ...
root@ubuntu:/home/devops#
```

## 指定版本安装

如果希望指定版本方式安装，则在安装时需要指定docker-ce=17.12.1~ce-0~ubuntu版本方式即可

```
root@ubuntu:/home/devops# apt-cache madison docker-ce
 docker-ce | 17.12.1~ce-0~ubuntu | https://download.docker.com/linux/ubuntu artful/stable amd64 Packages
 docker-ce | 17.12.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu artful/stable amd64 Packages
root@ubuntu:/home/devops#
root@ubuntu:/home/devops# apt-get install docker-ce=17.12.1~ce-0~ubuntu
Reading package lists... Done
Building dependency tree       
Reading state information... Done
docker-ce is already the newest version (17.12.1~ce-0~ubuntu).
0 upgraded, 0 newly installed, 0 to remove and 53 not upgraded.
root@ubuntu:/home/devops#
```

# 安装后确认

## 版本确认

```
root@ubuntu:/home/devops# docker version
Client:
 Version:   17.12.1-ce
 API version:   1.35
 Go version:    go1.9.4
 Git commit:    7390fc6
 Built: Tue Feb 27 22:17:53 2018
 OS/Arch:   linux/amd64

Server:
 Engine:
  Version:  17.12.1-ce
  API version:  1.35 (minimum version 1.12)
  Go version:   go1.9.4
  Git commit:   7390fc6
  Built:    Tue Feb 27 22:16:25 2018
  OS/Arch:  linux/amd64
  Experimental: false
root@ubuntu:/home/devops#
```


## 整体信息

可以看出很多基本信息，比如存储方式为overlay2

```
root@ubuntu:/home/devops# docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 17.12.1-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 9b55aab90508bd389d7654c4baf173a981477d55
runc version: 9f9c96235cc97674e935002fc3d78361b696a69e
init version: 949e6fa
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.13.0-21-generic
Operating System: Ubuntu 17.10
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 988.7MiB
Name: ubuntu
ID: TYYA:4LWB:YTHA:2DNB:XBXM:NFNP:ADMY:VZEJ:2ZBN:KPKW:PTML:S5A2
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false

WARNING: No swap limit support
root@ubuntu:/home/devops#
```


# 参考文献

https://docs.docker.com/install/linux/docker-ce/ubuntu/
