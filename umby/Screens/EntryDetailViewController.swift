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
        
        let textScrollView = UIScrollView().forCustom()
        view.addSubview(textScrollView)
        view.addConstraints([
            textScrollView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: margin),
            textScrollView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            textScrollView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
        ])
        textScrollView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let contentView = UIView().forCustom()
        textScrollView.addSubview(contentView)
        view.addConstraints([
            contentView.topAnchor.constraint(equalTo: textScrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: textScrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: textScrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: textScrollView.bottomAnchor),
        ])
        
        let textLabel = UmbyLabel(entry.text ?? "").leftAligned()
        textLabel.numberOfLines = 0
        contentView.encapsulate(textLabel)
        
        let tagString = entry.tagString()
        let tagsLabel = UmbyLabel(tagString).leftAligned()
        view.addSubview(tagsLabel)
        view.addConstraints([
            tagsLabel.topAnchor.constraint(equalTo: textScrollView.bottomAnchor, constant: margin),
            tagsLabel.leadingAnchor.constraint(equalTo: textScrollView.leadingAnchor),
            tagsLabel.trailingAnchor.constraint(equalTo: textScrollView.trailingAnchor),
            tagsLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
        ])
        tagsLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        view.layoutIfNeeded()
    }
}
