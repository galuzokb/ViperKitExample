platform :ios, '10.0'

use_frameworks!

target 'ViperKitExample' do
        inhibit_all_warnings!
    
  pod 'ViperKit', :git => 'https://github.com/galuzokb/ViperKit', :tag => '0.0.9'
  pod 'PromiseKit'
  pod 'ObjectMapper'
  pod 'Alamofire'
  pod 'PKHUD'
  target 'ViperKitExampleTests' do
      inherit! :search_paths
      pod 'KIF'
      pod 'Nimble'
  end
  target 'ViperKitExampleUITests' do
  end
end
