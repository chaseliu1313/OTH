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

class LoginViewController: UIViewController{

    
    //let facebookbutton = FBSDKLoginButton()
    
    var parameters = [
        "email": "Chase@example.com",
        "password": "pass1234"
    ]
    
    
    
    let command = "api/v1/member/login"

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordtextfield.isSecureTextEntry = true
        /*view.addSubview(facebookbutton)
        facebookbutton.frame = CGRect(x:67.5, y:525, width:240, height: 30)
        //facebooklogin = FBSDKLoginButton()*/
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func facebookloginaction(_ sender: UIButton) {
        let loginmanager = LoginManager()
        loginmanager.logIn( [.publicProfile ,.email ], viewController: self){ result in
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("Login cancelled")
            case .success(_,_,_):
                self.getUserinfo {userinfo, error in
                    if let error = error {print(error.localizedDescription)}
                    if let userinfo = userinfo, let id = userinfo["id"], let name = userinfo["name"], let email = userinfo["email"]{
                        NewMemberData.email = email as! String
                        let fullname = name as! String
                        let namearray = fullname.components(separatedBy: " ")
                        NewMemberData.first_name = namearray[0]
                        NewMemberData.last_name = namearray[1]
                        //self.loginlabel.text = "Successfully login"
                    }
                    
                }
            }
            
        }
    }
    
    func getUserinfo(completion : @escaping (_ : [String: Any]? ,_ : Error?) -> Void){
        let request = GraphRequest(graphPath:"me" , parameters: ["fields":"id, email, picture"])
        request.start { (response, result) in
            switch result{
            case .failed(let error):
                completion(nil , error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        
        if emailtextfield.text != ""
            && passwordtextfield.text != ""
        {
        
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
            
        login(email: email, password: password)
            
        }
        
    }
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
