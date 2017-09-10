//
//  ChangePasswordViewController.swift
//  On the House
//
//  Created by Chase on 10/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var notification: UILabel!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirm: UITextField!
    
    
    let command = "api/v1/member/change-password"
    var parameter = [
    
        "member_id" : "1",
        "password" : "",
        "password_confirm" : ""
    
    
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func changePassword(_ sender: UIButton) {
        
        let id = UserDefaults.standard.string(forKey: "member_id")!
        self.parameter.updateValue(id, forKey: "member_id")
        
        
        if oldPassword.text == "" || oldPassword.text != UserDefaults.standard.string(forKey: "password"){
        notification.text = "The old password is incorrect"
        }
        
        else {
        
        if(newPassword.text != "" && confirm.text != ""){
        
        self.parameter.updateValue(newPassword.text!, forKey: "password")
        self.parameter.updateValue(confirm.text!, forKey: "password_confirm")
         
        ConnectionHelper.post(command: command, parameter: parameter, compeletion: { (success, msg) in
            if success{
               
                UserDefaults.standard.set(self.newPassword.text!, forKey: "password")
                UserDefaults.standard.synchronize()
            
            self.notifyUser(["Change Password Successful"])
            }
            else {
            
            self.notifyUser(msg)
                
            }
        })
        
        
        }
        else{
            self.notifyUser(["Please Enter All Fields"])
        
        }
        
        }
        
    }
    @IBAction func `return`(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
    func showWarning(){
        
        if oldPassword.text != "" && oldPassword.text! != UserDefaults.standard.string(forKey: "password")
        {
            
            notification.text = "The old password is incorrect"
            
        }
        else if oldPassword.text == "" || oldPassword.text! == UserDefaults.standard.string(forKey: "password"){
            
            notification.text = ""
        }
    }
}
