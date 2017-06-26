Pod::Spec.new do |s|
s.name         = "XSServiceManager"
s.version      = "0.0.1"
s.summary      = '网络请求管理者'
s.homepage     = "https://github.com/xingshuaiEducation/XSServiceManager"
s.license      = 'MIT'
s.author       = {'suxx' => '13751882497.com'}
s.source       = { :git => 'https://github.com/xingshuaiEducation/XSServiceManager.git'}
s.platform     = :ios
s.source_files = 'XSServiceManager/**/*.{h,m}'
#s.resources    = 'XSBreakthroughtModule/Resource/*.{png}'
#s.frameworks = "UIKit", "Foundation"
s.dependency = "AFNetworking"
end
