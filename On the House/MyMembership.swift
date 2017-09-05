//
//  MyMembership.swift
//  On the House
//
//  Created by Geng Xu on 2017/8/29.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit




class MyMembership: UIViewController {
    
    
    @IBOutlet weak var selectButton: UIButton!
   
    @IBAction func selectMem(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            
            selectButton.isHidden = false
            
        }
        else
        {
            
            selectButton.isHidden = true
        }

        
    }
    
    

    @IBAction func upgradeMember(_ sender: UIButton) {
        print("function not yet implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
         //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyMembership.dismissKeyboard))
         view.addGestureRecognizer(tap)
        
        
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
   
    }
