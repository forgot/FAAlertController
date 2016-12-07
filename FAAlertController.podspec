
Pod::Spec.new do |s|

  s.name         = "FAAlertController"
  s.version      = "1.1.1"
  s.summary      = "A drop in UIAlertController replacement, with a few tricks."
  s.homepage     = "https://github.com/forgot/FAAlertController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jesse Cox" => "jesse@apprhythmia.com" }
  s.social_media_url   = "http://twitter.com/forgot"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/forgot/FAAlertController.git", :tag => "#{s.version}" }
  s.source_files  = "Source", "Source/**/*.{swift,h,m}"

end
