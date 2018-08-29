//
//  SearchViewCell.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SearchViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    var bookData: item = item()
    
    static let identifier = "searchCell"
    
    
    func configure(with book:item){
        bookData = book
        title.text = book.volumeInfo.title
        author.text = book.volumeInfo.authors.joined(separator: ", ")
        thumbnail.download(at: book.volumeInfo.imageLink)
        
    }
    
    
    
    
    
    
}
