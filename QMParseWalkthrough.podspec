#
# Be sure to run `pod lib lint QMParseWalkthrough.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QMParseWalkthrough'
  s.version          = '1.0.0'
  s.summary          = 'UIViewController that show walkthrough images to a user'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This UIViewController uses parse class as a source of images. After user finish a walkthrough callback will be called.
                       DESC

  s.homepage         = 'https://github.com/truebucha/QMParseWalkthrough'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'truebucha' => 'truebucha@gmail.com' }
  s.source           = { :git => 'https://github.com/truebucha/QMParseWalkthrough.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/truebucha'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QMParseWalkthrough/Classes/**/*'
  
  #s.resource_bundles = {
  #   'QMParseWalkthrough' => ['QMParseWalkthrough/Assets/*.png', 'QMParseWalkthrough/Assets/*.xib']
  #}

  s.public_header_files = 'QMParseWalkthrough/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Parse'
  s.dependency 'MYBlurIntroductionView'
  s.dependency 'MBProgressHUD'
  s.dependency 'CDBKit'
  
end
