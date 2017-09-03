//
//  ForgetPasswordViewController.swift
//  On the House
//
//  Created by 吃面包的布拉德 on 2017/8/21.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    let command = "api/v1/member/forgot-password"
    var parameter = ["email" : " "]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailtextfield.resignFirstResponder()
    }
    
    

    @IBAction func forgetPassword(_ sender: UIButton) {
        
        let email = emailtextfield.text!
        
        if emailtextfield.text  != "" {
        
          parameter.updateValue(email, forKey: "email")
            
            ConnectionHelper.post(command: command, parameter: parameter) { (successed) in
                
                if successed {
                
                    print("reset password was successful")
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                
                    self.notifyUser("ON THE HOUSE", "Invalid Email Address")
                    
                }
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
     func notifyUser(_ title: String, _ message: String ) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
        
    }

}

