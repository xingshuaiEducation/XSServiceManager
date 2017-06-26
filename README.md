# XSServiceManager
网络请求管理模块

依赖的第三方SDK:< br/>
 AFNetworking< br/>

使用方法：< br/>
1.cocoapod的配置文件 < br/>
  pod 'XSServiceManager', :git => 'https://github.com/xingshuaiEducation/XSServiceManager' < br/>
  < br/>
2.在需要使用的地方引入头文件：< br/>
  #import <XSServiceManager.h>  < br/>
  < br/>
3.使用代码： < br/>
  [XSServiceManager post:请求URL params:参数字典 completion:^(Response *response) {< br/>
        < br/>
    }];< br/>
