//
//  +Encodable.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

// MARK: - JSON from Encodable
extension Encodable {
    
    ///Get JSON from Encodable object.
    public func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
}
