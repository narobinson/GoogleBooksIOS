//
//  MainViewModel.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

protocol MainDelegate: class{
    func booksUpdated()
}

class MainViewModel: NSObject{
    
    weak var delegate:MainDelegate?
    
    var items:[item] = []
    
    override init(){
        super.init()
        NetworkService.shared.getBooks(searchTerm: "swift"){ results in
            self.items = results
            self.delegate?.booksUpdated()
        }
    }
    
    func searchBooks(searchString: String){
        NetworkService.shared.getBooks(searchTerm: searchString){ results in
            self.items = results
            self.delegate?.booksUpdated()
        }
    }
}

extension MainViewModel: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.identifier , for: indexPath) as! SearchViewCell
        
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
}




