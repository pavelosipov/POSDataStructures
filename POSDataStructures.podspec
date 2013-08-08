Pod::Spec.new do |s|
  s.name     = 'POSDataStructures'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Data Structures Collection. Contains only Binary Heap at that moment.'
  s.homepage = 'https://github.com/pavelosipov/POSDataStructures'
  s.author   = {'Pavel Osipov' => 'https://twitter.com/posipov'}
  s.source   = { :git => 'https://github.com/pavelosipov/POSDataStructures.git' }
  s.platform = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'POSDataStructures/*.{h,m}'
  s.frameworks = 'Foundation'
end
