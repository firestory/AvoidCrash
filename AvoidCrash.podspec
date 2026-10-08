Pod::Spec.new do |s|
s.name         = "AvoidCrash"
s.platform     = :ios
s.version      = "1.0.0"
s.ios.deployment_target = '12.0'
s.summary      = "This framework can avoid Foundation framework potential crash danger"
s.homepage     = "https://github.com/chenfanfang/AvoidCrash"
s.license      = "MIT"
s.author             = { "陈蕃坊" => "493336001@qq.com" }
s.source       = { :git => "https://github.com/firestory/AvoidCrash.git", :tag => s.version }

s.source_files  = 'AvoidCrash/**/*.{h,m}'
s.resource_bundles = {'AvoidCrash' => ['AvoidCrash/PrivacyInfo.xcprivacy']}
s.requires_arc = [
                  'AvoidCrash/AvoidCrash.m',
                  'AvoidCrash/AvoidCrashStubProxy.m',
                  'AvoidCrash/NSObject+AvoidCrash.m',
                  'AvoidCrash/NSArray+AvoidCrash.m',
                  'AvoidCrash/NSDictionary+AvoidCrash.m',
                  'AvoidCrash/NSMutableDictionary+AvoidCrash.m',
                  'AvoidCrash/NSString+AvoidCrash.m',
                  'AvoidCrash/NSMutableString+AvoidCrash.m',
                  'AvoidCrash/NSAttributedString+AvoidCrash.m',
                  'AvoidCrash/NSMutableAttributedString+AvoidCrash.m']


end


