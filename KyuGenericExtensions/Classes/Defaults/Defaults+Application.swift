//
//  Defaults+Application.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 21/10/18.
//

import Foundation

public class DefaultsApplication {
    
    public init(){}
    
    public let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    public let build: String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
}
