//
//  UIImage.swift
//  GoogleBooks
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//
import UIKit

private class DataTasks {
    
    static let tasks: [UIImageView: URLSessionDataTask] = [:]
    
    static func run(_ imageView: UIImageView, _ task: URLSessionDataTask){
        DataTasks.tasks[imageView]?.cancel()
        task.resume()
    }
}

extension UIImageView {
    
    func download(at url: URL){
        DataTasks.run(self, URLSession.shared.dataTask(with: url){ data, res, err in
            
            var downloadedImage: UIImage?
            defer { self.setImage(to: downloadedImage) }
            
            // - render image from raw data
            guard let imageData = data else { return }
            downloadedImage = UIImage(data: imageData)
        })
    }
    
    private func setImage(to image: UIImage?){
        DispatchQueue.main.async {
            self.image = image
            self.isHidden = (image == nil)
        }
    }
}
