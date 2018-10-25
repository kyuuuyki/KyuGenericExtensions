//
//  Defaults.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation
import UIKit

public class Defaults {
    
    private init() {}
    
    public static let shared = Defaults()
    
    //MARK: - A
    public var application = DefaultsApplication()
    
    //MARK: - C
    public var calendar = Calendar(identifier: .gregorian)
    
    //MARK: - D
    public var dateFormat = DefaultsDateFormat()
    
    //MARK: - L
    public var locale = Locale(identifier: "en_US_POSIX")
    
    //MARK: - T
    public var timeZone = TimeZone(abbreviation: "UTC")!
}
