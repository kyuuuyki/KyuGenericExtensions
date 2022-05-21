//
//  +Array.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

// MARK: - Partitioning an Array
extension Array {
    
    ///Safer get Element from index.
    public subscript(safe index: Index) -> Element? {
        return (index >= 0 && index < count) ? self[index] : nil
    }
    
    ///Partitioning an Array.
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
