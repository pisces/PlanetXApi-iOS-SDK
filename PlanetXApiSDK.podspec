#
# Be sure to run `pod lib lint PlanetXApiSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PlanetXApiSDK"
  s.version          = "1.0.0"
  s.summary          = "PlanetX Api SDK."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "PlanetXApiSDK is open source."

  s.homepage         = "https://github.com/pisces/PlanetXApi-iOS-SDK"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "pisces" => "hh963103@gmail.com" }
  s.source           = { :git => "https://github.com/pisces/PlanetXApi-iOS-SDK.git", :tag => s.
  version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.dependency 'PSFoundation'
  s.dependency 'w3action'

  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.source_files = 'PlanetXApiSDK/Classes/*.*'

  # s.public_header_files = 'Pod/Classes/*.*'

  s.dependency 'w3action'

end
