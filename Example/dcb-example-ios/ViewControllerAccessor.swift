//
//  ViewControllerAccessor.swift
//  dcb-example-ios
//
//  Created by Rohit on 26/06/26.
//

import SwiftUI

/// Helper to get the current UIViewController from a SwiftUI view hierarchy.
struct ViewControllerAccessor: UIViewControllerRepresentable {
    var callback: (UIViewController) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        DispatchQueue.main.async {
            if let parent = vc.parent {
                self.callback(parent)
            }
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let parent = uiViewController.parent {
            callback(parent)
        }
    }
}
