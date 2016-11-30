//
//  BRANetworkManager.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/25/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class BRANetworkManager: NSObject {
    static let sharedInstance = BRANetworkManager()
   
    var serverReach: Reachability?
    var serverAvailable = false
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
            serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)
       
        if serverAvailable {
            print("changed: server available")
        
        }else {
            print("changed: server not available")
        }
    }
    
    override init() {
        super.init()
        print("Starting Network Manager")
        
        let dataManager = BRADataManager.sharedInstance
            serverReach = Reachability(hostName: dataManager.baseURLString)
            serverReach?.startNotifier()
       
        NotificationCenter.default.addObserver(self, selector: #selector(BRANetworkManager.reachabilityChanged(note:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        
    }


}
