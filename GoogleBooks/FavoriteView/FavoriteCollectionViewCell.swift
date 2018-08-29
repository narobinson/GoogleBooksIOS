//
//  FavoriteCollectionViewCell.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var id:String = ""
    
    static let identifier = "FavoriteCell"
    
    func configure(with item: item) {
        
        title.text = item.volumeInfo.title
        authors.text = "By: " + item.volumeInfo.aurthorsAsString!
        infoLabel.text = item.volumeInfo.description
        id = item.id
        if let imageUrl = item.volumeInfo.imageUrlString{
            if let url = URL(string: imageUrl){
                image.download(at: url)
            }
        }
        
    }
    
    
}
