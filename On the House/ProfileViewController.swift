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
    
    var command = "api/v1/member/"
    var member_id = ""
    let command2 = "api/v1/member/change-password"
    var parameter2 = ["member_id":"",
                      "password":"",
                      "password_confirm": ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoCollectionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // member_id = UserDefaults.standard.string(forKey: "member_id")!
        
        //if member_id is not saved or retrieved, will not have placeholders
        
        if member_id != "" {
         
            nikenameTextfield.placeholder =  UserDefaults.standard.string(forKey: "nickname")
            emailTextfield.placeholder = UserDefaults.standard.string(forKey: "email")
         
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func UpdatePassword(_ sender: UIButton) {
        
        if passwordTextfield.text != ""
          && reEnterTextfield.text != ""
          && member_id != ""
        {
            let password = passwordTextfield.text!
            let reEnter = reEnterTextfield.text!
        parameter2.updateValue(member_id, forKey: "member_id")
        parameter2.updateValue(password, forKey: "password")
        parameter2.updateValue(reEnter, forKey: "password_confirm")
        ConnectionHelper.get(command: command2, completion: { (successed) in
            
            if successed {
             self.notifyUser("ON THE HOUSE", "Change Password Successful")
            }
            else {
                self.notifyUser("ON THE HOUSE", "Passwords Don't Match")
            }
        })
            
        }
        else
        {
            self.notifyUser("ON THE HOUSE", "Plese Enter Your New Password")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destController = segue.destination as! PreferenceViewController
        
        
    }

}
