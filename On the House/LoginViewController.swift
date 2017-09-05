//
//  LoginViewController.swift
//  On the House
//
//  Created by 吃面包的布拉德 on 2017/8/21.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class LoginViewController: UIViewController{
    
    var userfbinfo : [String : AnyObject]!

    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    //let facebookbutton = FBSDKLoginButton()
    
    var parameters = [
        "email": " ",
        "password": " "
    ]
    
    
    
    let command = "api/v1/member/login"

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        passwordtextfield.isSecureTextEntry = true
        if isloggedIn() {
            print("you have already logged in")
            self.dismiss(animated: true, completion: nil)
            
            
        }
      
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    @IBAction func facebookloginaction(_ sender: UIButton) {
        let loginmanager = LoginManager()
        loginmanager.logIn( [.publicProfile ,.email ], viewController: self){ result in
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("Login cancelled")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.performSegue(withIdentifier: "facebookreg", sender: self)
                self.getfbuserinfo()
                //self.setfbuserinfo()
            }
            
        }
    }
    
    
    func setfbuserinfo(){
        if((FBSDKAccessToken.current()) != nil){
            let email = userfbinfo["email"] as? String
            let fullname = userfbinfo["name"]as? String
            NewMemberData.email = email!
            let namearray = fullname!.components(separatedBy: " ")
            NewMemberData.first_name = namearray[0]
            NewMemberData.last_name = namearray[1]
            print(NewMemberData.first_name)
        }
    }
    

    
    func getfbuserinfo(){
        if((FBSDKAccessToken.current()) != nil){
            var dict : [String : AnyObject]!
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    dict = result as! [String : AnyObject]
                    self.userfbinfo = dict
                    print(self.userfbinfo["email"]!)
                }
            })
        }
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
    
        
        
        
        
        if ( emailtextfield.text != "" && passwordtextfield.text != "")
        
        {
            
            
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
            
           
            parameters.updateValue(email, forKey: "email")
            parameters.updateValue(password, forKey: "password")
            
            
            print(parameters)
            ConnectionHelper.userLogin(command: command, parameter: parameters, compeletion: { (successed) in
                
                if successed {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    
                    UserDefaults.standard.synchronize()
                print("login was successful")
                }
                else {
                self.notifyUser("ON THE HOUSE", "Invalid Email Address/Password")
                    
                
                }
            })
            
        
        }
        
        else {
         self.notifyUser("ON THE HOUSE", "Enter Your Email or Password")
        
        
        }
        
        
        
        
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailtextfield.resignFirstResponder()
        passwordtextfield.resignFirstResponder()
    }
    
    @IBOutlet weak var facebookloginbutton: UIButton!
    
    //login function by Chase
    func login(email: String, password: String)
    {
     parameters.updateValue(email, forKey: "email")
     parameters.updateValue(password, forKey: "password")
     
        ConnectionHelper.userLogin(command: command, parameter: parameters) { (successed) in
          
            if successed {
            
            print("log in successful")
            }
            else {
            print("something went wrong")
            
            }
        }
     
    
    }
    
    //check log in status
    func isloggedIn() -> Bool {
    
    return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    //add notification
    func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
        
    }
    

}
