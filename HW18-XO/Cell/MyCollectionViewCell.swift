//
//  MyCollectionViewCell.swift
//  HW18-XO
//
//  Created by lion on 19.11.21.
//

protocol MyCollectionViewCellDelegate: AnyObject {
    func addSymbol(symbol: String)
}

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var symbolLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    
    
    
    func addSymbol(symbol: String) {
        symbolLabel.text = symbol
    }

}
