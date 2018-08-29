//
//  NetworkService.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation


class NetworkService{
    
    let url = "https://www.googleapis.com/books/v1/volumes?q="
    let key = "&key=AIzaSyCFrMTPJkBODQ4oTa7OVyKfmLnED9-_58Q"
    
    
    
    typealias Handler = ([item]) -> Void
    
    private let decoder = JSONDecoder()
    
    static let shared = NetworkService()
    
    func getBooks(searchTerm:String, completion: @escaping Handler){
        
        let urlString = url + searchTerm.lowercased() + key
        
        guard let bookURLs = URL(string: urlString) else {
            print("Bad URL")
            return}
        
        URLSession.shared.dataTask(with: bookURLs){ data, response, error in
            
            guard let serverData = data else {return}
            do {
                let result = try self.decoder.decode(GbooksResponse.self, from: serverData)
                completion(result.items)
            } catch {
                
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
