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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgetPasswordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
            
            ConnectionHelper.post(command: command, parameter: parameter) { (successed,msg) in
                
                if successed {
                
                    print("reset password was successful")
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                
                    self.notifyUser(msg)
                    
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
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }

}

