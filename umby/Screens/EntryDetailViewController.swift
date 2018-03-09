//
//  EntryDetailViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EntryDetailViewController: UmbyViewController {
    
    let entry: Entry
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ entry: Entry) {
        self.entry = entry
        
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        
        let dateLabel = UmbyLabel(dateFormatter.string(from: entry.date)).leftAligned()
        view.addSubview(dateLabel)
        view.addConstraints([
            dateLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            dateLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            dateLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            ])
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let textLabel = UmbyLabel(entry.text ?? "").leftAligned()
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        view.addConstraints([
            textLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: margin),
            textLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
        ])
        textLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let tagsString = entry.tags.map { tag in"#\(tag)" }.joined(separator: ", ")
        let tagsLabel = UmbyLabel(tagsString).leftAligned()
        view.addSubview(tagsLabel)
        view.addConstraints([
            tagsLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: margin),
            tagsLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            tagsLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            tagsLabel.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -margin),
            ])
        tagsLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        view.layoutIfNeeded()
    }
}
