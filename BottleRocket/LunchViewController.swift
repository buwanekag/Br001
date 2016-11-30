//
//  ViewController.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/25/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var restaurantDisplayCollectionView: UICollectionView!
    
    var dataManager = BRADataManager.sharedInstance
    let restaurants = Restaurants()
    var restaurantNamesArray = [String]()
    
    
    //Mark: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataManager.restaurantNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        
        UICollectionViewCell {
        
        let lunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            as! LunchCollectionViewCell
        
        let restaurantName = dataManager.restaurantNamesArray[indexPath.row]
        let restaurantCategory = dataManager.restaurantCategoryArray[indexPath.row]
        let restaurantImage = dataManager.restaurantImageArray[indexPath.row]
        
      lunchCell.setCollectionViewCell(Image: restaurantImage,Name: restaurantName,Category: restaurantCategory)

        return lunchCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = CGFloat(180)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }

    
    // Sending data over to LunchDetailVC and MapVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue"{
            
            if let destination = segue.destination as? LunchDetailViewController{
              
                let indexPaths = self.restaurantDisplayCollectionView.indexPathsForSelectedItems
                let indexPath = (indexPaths?[0])! as IndexPath
                let name = dataManager.restaurantsArray[indexPath.row]
                    destination.restName = name
            }
           
        }else{
            
            if segue.identifier == "MapViewSegue" {
                
                if let destination = segue.destination as? MapViewController{
                   
                    let locations = dataManager.restaurantsArray
                    destination.restaurantsArray = locations
                }
            }
        }
        
    }
    
   
    @IBAction func mapButtonPressed(_ sender:UIBarButtonItem){
        performSegue(withIdentifier: "MapViewSegue", sender: nil)
    }
    

    
   func newDataReceived(){
   
    let count =  dataManager.restaurantNamesArray.count
    print(count)
        
    restaurantDisplayCollectionView.reloadData()
        
    }

    
    //MARK: Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.getDataFromServer()
       
        NotificationCenter.default.addObserver(self, selector: #selector(LunchViewController.newDataReceived), name: NSNotification.Name(rawValue: "receivedDataFromServer"), object: nil)
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        restaurantDisplayCollectionView.collectionViewLayout.invalidateLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

