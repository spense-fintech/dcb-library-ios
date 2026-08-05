//
//  File.swift
//  
//
//  Created by Rohit on 26/06/26.
//

struct ServiceNames {
    // Computed at call-time so the dynamic `apiPath` (decided inside `open()`)
    // is always reflected. Do NOT convert these back to stored `let`s.
    private static var HOST_URL: String { "\(EnvManager.hostName)\(EnvManager.apiPath)" }
    private static let USER_SLUG = "/user"
    private static let BANKING_SLUG = "/banking/{bank}"
    private static let GLOBAL_SLUG = "/global"
    private static let DEVICE_SLUG = "/device/{partner}"

    static var LOGIN: String { "\(HOST_URL)\(USER_SLUG)/token" }
    static var LOGGED_IN: String { "\(HOST_URL)\(USER_SLUG)/logged_in" }
    static var BANKING_ACCOUNTS_COUNT: String { "\(HOST_URL)\(BANKING_SLUG)/accounts/count" }
    static var BANKING_CUSTOMER_CHECK: String { "\(HOST_URL)\(BANKING_SLUG)/customer/check" }
    static var BANKING_ONBOARDING_NEXT: String { "\(HOST_URL)\(BANKING_SLUG)/onboarding/next" }
    static var TIME: String { "\(HOST_URL)\(GLOBAL_SLUG)/time" }
    static var DEVICE_BIND: String { "\(HOST_URL)\(DEVICE_SLUG)/bind" }
    static var DEVICE_SESSION: String { "\(HOST_URL)\(DEVICE_SLUG)/session" }
    static var NETWORK_KEYS: String { "\(HOST_URL)/network/keys" }
    static var USER_SESSION: String { "\(HOST_URL)\(USER_SLUG)/session" }
}
