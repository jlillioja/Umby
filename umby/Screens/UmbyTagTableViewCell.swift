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
    
    static let REUSE_IDENTIFIER = "UmbyTagTableViewCell"
    
    var entryTag: Tag
    var isActive: Bool {
        get {
            return accessoryType == .checkmark
        }
        set {
            if (newValue) {
                accessoryType = .checkmark
            } else {
                accessoryType = .none
            }
        }
    }
    
    let margin: CGFloat = 5.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tag: Tag, isActive: Bool = false) {
        self.entryTag = tag
        
        super.init(style: .default, reuseIdentifier: UmbyTagTableViewCell.REUSE_IDENTIFIER)
        
        self.isActive = isActive
        
        layout()
        configure()
    }
    
    func configure(tag: Tag? = nil, isActive: Bool? = nil) {
        self.entryTag = tag ?? self.entryTag
        self.isActive = isActive ?? self.isActive
        
        tagLabel.text = entryTag.text
//        if (self.isActive) {
//            accessoryType = .checkmark
//        } else {
//            accessoryType = .none
//        }
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
    private var tagLabel: UmbyLabel! = nil
    private func layout() {
        backgroundColor = UIColor.white
        
        tagLabel = UmbyLabel().small().leftAligned()
        tagLabel.textColor = UIColor.black
        addSubview(tagLabel)
        addConstraints([
            tagLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            tagLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            tagLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            tagLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
            ])
    }
    
}
