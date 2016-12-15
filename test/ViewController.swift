//
//  ViewController.swift
//  test
//
//  Created by Paride on 06/10/15.
//  Copyright (c) 2015 Paride. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var scrollViewWidthContraint: NSLayoutConstraint!
  
  let verticalInset = CGFloat(10)
  let spaceBetweenCells = CGFloat(10)
  var horizontalInset = CGFloat()
  var data = [String]()
  var cellWidth = CGFloat()
  
  override func viewDidLoad() {
    self.prepareCollectionView()
    self.containerView.addGestureRecognizer(self.scrollView.panGestureRecognizer)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.prepareScrollView()
  }
  
//  override func
}

//MARK: - PREPARING SUBVIEWS
extension ViewController {
  
  func prepareCollectionView() {
    for index in 0...10 {
      self.data.append(String(index))
    }
    self.collectionView.reloadData()
  }
  
  func prepareScrollView() {
    self.scrollViewWidthContraint.constant = self.cellWidth + spaceBetweenCells
    self.scrollView.contentSize.width = (self.cellWidth + self.spaceBetweenCells) * CGFloat(self.data.count)
  }
}

//MARK: - COLLECTION VIEW DATA SOURCE
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "Cell", forIndexPath: indexPath) as! CollectionViewCell
    cell.cellLabel.text = data[indexPath.item]
    return cell
  }
}

//MARK: - CUSTOMIZING COLLECTION VIEW FLOW LAYOUT
extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return self.spaceBetweenCells
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    self.cellWidth = self.collectionView.frame.height - (layout.sectionInset.top + layout.sectionInset.top)
    self.horizontalInset = (self.collectionView.frame.width - self.cellWidth) / 2
    return CGSize(width: self.cellWidth, height: self.cellWidth)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    return UIEdgeInsets(top: layout.sectionInset.top, left: self.horizontalInset, bottom: layout.sectionInset.top, right: self.horizontalInset)
  }
}

//MARK: - CUSTOMIZING SCROLL VIEW
extension ViewController {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.collectionView.contentOffset.x = scrollView.contentOffset.x
  }
  
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    if let selected = self.collectionView.indexPathForItemAtPoint(CGPoint(x: targetContentOffset.memory.x + self.collectionView.frame.width / 2, y: self.collectionView.frame.height / 2)) {
      self.collectionView.selectItemAtIndexPath(NSIndexPath(forItem: selected.item, inSection: 0), animated: false, scrollPosition: .None)
    }
  }
}
