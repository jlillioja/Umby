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
    var shouldSendFullText: Bool = true
    
    let entry: Entry
    
    init(entry: Entry, shouldSendFullText: Bool, delegate: MFMailComposeViewControllerDelegate) {
        self.entry = entry
        
        super.init(nibName: nil, bundle: nil)
        
        mailComposeDelegate = delegate
        setSubject("A note from a friend")
        if (shouldSendFullText) {
            setMessageBody(formatFullText(), isHTML: false)
        } else {
            setMessageBody(entry.tagString(), isHTML: false)
        }
        
    }
    
    private func formatFullText() -> String {
        return "\(entry.text ?? "")\n\(entry.tagString())"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
