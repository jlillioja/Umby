//
//  TypeTableViewCell.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TypeTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TypeTableViewCell"
    
    let margin: CGFloat = 10
    
    init(_ label: String) {
        super.init(style: .default, reuseIdentifier: TypeTableViewCell.reuseIdentifier)
        
        let text = UILabel().forCustom()
        text.text = label
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        addSubview(text)
        [
            text.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            text.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            text.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            text.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
