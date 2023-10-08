Pod::Spec.new do |s|
  s.name         = "Moya"
  s.version      = "1.0.2"
  s.summary      = "Network abstraction layer written in Swift"
  s.description  = <<-EOS
  Moya abstracts network commands using Swift Generics to provide developers
  with more compile-time confidence.

  Instructions for installation are in [the README](https://github.com/ghostcrying/Moya).
  EOS
  s.homepage     = "https://github.com/ghostcrying/Moya"
  s.author       = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'
  s.source       = { :git => "https://github.com/ghostcrying/Moya.git", :tag => s.version }
  s.default_subspec = "Core"
  s.swift_version = '5.3'
  s.cocoapods_version = '>= 1.4.0'
  
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/Moya/", "Sources/Moya/Plugins/"
    ss.dependency "Alamofire", "~> 5.0"
    ss.framework  = "Foundation"
  end
end
