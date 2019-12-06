# config
platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!
workspace 'Steam'

def common_pods
  pod 'SwiftGen', '6.1.0'
  pod 'Alamofire', '5.0.0-rc.3'
  pod 'RealmSwift', '4.1.1'
  pod 'PinLayout', '1.8.13'
  pod 'AlamofireImage', '4.0.0-beta.6'
  pod 'SnapKit', '4.2.0'
  pod 'Charts', '3.4.0'
end

# Frameworks

target 'Common' do
  project 'Frameworks/Common/Common'
  common_pods
end

target 'Services' do
  project 'Frameworks/Services/Services'
  common_pods
  
  target 'ServicesTests' do
    common_pods
  end
end

target 'Core' do
  project 'Frameworks/Core/Core'
  common_pods

  target 'CoreTests' do
    common_pods
  end
end

# Main App Target

target 'Steam' do
  common_pods
  target 'SteamTests' do
    common_pods
  end
end


# swift versions

swift4 = ['SteamLogin']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if swift4.include?(target.name)
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
