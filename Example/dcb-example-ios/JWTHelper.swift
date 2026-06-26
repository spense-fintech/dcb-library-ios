//
//  JWTHelper.swift
//  dcb-example-ios
//
//  Created by Rohit on 26/06/26.
//

import Foundation
import CommonCrypto

struct JWTHelper {

    /// Generates a signed JWT token (HS256) matching the Flutter logic:
    /// Header: { "kid": clientId, "typ": "JWT", "alg": "HS256" }
    /// Payload: { "attributes": {...}, "module": "...", "prospect_id": "...", "device_binded": true, "exp": ... }
    static func generateToken(prospectId: String) -> String {
        let header: [String: Any] = [
            "kid": EnvManager.clientId,
            "typ": "JWT",
            "alg": "HS256"
        ]

        let now = Date()
        let expiration = now.addingTimeInterval(300) // 300 seconds = 300000 ms

        let attributes: [String: Any] = [
            "name": "",
            "photo": "",
            "partner_user_id": "1234"
        ]

        let payload: [String: Any] = [
            "attributes": attributes,
            "module": EnvManager.module,
            "prospect_id": prospectId,
            "device_binded": true,
            "iat": Int(now.timeIntervalSince1970),
            "exp": Int(expiration.timeIntervalSince1970)
        ]

        let headerData = try! JSONSerialization.data(withJSONObject: header, options: [.sortedKeys])
        let payloadData = try! JSONSerialization.data(withJSONObject: payload, options: [.sortedKeys])

        let headerBase64 = base64UrlEncode(headerData)
        let payloadBase64 = base64UrlEncode(payloadData)

        let signingInput = "\(headerBase64).\(payloadBase64)"
        let signature = hmacSHA256(signingInput, secret: EnvManager.clientSecret)

        return "\(signingInput).\(signature)"
    }

    private static func base64UrlEncode(_ data: Data) -> String {
        return data.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }

    private static func hmacSHA256(_ input: String, secret: String) -> String {
        let key = secret.data(using: .utf8)!
        let data = input.data(using: .utf8)!

        var hmac = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes { dataBytes in
            key.withUnsafeBytes { keyBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256),
                        keyBytes.baseAddress, key.count,
                        dataBytes.baseAddress, data.count,
                        &hmac)
            }
        }

        let hmacData = Data(hmac)
        return base64UrlEncode(hmacData)
    }
}
