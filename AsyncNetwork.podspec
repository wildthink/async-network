Pod::Spec.new do |s|
  s.name               = "AsyncNetwork"
  s.version            = '0.3.1-beta2'
  s.summary            = 'TAsyncNetwork'
  s.homepage           = 'http://jdiehl.github.io/async-network/'
  s.authors            = 'jdiehl'
  s.license            = 'Copyright (c) 2014 CafeX Communications. All rights reserved.'
  s.source             = { :git => 'https://github.com/wildthink/async-network.git' }
  s.source_files       = 'AsyncNetwork/*.{h,m}', "ThirdParty/CocoaAsyncSocket/GCD/*.{h,m}", "ThirdParty/CocoaAsyncSocket/RunLoop/*.{h,m}"
  s.requires_arc       = true
  s.ios.frameworks     = %w{CFNetwork Security}

#  s.xcconfig  =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/*/Frameworks"' }
#  s.xcconfig  =  { 'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/**/*"' }

end

