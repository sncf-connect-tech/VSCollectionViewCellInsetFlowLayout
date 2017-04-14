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

## Notes

If flowLayout scrollDirection is **vertical**:
  - **inset.top** offsets the item vertically, **inset.bottom** offsets the next item vertically or offsets contentSize if no more cell. All next items and contentSize are also offset vertically by the specified margins.
  - **inset.left** offset the item horizontally and subtracts the value from the cell width, **inset.right** updates the width of the cell without offsets its origin. Others cells and contentSize are **not** impacted by the specified margins.

If flowLayout scrollDirection is **horizontal**:
  - **inset.left** offsets the item horizontally, **inset.right** offsets the next item horizontally or offsets contentSize if no more cell. All next items and contentSize are also offset horizontally by the specified margins.
  - **inset.top** offset the item vertically and subtracts the value from the cell height, **inset.bottom** updates the height of the item without offsets its origin. Others items and contentSize are **not** impacted by the specified margins.

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
