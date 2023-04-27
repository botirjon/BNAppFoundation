Pod::Spec.new do |s|
  s.name             = 'BNAppFoundation'
  s.version          = '1.5.0'
  s.summary          = 'A cross app util methods.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A cross app util methods.
                       DESC

  s.homepage         = 'https://github.com/botirjon/BNAppFoundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'botirjon' => 'botirjon.nasridinov@gmail.com' }
  s.source           = { :git => 'https://github.com/botirjon/BNAppFoundation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'

  s.source_files = 'Sources/BNAppFoundation/**/*'
  
  # s.resource_bundles = {
  #   'BNAppFoundation' => ['BNAppFoundation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
