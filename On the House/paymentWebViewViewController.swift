//
//  paymentWebViewViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/27/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class paymentWebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "")
        
        webView.loadRequest(URLRequest(url: url!))
        
        self.webView.scalesPageToFit = true
        self.webView.contentMode = UIViewContentMode.scaleAspectFit
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
