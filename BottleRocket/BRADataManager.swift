//
//  BRADataManager.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/25/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class BRADataManager: NSObject {

    static let sharedInstance = BRADataManager()
    var restaurantsArray = [Restaurants]()
    var restaurantCategoryArray = [String]()
    var restaurantImageArray = [String]()
    var restaurantNamesArray = [String]()
    var baseURLString = "sandbox.bottlerocketapps.com"
    
    
    func getDataFromServer(){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        defer{
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        let url = NSURL(string:"http://\(baseURLString)/BR_iOS_CodingExam_2015_Server/restaurants.json")
        
        let urlRequest = NSURLRequest(url: url! as URL,cachePolicy: .reloadIgnoringLocalCacheData,timeoutInterval:30.0)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlRequest as URLRequest){ (data, response,error) ->  Void in
            
            if data != nil {
                print("got data:\(data!.description)")
           
                self.parseRestaurantData(data: data! as NSData)
            
            }else {
                print("No Data")
            }
            
            
        }
        task.resume()
        
    }
    
    enum serializationError:Error{
        case missing(NSData)
        case invalid(String,Any)
    }
    
    
    func parseRestaurantData(data:NSData){
        
        do {
            let jsonResult = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! NSDictionary
                //print("JSON:\(jsonResult)")
            
            
            let restaurant = jsonResult["restaurants"] as! [AnyObject]
           
            for restInfo in restaurant{
            
                let restaurants = Restaurants()

                restaurants.name = restInfo["name"] as! String
                restaurants.backgroundImageURL = restInfo["backgroundImageURL"] as! String
                restaurants.category = restInfo["category"] as! String
                
               print("\(restaurants.name!)")
            
                let contact = restInfo["contact"] as? [String:Any]
                    restaurants.phone = contact?["formattedPhone"] as! String?
                    restaurants.twitter = contact?["twitter"] as! String?
                
                let location = restInfo["location"] as? [String:Any]
                
                    restaurants.address = location?["address"] as! String?
                    restaurants.city = location?["city"] as! String?
                    restaurants.state = location?["state"] as! String?
                    restaurants.postalCode = location?["postalCode"] as! String?
                    restaurants.latitude = location?["lat"] as! Double?
                    restaurants.longitude = location?["lng"] as! Double?
                
                restaurantImageArray.append(restaurants.backgroundImageURL)
                restaurantNamesArray.append(restaurants.name)
                restaurantCategoryArray.append(restaurants.category)
                
                restaurantsArray.append(restaurants)
                print(restaurantsArray.count)
            
            }
           
            
            DispatchQueue.main.async{
                NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "receivedDataFromServer"), object: nil) as Notification)
            }
            
            throw serializationError.missing(data)
            
            
        } catch {
           
            print("Json error\(serializationError.missing(data))")
        }
        
        
    }
    
   
    func numberOfRestaurants() -> Int{
        return restaurantNamesArray.count
    }
    
    
}
