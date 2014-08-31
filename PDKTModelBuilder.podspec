Pod::Spec.new do |s|
  s.name         = 'PDKTModelBuilder'
  s.version      = '0.1'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/Produkt/PDKTModelBuilder.git'
  s.author       = 'Daniel García' 
  s.summary      = 'Build and populate your models (CoreData or not) in a simple way'
  s.source       = { :git => 'https://github.com/Produkt/PDKTModelBuilder.git', :tag => s.version.to_s }
  s.source_files = 'PDKTModelBuilder/*.{h,m}'
  s.requires_arc = true
  
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'PDKTModelBuilder/*.{h,m}'
    core.exclude_files = 'PDKTModelBuilder/CoreData/*.*'
  end

  s.subspec 'CoreData' do |cd|
    cd.source_files = 'PDKTModelBuilder/CoreData/*.*'
    cd.framework = 'CoreData'
  end
end
