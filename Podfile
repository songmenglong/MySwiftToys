# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'
#require_relative "../MyRNToys/node_modules/react-native/scripts/react_native_pods"


source 'https://github.com/CocoaPods/Specs.git'

target 'MySwiftToys' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # RN相关的库
#  app_react_native_pods
  
  # 通用常见的SDK
  


  target 'MySwiftToysTests' do
    inherit! :search_paths
    # Pods for testing
    
    #RN测试相关的库
    #app_test_react_native_pods
        
  end

  target 'MySwiftToysUITests' do
    # Pods for testing
  end
  
end


### ReactNative的相关Pod
def app_react_native_pods
  # 当前RN路径
#  rn_path = '../MyRNToys/node_modules/react-native'
  rn_path = '../../node_modules/react-native'

#  require_relative "#{rn_path}/scripts/react_native_pods"

  
  # Pods for MySwiftToys
  # 'node_modules'目录一般位于根目录中
    # 但是如果你的结构不同，那你就要根据实际路径修改下面的`:path
    pod 'React', :path => "#{rn_path}", :subspecs => [
      'Core',
      'CxxBridge', # Include this for RN >= 0.47
      'DevSupport', # Include this to enable In-App Devmenu if RN >= 0.43
      'RCTText',
      'RCTNetwork',
      'RCTWebSocket', # needed for debugging
      
      # Add any other subspecs you want to use in your project
      'RCTActionSheet',
      'RCTAnimation',
      'RCTGeolocation',
      'RCTImage',
      'RCTLinkingIOS',
      'RCTSettings',
      'RCTVibration',
    ]
    
#    pod 'React', :path => '../MyRNToys/node_modules/react-native'
    # Explicitly include Yoga if you are using RN >= 0.42.0
    pod "yoga", :path => "#{rn_path}/ReactCommon/yoga"
  
    # Third party deps podspec link
    #没有找到这个仓库，暂时屏蔽
#    pod 'DoubleConversion', :podspec => '../MyRNToys/node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
#    pod 'glog', :podspec => "#{rn_path}/third-party-podspecs/glog.podspec"
    pod 'Folly', :podspec => "#{rn_path}/third-party-podspecs/Folly.podspec"
    
    ### 以上为RN的pod目录
  
end


def app_test_react_native_pods
  
  pod 'React', :path => "#{rn_path}", :subspecs => [
    'Core',
    'CxxBridge', # Include this for RN >= 0.47
    'DevSupport', # Include this to enable In-App Devmenu if RN >= 0.43
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # needed for debugging
    
    # Add any other subspecs you want to use in your project
    'RCTActionSheet',
    'RCTAnimation',
    'RCTGeolocation',
    'RCTImage',
    'RCTLinkingIOS',
    'RCTSettings',
    'RCTVibration',
  ]
end



# RN错误兼容处理
post_install do |installer|
   ## Fix for XCode 12.5
    find_and_replace("../node_modules/react-native/React/CxxBridge/RCTCxxBridge.mm",
    "_initializeModules:(NSArray<id<RCTBridgeModule>> *)modules", "_initializeModules:(NSArray<Class> *)modules")
    find_and_replace("../node_modules/react-native/ReactCommon/turbomodule/core/platform/ios/RCTTurboModuleManager.mm",
    "RCTBridgeModuleNameForClass(module)", "RCTBridgeModuleNameForClass(Class(module))")
end

def find_and_replace(dir, findstr, replacestr)
  Dir[dir].each do |name|
      text = File.read(name)
      replace = text.gsub(findstr,replacestr)
      if text != replace
          puts "Fix: " + name
          File.open(name, "w") { |file| file.puts replace }
          STDOUT.flush
      end
  end
  Dir[dir + '*/'].each(&method(:find_and_replace))
end
