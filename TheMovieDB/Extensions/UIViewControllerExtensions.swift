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

    func presentNetworkError(error: NetworkError?) {
        var alert = SingleButtonAlert(title: "Unknown Error", message: "please try again later.", action: AlertAction(buttonTitle: "OK", handler: {}))
        guard let error = error else {
            self.presentSingleButtonDialog(alert: alert)
            return
        }
        switch error {
        case .unauthorized:
            alert = SingleButtonAlert(title: "API Error", message: "Your API might be wrong", action: AlertAction(buttonTitle: "OK", handler: {}))
        case .unknown: break
        case .noJSONData:
            alert = SingleButtonAlert(title: "Data Error", message: "Data returned is empty", action: AlertAction(buttonTitle: "OK", handler: {}))
        case .JSONDecoder:
            alert = SingleButtonAlert(title: "Data Error", message: "Data returned is not in the correct format", action: AlertAction(buttonTitle: "OK", handler: {}))
        }
        self.presentSingleButtonDialog(alert: alert)
    }
}
