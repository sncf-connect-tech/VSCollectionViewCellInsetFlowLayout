# VSCollectionViewCellInsetFlowLayout

VSCollectionViewCellInsetFlowLayout, based on UICollectionViewFlowLayout, enables to add margins on cells

<p align="center" >
  <img src="https://raw.githubusercontent.com/voyages-sncf-technologies/VSCollectionViewCellInsetFlowLayout/master/assets/screenshot.png" alt="VSCollectionViewCellInsetFlowLayout" title="VSCollectionViewCellInsetFlowLayout">
</p>

## Get Started

Based on the same principle of ```collectionView(_:layout:insetForSectionAt:)```, VSCollectionViewCellInsetFlowLayout provides a delegate method to define margins on ```UICollectionViewCell```

### Setup

Instanciate a VSCollectionViewCellInsetFlowLayout then set it as the layout of the collectionView:
```swift
collectionView.collectionViewLayout = VSCollectionViewCellInsetFlowLayout()
```

VSCollectionViewCellInsetFlowLayout is using the collectionview delegate if this one conforms to ```VSCollectionViewDelegateCellInsetFlowLayout```.
Implement ```collectionView(_:layout:insetForItemAt:)```:
```swift
extension ViewController : VSCollectionViewDelegateCellInsetFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        if indexPath.item == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
        return UIEdgeInsets.zero
    }
}
```

Et voilà !

## Installation

### Installation with CocoaPods

Copy and paste the following lines to your PodFile file:  
    
    source 'https://github.com/CocoaPods/Specs.git'
    pod 'VSCollectionViewCellInsetFlowLayout'

### Manual installation

- [Download](https://github.com/voyages-sncf-technologies/VSCollectionViewCellInsetFlowLayout/releases) the last release of VSCollectionViewCellInsetFlowLayout.
- Import the folder *VSCollectionViewCellInsetFlowLayout* into your project.

### Sample

You may download the project to have a look at the integrated sample.


## Credits

VSCollectionViewCellInsetFlowLayout is owned and maintained by [Voyages-sncf.com](http://www.voyages-sncf.com/).

VSCollectionViewCellInsetFlowLayout was originally created by [Gwenn Guihal](https://github.com/myrddinus).


## License

VSCollectionViewCellInsetFlowLayout is released under the MIT license.
