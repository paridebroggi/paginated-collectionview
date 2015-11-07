//
//  Cellule.swift
//  test
//
//  Created by Paride on 06/10/15.
//  Copyright (c) 2015 Paride. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!

    override var selected : Bool {
        didSet {
            
            if self.selected {
                self.backgroundColor = UIColor.greenColor()
            }
            else {
                self.backgroundColor = UIColor.orangeColor()
            }
        }
        
    }
    
}
