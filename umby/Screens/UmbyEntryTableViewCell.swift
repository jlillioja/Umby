//
//  UmbyEntryTableViewCell.swift
//  umby
//
//  Created by Jacob Lillioja on 3/7/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyEntryTableViewCell: UITableViewCell {
    
    let REUSE_IDENTIFIER = "UmbyEntryTableViewCell"
    
    let entry: Entry
    
    let margin: CGFloat = 5.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(entry: Entry) {
        self.entry = entry
        
        super.init(style: .default, reuseIdentifier: REUSE_IDENTIFIER)
        
        layout()
    }
    
    private func layout() {
        backgroundColor = UIColor.clear
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        let dateLabel = UmbyLabel(dateFormatter.string(from: entry.date)).small().leftAligned()
        addSubview(dateLabel)
        addConstraints([
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
        ])
        
        let textLabel = UmbyLabel(entry.text ?? "").small().leftAligned()
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = false
        addSubview(textLabel)
        addConstraints([
            textLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: margin),
            textLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
        ])
        
        let tagsString = entry.tags.map { tag in"#\(tag.text)" }.joined(separator: ", ")
        let tagsLabel = UmbyLabel(tagsString).small().leftAligned()
        addSubview(tagsLabel)
        addConstraints([
            tagsLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            tagsLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            tagsLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            tagsLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin),
        ])
    }

}
