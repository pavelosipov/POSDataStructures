Pod::Spec.new do |s|
  s.name         = 'POSDataStructures'
  s.version      = '1.1.2'
  s.license      = 'MIT'
  s.summary      = 'Data Structures Collection. Contains only Binary Heap at that moment.'
  s.homepage     = 'https://github.com/pavelosipov/POSDataStructures'
  s.author       = { 'Pavel Osipov' => 'posipov84@gmail.com' }
  s.source       = { :git => 'https://github.com/pavelosipov/POSDataStructures.git', :tag => s.version }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'POSDataStructures/*.{h,m}'
  s.frameworks   = 'Foundation'
end
