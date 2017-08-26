//
//  LoginViewController.swift
//  On the House
//
//  Created by 吃面包的布拉德 on 2017/8/21.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate{
    
    //let facebookbutton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        /*view.addSubview(facebookbutton)
        facebookbutton.frame = CGRect(x:67.5, y:525, width:240, height: 30)
        //facebooklogin = FBSDKLoginButton()*/
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func facebookloginaction(_ sender: UIButton) {
        let fbloginManager = FBSDKLoginManager()
        fbloginManager.logIn(withReadPermissions: ["email"], from: self){ (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                }
            }
        }
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
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
