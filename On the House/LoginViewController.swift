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

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailtextfield.resignFirstResponder()
        passwordtextfield.resignFirstResponder()
    }
    
    @IBOutlet weak var facebookloginbutton: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
