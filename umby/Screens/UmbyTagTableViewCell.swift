//
//  UmbyEntryTableViewCell.swift
//  umby
//
//  Created by Jacob Lillioja on 3/7/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyTagTableViewCell: UITableViewCell {
    
    let REUSE_IDENTIFIER = "UmbyTagTableViewCell"
    
    let entryTag: Tag
    
    let margin: CGFloat = 5.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tag: Tag) {
        self.entryTag = tag
        
        super.init(style: .default, reuseIdentifier: REUSE_IDENTIFIER)
        
        layout()
    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if (selected) {
//            accessoryType = .checkmark
//        } else {
//            accessoryType = .none
//        }
//    }
    
    private func layout() {
        backgroundColor = UIColor.white
        
        let text = UmbyLabel(entryTag.text).small().leftAligned()
        text.textColor = UIColor.black
        addSubview(text)
        addConstraints([
            text.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            text.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            text.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            text.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ])
    }
    
}
