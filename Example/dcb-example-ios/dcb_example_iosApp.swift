//
//  dcb_example_iosApp.swift
//  dcb-example-ios
//
//  Created by Rohit on 26/06/26.
//

import SwiftUI
import dcb_library_ios

@main
struct dcb_example_iosApp: App {

    init() {
        PartnerLibrarySingleton.shared.initialize(
            withHostName: EnvManager.hostName,
            deviceBindingEnabled: false,
            whitelistedUrls: ["api.razorpay.com"]
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
