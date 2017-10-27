//
//  RedirectViewController.swift
//  On the House
//
//  Created by Chase on 13/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class RedirectViewController: UIViewController {
    
    var address = ""
   
  
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let  url  = URL(string: address)
        
        webView.loadRequest(URLRequest(url: url!))
        
        self.webView.scalesPageToFit = true
        self.webView.contentMode = UIViewContentMode.scaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
