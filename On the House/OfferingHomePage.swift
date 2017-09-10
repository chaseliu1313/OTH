//
//  OfferingHomePage.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/6.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class OfferingHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var event = [#imageLiteral(resourceName: "event1.jpg"), #imageLiteral(resourceName: "event2.jpg"), #imageLiteral(resourceName: "event3.jpg")]
    var evntLable = ["Call Me", "Today", "Just Do It"]
    var loadMoreEnable = true
     var loadMoreView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.backgroundColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to load more offer")
        refreshControl.addTarget(self, action: #selector(OfferingHomePage.refreshOffer), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        }else{
            tableView.addSubview(refreshControl)
        }
        
        sideMenus()
        
    }
    func refreshOffer(){
        event.append(#imageLiteral(resourceName: "event4.jpg"))
        event.append(#imageLiteral(resourceName: "event5.jpg"))
        event.append(#imageLiteral(resourceName: "event6.jpg"))
        evntLable.append("Let's dance")
        evntLable.append("Come")
        evntLable.append("See you again")
        
        tableView.reloadData()
        
        
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (event.count)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop"
        {
            let dest = segue.destination
            if let pop = dest.popoverPresentationController
            {
                pop.delegate = self
            }
        }
    }
    
    func sideMenus(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 200
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"eventCell", for: indexPath) as! OfferTableCell
        cell.eventImage.image = event[indexPath.row]
        cell.eventTitle.text = evntLable[indexPath.row]
        

        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        if (loadMoreEnable && indexPath.row == event.count-1) {
            refreshOffer()
        }
        return (cell)
        
    }

   
}
