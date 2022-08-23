#
# Be sure to run `pod lib lint dredfort2022.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'dredfort2022'
  s.version          = '0.5.0'
  s.summary          = '42 Piscine iOS Swift - Day 08 pod dredfort2022.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  42 Piscine iOS Swift - Day 08 pod dredfort2022 is a part of article manager
  DESC

  s.homepage         = 'https://github.com/dredfort42'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dredfort42' => 'dredfort.42@gmail.com' }
  s.source           = { :git => 'https://github.com/dredfort42/dredfort2022.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

	s.swift_version = '4.0'
  s.ios.deployment_target = '15.0'

  s.source_files = 'dredfort2022/Classes/**/*'
  
  # s.resource_bundles = {
  #   'dredfort2022' => ['dredfort2022/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'Foundation', 'UIKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
