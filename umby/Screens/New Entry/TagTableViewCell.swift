//
//  TypeTableViewCell.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TagTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TagTableViewCell"
    
    let margin: CGFloat = 10
    let tagText: String
    
    init(_ tag: String) {
        self.tagText = tag
        
        super.init(style: .default, reuseIdentifier: TagTableViewCell.reuseIdentifier)
        
        let text = UILabel().forCustom()
        text.text = tagText
        text.font = UmbyStyle.font
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        addSubview(text)
        [
            text.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            text.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            text.trailingAnchor.constraint(equalTo: accessoryView?.leadingAnchor ?? safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            text.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ].activate()
    }
    
    convenience init(_ tag: Tag?) {
        self.init(tag?.text ?? "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
