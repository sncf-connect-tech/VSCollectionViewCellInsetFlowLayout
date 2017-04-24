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
    
    fileprivate let defaultMargin:CGFloat = 2
    
    
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
        return 5
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
        case 3,4:
            cell.label.text = "CTA"
            cell.backgroundColor = .appleGreen
        default:
            break
        }
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width =  collectionView.bounds.width - 2 * defaultMargin
        
        switch indexPath.item {
        case 0:
            return CGSize(width: width, height: 50)
        case 3,4:
            return CGSize(width: (width - defaultMargin)/2, height: 40)
        default:
            return CGSize(width: width, height: 40)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return defaultMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: defaultMargin, bottom: 0, right: defaultMargin)
    }
    
}

extension ViewController : VSCollectionViewDelegateCellInsetFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        if indexPath.item == 0 { // header
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
        if indexPath.item == 3 || indexPath.item == 4 { // CTA
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        if indexPath.section == 0 { // section #1
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        if indexPath.section == 1 {// section #2
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        if indexPath.section == 2 {// section #3
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        return UIEdgeInsets.zero
    }
}

extension UIColor {
    @nonobjc static var aliceBlue:UIColor = UIColor(red: 239/255, green: 248/255, blue: 252/255, alpha: 1)
    @nonobjc static var oldLavender:UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    @nonobjc static var appleGreen:UIColor = UIColor(red: 122/255, green: 187/255, blue: 0/255, alpha: 1)
}

