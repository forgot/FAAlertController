workspace 'FAAlertController.xcworkspace'
platform :ios, '10.0'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

project 'FAAlertController.xcodeproj'
project 'FAAlertControllerExample.xcodeproj'

target :FAAlertControllerExample do
    project 'FAAlertControllerExample'
    pod 'Reveal-SDK', :configuration => 'Debug'
    pod 'FAAlertController', :path => '~/Apprhythmia/Libraries/iOS/Swift/FAAlertController'
end
