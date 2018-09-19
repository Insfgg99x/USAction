Pod::Spec.new do |s|

s.name         = "USAction"
s.version      = "1.0"
s.summary      = "类似SpriteKit的SKAction，你可以在UIKit上使用USAction，用法同SpriteKit的"
s.homepage     = "https://github.com/Insfgg99x/USAction"
s.license      = "MIT"
s.authors      = { "CGPointZero" => "newbox0512@yahoo.com" }
s.source       = { :git => "https://github.com/Insfgg99x/USAction.git", :tag => "1.0" }
s.frameworks   = 'Foundation','UIKit'
s.platform     = :ios, '6.0'
s.source_files = 'USAction/*.{h,m}'
s.requires_arc = true
#s.dependency 'SDWebImage

end

