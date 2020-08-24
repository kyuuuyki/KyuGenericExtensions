//
//  +UITableView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 21/10/18.
//

import Foundation
import UIKit

// MARK: - Configure Cells
extension UITableView {
    
    ///Register reusable cells by ClassName.
    public func register<T: UITableViewCell>(_ tableViewCellClass: T.Type) {
        register(UINib(nibName: String(describing: tableViewCellClass), bundle: Bundle(for: tableViewCellClass)), forCellReuseIdentifier: String(describing: tableViewCellClass))
    }
    
    ///Dequeue reusable cells by ClassName.
    public func dequeueReusableCell<T: UITableViewCell>(_ tableViewCellClass: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: tableViewCellClass)) as! T
    }
}

// MARK: - Scrolling
extension UITableView {
    
    ///Scroll to last UITableViewCell.
    public func scrollToBottom() {
        
        let section = numberOfSections - 1
        let row = numberOfRows(inSection: section) - 1
        
        let indexPath = IndexPath(row: row, section: section)
        
        DispatchQueue.main.async {
            
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
