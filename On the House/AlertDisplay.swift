//
//  JustifiedTextAlert.swift
//  memHistoryRefined
//
//  Created by Santosh on 17/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit

struct AlertDisplay {

    //derived from Chase's code snippet. Refactored to return UIAlertController
    func normalAlert(_ message: String) -> UIAlertController {
        let alert = UIAlertController(title: "ON THE HOUSE", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        return alert
    }
    
    func justifiedTextAlert( _ message: String) -> UIAlertController {
        let alert = UIAlertController(title: "ON THE HOUSE", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let paragraphStyling = NSMutableParagraphStyle()
            paragraphStyling.alignment = NSTextAlignment.justified
        
        let justifiedText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyling,
                NSFontAttributeName: UIFont.systemFont(ofSize: 13.0)
              ]
           )
        
           alert.addAction(cancelAction)
           alert.setValue(justifiedText, forKey: "attributedMessage")
        return alert
    }
    
    func centeredTextAlert( _ message: String) -> UIAlertController {
        let alert = UIAlertController(title: "ON THE HOUSE", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let paragraphStyling = NSMutableParagraphStyle()
        paragraphStyling.alignment = NSTextAlignment.center
        
        let justifiedText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyling,
                NSFontAttributeName: UIFont.systemFont(ofSize: 13.0)
            ]
        )
        
        alert.addAction(cancelAction)
        alert.setValue(justifiedText, forKey: "attributedMessage")
        return alert
    }

}
