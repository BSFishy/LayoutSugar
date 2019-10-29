#
# Be sure to run `pod lib lint LayoutSugar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LayoutSugar'
  s.version          = '0.1.0'
  s.summary          = 'Layout sugar derived from Material'

  s.homepage         = 'https://github.com/BSFishy/LayoutSugar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matt Provost' => 'mprovost@webcreek.com' }
  s.source           = { :git => 'https://github.com/BSFishy/LayoutSugar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'LayoutSugar/Classes/**/*'
  s.swift_version = '5.0'
end
