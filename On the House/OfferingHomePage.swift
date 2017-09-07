//
//  OfferingHomePage.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/6.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class OfferingHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var event = [#imageLiteral(resourceName: "event1.jpg"), #imageLiteral(resourceName: "event2.jpg"), #imageLiteral(resourceName: "event3.jpg")]
    var evntLable = ["Call Me", "Today", "Just Do It"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (event.count)
    }
    
    
    
   
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"eventCell", for: indexPath) as! OfferTableCell
        cell.eventImage.image = event[indexPath.row]
        cell.eventTitle.text = evntLable[indexPath.row]
        

        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        return (cell)
        
    }

   
}
