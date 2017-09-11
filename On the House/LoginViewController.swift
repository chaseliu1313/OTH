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
    
    static var userfbinfo : [String : AnyObject]!
    
    var isauser = false
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    @IBAction func Skip(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "didSkip")
        UserDefaults.standard.synchronize()
    }
    
    var parameters = [
        "email": " ",
        "password": " "
    ]
    
    
    
    let command = "api/v1/member/login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getfbuserinfo()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        passwordtextfield.isSecureTextEntry = true
        
        
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
                self.getfbuserinfo()
                if(!self.isauser){
                    //self.performSegue(withIdentifier: "facebookreg", sender: self)
                }
                else{
                    self.performSegue(withIdentifier: "facebooklogin", sender: self)
                }
            }
            
        }
    }
    
    
    func getfbuserinfo(){
        if((FBSDKAccessToken.current()) != nil){
            var dict : [String : AnyObject]!
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    dict = result as! [String : AnyObject]
                    LoginViewController.userfbinfo = dict
                    let email = LoginViewController.userfbinfo["email"] as! String
                    if(email == UserDefaults.standard.string(forKey: "email")!){
                        self.isauser = true
                    }
                    let fullname = LoginViewController.userfbinfo["name"]as! String
                    NewMemberData.email = email
                    let namearray = fullname.components(separatedBy: " ")
                    NewMemberData.first_name = namearray[0]
                    NewMemberData.last_name = namearray[1]
                }
            })
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        
        
        
        if ( emailtextfield.text != "" && passwordtextfield.text != "" && System.isValidEmailAddress(emailAddressString: emailtextfield.text!))
            
        {
            
            
            let email = emailtextfield.text!
            let password = passwordtextfield.text!
            
            
            parameters.updateValue(email, forKey: "email")
            parameters.updateValue(password, forKey: "password")
            
            
            print(parameters)
            ConnectionHelper.userLogin(command: command, parameter: parameters, compeletion: { (successed) in
                
                if successed {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set(false, forKey: "didSkip")
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                    
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
