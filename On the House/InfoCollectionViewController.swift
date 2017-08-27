//
//  InfoCollectionViewController.swift
//  On the House
//
//  Created by 吃面包的布拉德 on 2017/8/25.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class InfoCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var postcode: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var reenterpassword: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickname.resignFirstResponder()
        firstname.resignFirstResponder()
        lastname.resignFirstResponder()
        state.resignFirstResponder()
        postcode.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        reenterpassword.resignFirstResponder()
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


