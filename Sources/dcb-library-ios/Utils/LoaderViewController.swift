//
//  LoaderViewController.swift
//  dcb-library-ios
//
//  Created by Rohit on 26/06/26.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 13.0, *)
class LoaderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let loaderView = UIHostingController(rootView: LoaderView())
        addChild(loaderView)
        view.addSubview(loaderView.view)
        loaderView.didMove(toParent: self)
        loaderView.view.frame = view.bounds
    }
}
