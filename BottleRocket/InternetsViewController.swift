//
//  InternetsViewController.swift
//  BottleRocket
//
//  Created by Buwaneka Galpoththawela on 10/25/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class InternetsViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var internetsWebView: UIWebView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
   
    // Adding action button connections to InternetsView
    
    @IBAction func backAction(sender: AnyObject) {
        if internetsWebView.canGoBack {
            internetsWebView.goBack()
        }
    }
    
    @IBAction func forwardAction(sender: AnyObject) {
        if internetsWebView.canGoForward {
            internetsWebView.goForward()
        }
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        internetsWebView.reload()
    }
    
    
    //Mark: Declaring webView delegate protocols
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
   
    
    //MARK: Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()

        internetsWebView.loadRequest(NSURLRequest(url: NSURL(string:"http://www.bottlerocketstudios.com")! as URL) as URLRequest)
        
    
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.BRAGreen()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
