#
#  Be sure to run `pod spec lint WGToolsChangeView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "WGToolsChangeView"
  spec.version      = "0.0.1"
  spec.summary      = "切换按钮视图"
  spec.description  = <<-DESC
                   DESC
  spec.homepage     = "https://github.com/superWangDG/SwiftToolsChangeViewDome.git"
  spec.license      = "MIT (example)"
  spec.author             = { "superWangDG" => "353603104@qq.com" }
  spec.source       = { :git => "https://github.com/superWangDG/SwiftToolsChangeViewDome.git", :tag => "#{spec.version}" }

  spec.swift_version = '>4.0'
  spec.platform = :ios

  spec.source_files  = "WGToolsChangeView", "WGToolsChangeView/**/*.{h,m}"
  spec.exclude_files = "WGToolsChangeView/Exclude"

 
end
