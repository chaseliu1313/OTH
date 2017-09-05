//
//  MyMembership.swift
//  On the House
//
//  Created by Geng Xu on 2017/8/29.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit




class MyMembershipController: UIViewController {
    
    
   
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
         //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyMembershipController.dismissKeyboard))
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
    
    
    
   
    }
