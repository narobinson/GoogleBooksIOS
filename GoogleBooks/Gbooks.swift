
//
//  Gbooks.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation


struct GbooksResponse: Decodable{
    let kind: String?
    let totalItems: Int?
    let items: [item]
}


struct item: Decodable{
    var id:String
    var volumeInfo: Gbook
    
    init (){
        id = ""
        volumeInfo = Gbook()
    }
}

struct Gbook:Decodable{
    var title: String
    var subtitle: String?
    var authors: [String]
    var aurthorsAsString:String?
    var description: String?
    var imageLinks: [String:String]?
    var imageUrlString:String?
    var imageLink:URL {
        var secureImageUrl = imageLinks?["thumbnail"] ?? "http://islandpress.org/sites/default/files/400px%20x%20600px-r01BookNotPictured.jpg"
        secureImageUrl.insert("s", at: (secureImageUrl.index(secureImageUrl.startIndex, offsetBy: 4)) )
        return URL(string: secureImageUrl)!
    }
    
    init(){
        title = ""
        authors = [String]()
        description = ""
        imageLinks = [String:String]()
    }
}


