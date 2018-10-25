//
//  ViewController+Date.swift
//  KyuGenericExtension_Example
//
//  Created by Chayanon Ardkham on 24/10/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import Foundation

extension ViewController {
    
    //MARK: Date to String
    func dateToStringExample() {
        KGETitlePrint(string: "DATE TO STRING")
        
        let date = "1969-07-21T02:56:15Z".toDate()!
        
        //Default support ISO8601
        KGESubtitlePrint(string: "Default support ISO8601")
        
        print(date.toString())
        
        //Configurable dateFormats
        KGESubtitlePrint(string: "Configurable dateFormats")
        
        print(date.toString(format: "EEEE d MMMM yyyy"))
    }
}
