//
//  sideMenuTableViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 9/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class sideMenuTableViewController: UITableViewController {
    
    
    @IBOutlet weak var logoutbutton: UIButton!
    let isloggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isloggedin {
            
            
            self.logoutbutton.setTitle("Go Login", for: .normal)
        }
       
    }
    
    @IBAction func myOffer(_ sender: UIButton) {
        
    
        
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
    
    @IBAction func mymembership(_ sender: UIButton) {
        
        if isloggedin {
            
            self.performSegue(withIdentifier: "myMembership", sender: self)
        }
        
        
    }
    
    @IBAction func changePass(_ sender: UIButton) {
        
        if isloggedin {
            
            self.performSegue(withIdentifier: "changePassword", sender: self)
        }
    }
    
    @IBAction func updateProfile(_ sender: UIButton) {
        
        if isloggedin {
            
            self.performSegue(withIdentifier: "updateProfile", sender: self)
        }
    }
    
    
    
}
