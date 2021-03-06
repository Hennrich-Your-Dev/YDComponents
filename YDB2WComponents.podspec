####
##
####
Pod::Spec.new do |spec|
  spec.name         = "YDB2WComponents"
  spec.version      = "1.4.51"
  spec.summary      = "A short description of YDB2WComponents."
  spec.homepage     = "http://EXAMPLE/YDB2WComponents"
  spec.license          = "MIT"
  spec.author           = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDComponents.git", :tag => "#{spec.version}" }

  spec.source_files     = "YDB2WComponents/**/*.{h,m,swift,xib,storyboard}"
  spec.swift_version    = "5.0"

  spec.dependency "Cosmos"

  spec.dependency "YDExtensions", "~> 1.4.0"
  spec.dependency "YDB2WAssets", "~> 1.4.0"
  spec.dependency "YDUtilities", "~> 1.4.0"
  spec.dependency "YDB2WModels", "~> 1.4.0"
end
