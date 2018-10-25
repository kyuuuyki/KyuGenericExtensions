//
//  ViewController+String.swift
//  KyuGenericExtension_Example
//
//  Created by Chayanon Ardkham on 24/10/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import Foundation

extension ViewController {
    
    //MARK: String to Date
    func stringToDateExample() {
        KGETitlePrint(string: "STRING TO DATE")
        
        //Default support ISO8601
        KGESubtitlePrint(string: "Default support ISO8601")
        
        print("19690721T025615Z".toDate()!)
        print("1969-07-21T02:56:15Z".toDate()!)
        print("1969-07-21T02:56:15+0000".toDate()!)
        print("1969-07-21T02:56:15.000Z".toDate()!)
        print("1969-07-21T02:56:15.000+0000".toDate()!)
        
        //Configurable dateFormats
        KGESubtitlePrint(string: "Configurable dateFormats")
        
        print("1969-07-21".toDate(format: "yyyy-MM-dd")!)
    }
}
