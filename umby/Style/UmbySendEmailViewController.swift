//
//  UmbySendEmailViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/15/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class UmbySendEmailViewController : MFMailComposeViewController {
    
    var newEntryBuilder: NewEntryBuilder!
    var sendType: ShareType = .FULL
    
    let entry: Entry
    
    init(entry: Entry, shareType: ShareType, delegate: MFMailComposeViewControllerDelegate) {
        self.entry = entry
        
        super.init(nibName: nil, bundle: nil)
        
        mailComposeDelegate = delegate
        setSubject("A note from a friend")
        switch (sendType) {
        case .FULL:
            setMessageBody(formatFullText(), isHTML: false)
        case .TAGS:
            setMessageBody(entry.tagString(), isHTML: false)
        case .TEXT:
            setMessageBody(entry.text ?? "", isHTML: false)
        }
    }
    
    private func formatFullText() -> String {
        return "\(entry.text ?? "")\n\(entry.tagString())"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ShareType {
    case FULL
    case TEXT
    case TAGS
}
