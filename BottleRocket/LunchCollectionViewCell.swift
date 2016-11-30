//
//  LunchCollectionViewCell.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/28/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//
import Foundation
import UIKit

let imageCache = NSCache<AnyObject,AnyObject>()


class LunchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    
   // Setting imageView and image cache
    
    func setCollectionViewCell(Image:String?,Name:String,Category:String){
       
        if let backgroundImageURL = Image {
            
            if let image = imageCache.object(forKey: backgroundImageURL as AnyObject) as? UIImage {
                restaurantImageView.image = image
                
            }else {
                URLSession.shared.dataTask(with: NSURL(string: backgroundImageURL)! as URL, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                      let image = UIImage(data: data!)
                          imageCache.setObject(image!, forKey: backgroundImageURL as AnyObject)
                    
                       DispatchQueue.main.async(execute: { () -> Void in
                       self.restaurantImageView.image = image
                    })
                    
                }).resume()
                
            }
        }

        self.displayMoreRestaurantDetails(restaurantName:Name,restaurantCategory:Category)
    }
    
    
   // Setting display texts - Restaurant Name and Category
    
    func displayMoreRestaurantDetails(restaurantName:String,restaurantCategory:String){
        restaurantNameLabel.text = restaurantName
        restaurantCategoryLabel.text = restaurantCategory
    }
    
    
}
