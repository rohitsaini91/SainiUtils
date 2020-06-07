#
# Be sure to run `pod lib lint SainiUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SainiUtils'
    s.version          = '0.2.0'
    s.summary          = 'SainiUtils is used to extend the basic functionality of UIKit elements like UIView,UIButton,UITextfield etc'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    'SainiUtils basic purpose to reduce your development time by extened the basic functionality of UIKit elements'
    DESC
    
    s.homepage         = 'https://github.com/rohitsaini91/SainiUtils'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'rohitsaini91' => 'sketchlearn7@gmail.com' }
    s.source           = { :git => 'https://github.com/rohitsaini91/SainiUtils.git', :tag => s.version.to_s }
    #s.social_media_url = 'https://www.linkedin.com/in/rohit-saini-aba50362'
    
    s.ios.deployment_target = '10.0'
    s.source_files = 'Source/**/*.swift'
    s.swift_version = '5.0'
    
    # s.resource_bundles = {
    #   'SainiUtils' => ['SainiUtils/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
