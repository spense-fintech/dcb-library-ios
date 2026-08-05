//
//  EnvManager.swift
//
//
//  Created by Rohit on 26/06/26.
//

struct EnvManager {
    static var hostName = "host_url"
    static var whitelistedUrls: Array<String> = []
    static var deviceBindingEnabled = false
    static var navigationBarDisabled = true

    /// Base API path. Decided at `open()` time based on the module's last path segment.
    /// Defaults to "/api" and falls back to it for any non-PAYLESS module.
    static var apiPath = "/api"
}
