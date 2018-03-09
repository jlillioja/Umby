 //
//  UmbyNewEntryViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyNewEntryViewController: UmbyViewController {
    var newEntryBuilder: NewEntryBuilder?
    var tagProvider: TagProvider?
    
    var bottomConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.accomodateKeyboard(notification:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func accomodateKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.bottomConstraint?.constant = -margin
            } else {
                self.bottomConstraint?.constant = -(endFrame?.size.height ?? 0.0 + margin)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
