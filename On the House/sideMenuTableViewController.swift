//
//  sideMenuTableViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class sideMenuTableViewController: UITableViewController {
    
    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func myOffer(_ sender: UIButton) {
        
        let isloggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isloggedin {
            
            self.performSegue(withIdentifier: "myOffers", sender: self)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 15
    }
    
   
    
}
