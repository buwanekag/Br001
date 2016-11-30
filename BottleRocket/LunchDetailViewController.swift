//
//  LunchDetailViewController.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/28/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MapKit

class LunchDetailViewController: UIViewController {
    
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantCrossStreetLabel: UILabel!
    @IBOutlet weak var restaurantStateLabel: UILabel!
    @IBOutlet weak var restaurantPhoneLabel: UILabel!
    @IBOutlet weak var restaurantTwitterLabel: UILabel!
    
    
    var dataManager = BRADataManager.sharedInstance
    var restName:Restaurants?
    var mapAnnotation = MKPointAnnotation()

    
   //MARK: MapView Method
    
    
    
    func setMapLocation(latitude:Double,longitude:Double){
        
        let Center = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(Center, regionRadius * 2.0, regionRadius * 2.0)
       
        self.locationMapView.setRegion(coordinateRegion, animated: true)
        self.mapAnnotation.title = restName!.name
        self.mapAnnotation.coordinate = Center
        self.locationMapView.addAnnotation(mapAnnotation)
        
    }
    
    
    // Format and diplay data
    
    func displayLabels(crossStreet:String,city:String,state:String,zipcode:String,phone:String,twitter:String!){
        
        restaurantCrossStreetLabel.text = crossStreet
        
        let displayAddressString = "\(city),\(state) \(zipcode)"
       
            restaurantStateLabel.text = displayAddressString
            restaurantPhoneLabel.text = phone
        
        if (twitter != nil){
          
            restaurantTwitterLabel.text = "@\(twitter!)"
            
        }else {
            
            restaurantTwitterLabel.text = "Not on Twitter"
        }
    
    
    }
    
    // Sending data over to MapVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MapViewSegue" {
            
            if let destination = segue.destination as? MapViewController{
              
                let locations = dataManager.restaurantsArray
                    destination.restaurantsArray = locations
            }
        }
 
    }
    
    @IBAction func  mapButtonPressed(_ sender:UIBarButtonItem){
        performSegue(withIdentifier: "MapViewSegue", sender: nil)
    }
    
    //MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = restName!.latitude
        let long = restName!.longitude
        
        print("lat:\(lat),lon:\(long)")
        
        setMapLocation(latitude: lat!, longitude: long!)
        
        self.displayLabels(crossStreet: restName!.address, city: restName!.city, state: restName!.state, zipcode: restName!.postalCode, phone: restName!.phone, twitter: restName!.twitter)
        
        restaurantNameLabel.text = restName!.name
        restaurantCategoryLabel.text = restName!.category

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
