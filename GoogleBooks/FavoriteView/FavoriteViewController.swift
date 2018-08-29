//
//  FavoriteViewController.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoritesCollection: UICollectionView!
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    var items:[item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.favoritesCollection.dataSource = self
        self.favoritesCollection.delegate = self
        self.view.addGestureRecognizer(self.doubleTap)
        self.doubleTap.numberOfTapsRequired = 2


//        FavoriteManager.shared.getFavorites(){
//            items in DispatchQueue.main.async {
//                self.items = items
//                self.favoritesCollection.reloadData()
//            }
//
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        FavoriteManager.shared.getFavorites(){
            items in DispatchQueue.main.async {
                self.items = items
                self.favoritesCollection.reloadData()
            }


        
    }
    }
    @IBAction func doubleTapGeasture(_ sender: UITapGestureRecognizer) {
        
        //stored index path before the alert to ensure it isnt loast
        if let indexPath = self.favoritesCollection.indexPathForItem(at: sender.location(in: self.favoritesCollection)){
            
            //creates alert to confirm removal
            let alert = UIAlertController(title: "Remove", message: "Remove From Favorite", preferredStyle: .alert)
            self.present(alert, animated: true)
            alert.addAction(UIAlertAction(title: "remove", style: .destructive, handler:
                    { action in
                        
                            let cell = self.favoritesCollection.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
                            FavoriteManager.shared.removeFavorite(id: cell.id)
                            self.viewDidAppear(true)
                
                }))
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
    }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
    
}
