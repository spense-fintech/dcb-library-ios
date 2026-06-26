//
//  File.swift
//  
//
//  Created by Rohit on 26/06/26.
//

extension String {
    func dynamicParams(with values: [String: String]) -> String {
        var result = self
        for (key, value) in values {
            result = result.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return result
    }
}
