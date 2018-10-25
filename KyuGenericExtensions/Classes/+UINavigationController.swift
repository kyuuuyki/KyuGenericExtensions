//
//  +UINavigationController.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/20.
//

import Foundation
import UIKit

//MARK: - Configure Navigation Bar
extension UINavigationController {
    
    ///Configure NavigationBar starting state.
    public func configure(shouldShowNavigationBar: Bool = true) {
        
        if navigationBar.isHidden && shouldShowNavigationBar {
            setNavigationBarHidden(false, animated: true)
        }
        else if !shouldShowNavigationBar {
            setNavigationBarHidden(true, animated: true)
        }
    }
}
