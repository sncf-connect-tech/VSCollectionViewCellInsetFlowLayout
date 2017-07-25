Pod::Spec.new do |s|
  s.name             = 'VSCollectionViewCellInsetFlowLayout'
  s.version          = '1.0.4'
  s.summary          = 'Apply margins to UICollectionViewCells'
  s.description      = <<-DESC
Based on the same principle of collectionView(_:layout:insetForSectionAt:), VSCollectionViewCellInsetFlowLayout provides a delegate method to define margins on UICollectionViewCell
                       DESC
  s.homepage         = 'https://github.com/voyages-sncf-technologies/VSCollectionViewCellInsetFlowLayout'
  s.screenshots     = 'https://raw.githubusercontent.com/voyages-sncf-technologies/VSCollectionViewCellInsetFlowLayout/master/assets/screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gwenn Guihal' => 'gguihal@voyages-sncf.com' }
  s.source           = { :git => 'https://github.com/voyages-sncf-technologies/VSCollectionViewCellInsetFlowLayout.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_myrddin_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VSCollectionViewCellInsetFlowLayout/Classes/**/*'

end
