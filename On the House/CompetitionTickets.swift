//
//  CompetitionTickets.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/26.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class CompetitionTickets: UIViewController {

    @IBOutlet weak var competitionQuestion: UILabel!
    @IBOutlet weak var competitionAnswer: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func `return`(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
