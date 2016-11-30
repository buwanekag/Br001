//
//  MapViewController.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 11/27/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var locationMapView: MKMapView!

    var restaurantsArray = [Restaurants]()
    
    
   // Display data recieved on Map.
    
    func displayRestaurantsOnMap() {
        
        for restaurant in restaurantsArray {
            
            let restaurantLat = restaurant.latitude
            let restaurantLon = restaurant.longitude
            let restaurantName = restaurant.name
           
            self.setMapLocation(latitude: restaurantLat!, longitude: restaurantLon!, name: restaurantName!)
        }
    }
    
    
    //MARK: MapView Method
    
    // Setting up mapView with annotations
    
    func setMapLocation(latitude:Double,longitude:Double,name:String){
        
        let mapAnnotation = MKPointAnnotation()
      
        let Center = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let regionRadius: CLLocationDistance = 1750
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(Center, regionRadius * 2.0, regionRadius * 2.0)
       
        self.locationMapView.setRegion(coordinateRegion, animated: true)
            mapAnnotation.title = name
            mapAnnotation.coordinate = Center
        self.locationMapView.addAnnotation(mapAnnotation)
        
    }

    
    @IBAction func exitButtonPressed(_ sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
   
    
    //MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayRestaurantsOnMap()
        print("Restaurants:\(restaurantsArray.count)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
