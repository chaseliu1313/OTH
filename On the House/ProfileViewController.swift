//
//  ProfileViewController.swift
//  On the House
//
//  Created by Chase on 4/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nikenameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var StreetTextfield: UITextField!
    @IBOutlet weak var CityTextfield: UITextField!
    @IBOutlet weak var CountryTextfield: UITextField!
    @IBOutlet weak var StateTextfield: UITextField!
    @IBOutlet weak var ZipTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var reEnterTextfield: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func UpdatePassword(_ sender: UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
