//
//  ViewController.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = viewModel
        searchBar.placeholder = "Search Books"
        searchBar.delegate = self
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    

    @IBAction func doubleTapped(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.searchCollectionView.indexPathForItem(at: sender.location(in: self.searchCollectionView)){
            let cell = self.searchCollectionView.cellForItem(at: indexPath) as! SearchViewCell
            FavoriteManager.shared.addFavorite(book: cell.bookData )
    
    }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(){
        searchCollectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController: MainDelegate {
    
    func booksUpdated() {
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width / 2
        let height = UIScreen.main.bounds.size.height / 2.75
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension ViewController: UISearchBarDelegate{


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchBooks(searchString: searchBar.text ?? "news")
        self.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchBooks(searchString: searchBar.text ?? "news")
        self.reloadData()
    }


}

