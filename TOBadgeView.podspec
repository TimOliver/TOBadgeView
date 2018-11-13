Pod::Spec.new do |s|
  s.name     = 'TOBadgeView'
  s.version  = '1.0.0'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A view subclass that recreates the standard iOS badge icon'
  s.homepage = 'https://github.com/TimOliver/TOBadgeView'
  s.author   = 'Tim Oliver'
  s.source   = { :git => 'https://github.com/TimOliver/TOBadgeView.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.platform = :ios, '9.0'
  s.source_files = 'TOBadgeView/**/*.{h,m}'
end
