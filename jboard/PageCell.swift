//
//  PageCell.swift
//  jboard
//
//  Created by Luis Ezcurdia on 2/7/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class PageBarButtonItem: UIBarButtonItem {
    var page : Int = 0
    
    init(image: UIImage, page: Int) {
        super.init()
        self.image = image
        self.page = page
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class PageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
