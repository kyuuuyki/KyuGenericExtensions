//
//  Duplicatable.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

public protocol Duplicatable: Codable {
    func duplicate() throws -> Self
}

extension Duplicatable {
    public func duplicate() throws -> Self {
        let data = try JSONEncoder().encode(self)
        let copy = try JSONDecoder().decode(Self.self, from: data)
        return copy
    }
}
