
  # pod spec lint FAAlertController.podspec

Pod::Spec.new do |s|

  s.name         = "FAAlertController"
  s.version      = "1.0.0"
  s.summary      = "A drop in UIAlertController replacement, with a few tricks."
  s.homepage     = "https://github.com/forgot/FAAlertController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jesse Cox" => "jesse@apprhythmia.com" }
  s.social_media_url   = "http://twitter.com/forgot"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/forgot/FAAlertController.git", :tag => "#{s.version}" }
  s.source_files  = "Source", "Source/**/*.{swift,h,m}"

end
