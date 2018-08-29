//
//  FavoriteManager.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import CoreData



class FavoriteManager{
    
    static let shared = FavoriteManager()
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer{
        return AppDelegate.persistentContainer   }
    
    func addFavorite(book:item){
        
        if checkDuplicate(id: book.id){
            return
        }
        
        DispatchQueue.global().async {
            
            let context = self.persistentContainer.newBackgroundContext()
            
            let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)
            
            let bookObject = NSManagedObject(entity: entity!, insertInto: context)
            
            bookObject.setValue( book.id , forKey: "id")
            bookObject.setValue( book.volumeInfo.title , forKey: "title")
            bookObject.setValue( book.volumeInfo.authors.joined(separator: ",") , forKey: "authors")
            bookObject.setValue( book.volumeInfo.description , forKey: "info")
            bookObject.setValue( book.volumeInfo.imageLink.absoluteString , forKey: "imageUrl")
            
            do{
                try context.save()
                print("Favorite Saved")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func removeFavorite(id: String){
        
        let context = self.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
        
        guard let results = (try? context.fetch(request)) as? [NSManagedObject] else {
                return
            }
            for object in results {
                if object.value(forKey: "id") as! String == id{
                context.delete(object)
                do{
                    try context.save()
                    print("Favorite Deleted")
                    return
                    }catch{
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    func getFavorites(completion: @escaping ([item])->Void){
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let context = self.persistentContainer.newBackgroundContext()
            
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
            
            guard let results = (try? context.fetch(request)) as? [NSManagedObject] else {
                return
            }
            
            var items:[item] = []
            
            for element in results {
                var tempItem = item()
                tempItem.id = element.value(forKey: "id") as! String
                tempItem.volumeInfo.title = element.value(forKey: "title") as! String
                tempItem.volumeInfo.aurthorsAsString = element.value(forKey: "authors") as? String
                tempItem.volumeInfo.description = element.value(forKey: "info") as? String
                tempItem.volumeInfo.imageUrlString = element.value(forKey: "imageUrl") as? String
                items.append(tempItem)
            }
            
            for x in items{
                print(x.volumeInfo.title)
            }
            
            completion(items)
        }
    }
    
    func checkDuplicate(id:String)->Bool{
        
        let context = self.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
        
        let descriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        request.sortDescriptors = descriptors
        
        guard let mutableFetchResults = try? context.fetch(request) as? [NSManagedObject] else {
            return false
        }
        
        if let mutableFetchResults = mutableFetchResults {
            let stringArray = mutableFetchResults.compactMap {$0.value(forKey: "id") as? String}
            if stringArray.contains(id) {
                print("duplicates")
                return true
            } else {
                return false
            }
        }
        return false
    }
}
    
    
    


