//
//  TandCViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/5/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class TandCViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.itsonthehouse.com.au/terms-and-conditions")
        
        webView.loadRequest(URLRequest(url: url!))
        
        self.webView.scalesPageToFit = true
        self.webView.contentMode = UIViewContentMode.scaleAspectFit
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
