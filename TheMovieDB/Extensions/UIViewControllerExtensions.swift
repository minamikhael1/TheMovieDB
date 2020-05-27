//
//  UIViewControllerExtensions.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentSingleButtonDialog(alert: SingleButtonAlert) {
        DispatchQueue.main.async {[weak self] in
            let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: alert.action.buttonTitle, style: .default, handler: { _ in alert.action.handler?() }))
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
