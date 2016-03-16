# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

use_frameworks!
inhibit_all_warnings!

target 'FunctionalMarvel' do

pod 'Alamofire'
pod 'Argo'
pod 'Curry'
pod 'RxAlamofire'
pod 'RxSwift'
pod 'RxCocoa'
pod 'Runes'
pod 'SDWebImage'
pod 'TSMessages'

end

target 'FunctionalMarvelTests' do

pod 'Alamofire'
pod 'Argo'
pod 'Curry'
pod 'Nimble'
pod 'Quick'
pod 'RxAlamofire'
pod 'RxSwift'
pod 'RxCocoa'
pod 'Runes'
pod 'SDWebImage'

end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
         target.build_configurations.each do |config|
            if config.name == 'Debug'
               config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
         end
      end
   end
end
