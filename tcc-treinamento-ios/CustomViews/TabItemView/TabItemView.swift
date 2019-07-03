//
//  TabItemView.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 01/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class TabItemView: UIView {
    let nibName = "TabItemView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var selected: Bool = false {
        didSet {
            let color = selected ? UIColor(named: "primary") : UIColor(named: "secondary")
            label.textColor = color
            imageView.tintColor = color
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func config(label: String, image: UIImage?) {
        self.label.text = label
        
        if let image = image {
            self.imageView.image = image
        }
    }
}
