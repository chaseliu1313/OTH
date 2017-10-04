//
//  MyOffers.swift
//  On the House
//
//  Created by Geng Xu on 2017/10/2.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class MyOffers: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var currentoffer = ["a","b","c","d","e"]
    var pastoffer = ["a","b","c"]
    @IBOutlet weak var currentOfferTableView: UITableView!
    
    @IBOutlet weak var pastOfferTableView: UITableView!
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if (tableView == currentOfferTableView){
               return(currentoffer.count)
        }else {
                return(pastoffer.count)
            
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView == currentOfferTableView{
       let cell = tableView.dequeueReusableCell(withIdentifier:"currentcell", for: indexPath) as! MyOfferTableViewCell
        return cell
        }else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier:"pastcell", for: indexPath) as! MyPastOfferTableViewCell
            
           
            return cell2

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
}
