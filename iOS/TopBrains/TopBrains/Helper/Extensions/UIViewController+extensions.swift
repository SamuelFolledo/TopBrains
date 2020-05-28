//
//  UIViewController+extensions.swift
//  TopBrains
//
//  Created by Macbook Pro 15 on 1/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SwiftUI

extension UIViewController {
    /// method that instantiate a xib file given a string name using Generic
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    /// method that instantiate a xib file given a string name
    static func instantiate() -> Self {
      return self.init(nibName: String(describing: self), bundle: nil)
    }
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentAlert(title: String, message: String = "") {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
    /// Presents an alert with customizable button title and a completion handler
    /// - Parameters:
    ///   - title: Title for alert
    ///   - message: Message for alert
    ///   - options: Button titles separated by comma
    ///   - completion: Returns which options was tapped
    /// - Reference: https://stackoverflow.com/questions/29633938/swift-displaying-alerts-best-practices
    func presentAlertWithOptions(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if options.count == 0 { //if there is no options, show a basic alert
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                 completion(0)
            })
            alertController.addAction(OKAction)
        } else { //alert with options
            for (index, option) in options.enumerated() {
                var alertStyle = UIAlertAction.Style.default
                switch option { //check if we should style the buttons
                case "Cancel": //cancel style
                    alertStyle = .cancel
                case "Logout", "Discard Changes", "Discard", "Delete", "Remove": //destructive style
                    alertStyle = .destructive
                default: break //keep as default
                }
                alertController.addAction(UIAlertAction(title: option, style: alertStyle, handler: { (action) in
                    completion(index)
                }))
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertWithPassword(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Confirm",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

        self.present(alert, animated: true, completion: nil)
    }

}

///MARK SwiftUI stuffs
