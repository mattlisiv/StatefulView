Pod::Spec.new do |s|

  # 1
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "StatefulView"
  s.summary = "StatefulView is an overlay UIView designed for managing states for UICollectionView."
  s.requires_arc = true

  # 2
  s.version = "0.1.0"

  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }

  # 4 - Replace with your name and e-mail address
  s.author = { "Matt Lisivick" => "lisivickmatt@gmail.com" }

  # 5 - Replace this URL with your own Github page's URL (from the address bar)
  s.homepage = "https://github.com/mattlisiv/StatefulView"

  # For example,
  # s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


  # 6 - Replace this URL with your own Git URL from "Quick Setup"
  s.source = { :git => "https://github.com/mattlisiv/StatefulView", :tag => "#{s.version}"}

  # For example,
  # s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


  # 7
  s.framework = "UIKit"
  # 8
  s.source_files = "StatefulView/**/*.{swift}"

  # 9
  s.resources = "StatefulView/**/*.{png,jpeg,jpg,storyboard,xib}"
end
