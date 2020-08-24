//
//  ViewController.swift
//  KyuGenericExtension
//
//  Created by kyuuuyki on 08/24/2018.
//  Copyright (c) 2018 kyuuuyki. All rights reserved.
//

import UIKit
import KyuGenericExtensions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setting Up Defaults
        setDefaultsExample()
        
        //String to Date
        stringToDateExample()
        
        //Date to String
        dateToStringExample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func KGETitlePrint(string : String) {
        
        let maxLength = 50 - string.count
        
        var newString = ""
        
        for _ in 0..<(maxLength / 2) {
            newString += "-"
        }
        newString += ">>> "
        
        newString += string
        
        newString += " <<<"
        for _ in 0..<(maxLength / 2) {
            newString += "-"
        }
        
        if newString.count % 2 != 0 {
            newString += "-"
        }
        
        print("\n\(newString)")
    }
    
    func KGESubtitlePrint(string: String) {
        
        print("\n[\(string)]")
    }
    
    // MARK: Set Defaults
    func setDefaultsExample() {
        print("[Setting Up Defaults]")
        
        Defaults.defaults().calendar = Calendar(identifier: .buddhist)
        Defaults.defaults().locale = Locale(identifier: "th_TH")
        Defaults.defaults().timeZone = TimeZone(abbreviation: "GMT+7") ?? TimeZone(secondsFromGMT: 25200)!
    }
}

