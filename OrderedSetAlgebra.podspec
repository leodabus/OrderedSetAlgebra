#
# Be sure to run `pod lib lint OrderedSetAlgebra.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OrderedSetAlgebra'
  s.version          = '1.0'
  s.summary          = 'An OrderedSet Swift implementation  .'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
 An OrderedSet Swift implementation that conforms to RandomAccessCollection and SetAlgebra (unique ordered elements).
                       DESC

  s.homepage         = 'https://github.com/leodabus/OrderedSetAlgebra'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leonardo Dabus' => 'leodabus@gmail.com' }
  s.source           = { :git => 'https://github.com/leodabus/OrderedSetAlgebra.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'OrderedSetAlgebra/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'OrderedSetAlgebra' => ['OrderedSetAlgebra/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
