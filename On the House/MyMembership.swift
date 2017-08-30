//
//  MyMembership.swift
//  On the House
//
//  Created by Geng Xu on 2017/8/29.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit




class MyMembership: UIViewController {
    
    
    @IBOutlet weak var goldCheck: UIButton!
    
        
    var checkBox = UIImage(named: "check")
    var checkedBox = UIImage(named: "checked")
    
    
    
    
    var isgoldboxclicked: Bool!
    var isbronzeboxclicked: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isgoldboxclicked = false
        isbronzeboxclicked = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goldClick(_ sender: Any) {
        if isgoldboxclicked == true{
            isgoldboxclicked = false
        }else{
            
            isgoldboxclicked = true
        
        }
        
        if isgoldboxclicked == true{
            goldCheck.setImage(checkedBox, for: UIControlState.normal)
            
            
        }else{
            goldCheck.setImage(checkBox, for: UIControlState.normal)
            
        }
     }
    }
