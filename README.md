# XSServiceManager
网络请求管理模块

依赖的第三方SDK:    
AFNetworking   

使用方法：
1.cocoapod的配置文件 
  pod 'XSServiceManager', :git => 'https://github.com/xingshuaiEducation/XSServiceManager' 
  
2.在需要使用的地方引入头文件：
  #import <XSServiceManager.h>  

3.使用代码： 
  [XSServiceManager post:请求URL params:参数字典 completion:^(Response *response) {

    }];
