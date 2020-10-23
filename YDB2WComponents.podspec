####
##
####
Pod::Spec.new do |spec|
  spec.name         = "YDB2WComponents"
  spec.version      = "1.0.5"
  spec.summary      = "A short description of YDB2WComponents."
  spec.homepage     = "http://EXAMPLE/YDB2WComponents"
  spec.license          = "MIT"
  spec.author           = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDComponents.git", :tag => "#{spec.version}" }
#  spec.source           = { :http => 'file:' + __dir__ + "/" }

  spec.source_files     = "YDB2WComponents/**/*.{h,m,swift,xib}"
  spec.resources        = ["YDB2WComponents/Assets.xcassets"]
  spec.resource_bundles = { "YDB2WComponents" => ["YDB2WComponents/Assets.xcassets/*"] }
  spec.swift_version    = "5.0"

  spec.dependency       "YDExtensions"
end
