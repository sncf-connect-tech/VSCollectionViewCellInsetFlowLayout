//
//  ViewController.swift
//  VSCollectionViewCellInsetFlowLayout
//
//  Created by myrddinus on 04/10/2017.
//  Copyright (c) 2017 myrddinus. All rights reserved.
//

import UIKit
import Foundation
import VSCollectionViewCellInsetFlowLayout

final class ViewController: UIViewController {

    let data = [
        (title:"Google", description:"A great search Engine", url:"http://google.com"),
        (title:"Twitter", description:"A social network", url:"http://twitter.com"),
        (title:"CocoaPods", description:"An iOS dependency manager", url:"https://cocoapods.org/"),
    ]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = VSCollectionViewCellInsetFlowLayout()
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimpleCollectionViewCell
        let sectionData = data[indexPath.section]
        
        switch indexPath.item {
        case 0:
            cell.backgroundColor = .aliceBlue
            cell.label.text = sectionData.title
        case 1:
            cell.backgroundColor = .oldLavender
            cell.label.text = sectionData.description
        case 2:
            cell.backgroundColor = .oldLavender
            cell.label.text = sectionData.url
        default:
            break
        }
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: indexPath.item == 0 ? 50 : 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController : VSCollectionViewDelegateCellInsetFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        if indexPath.item == 0 {
            return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        }
        if indexPath.section == 0 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        if indexPath.section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        if indexPath.section == 2 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        return UIEdgeInsets.zero
    }
}

extension UIColor {
    @nonobjc static var aliceBlue:UIColor = UIColor(red: 239/255, green: 248/255, blue: 252/255, alpha: 1)
    @nonobjc static var oldLavender:UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
}

