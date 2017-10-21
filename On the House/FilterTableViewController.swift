//
//  FilterTableViewController.swift
//  On the House
//
//  Created by bradlbs on 2017/9/18.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    static var filterarray : [String] = []
    
    var buttonisclicked : [String : Bool] = [:]
    let formatter = DateFormatter()
    var clickedbuttons : [UIButton] = []
    var datebuttonisclicked = false
    var clickeddatebutton = UIButton()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FilterTableViewController.filterarray = []
        clickeddatebutton = UIButton()
        clickedbuttons = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowcount = 0
        if section == 0 {
            rowcount = 3
        }
        if section == 1 {
            rowcount = 4
        }
        if section == 2 {
            rowcount = 16
        }
        return rowcount
    }
    
    @IBAction func filteraction(_ sender: UIButton) {
        if !FilterTableViewController.filterarray.contains(sender.currentTitle!){
            FilterTableViewController.filterarray.append(sender.currentTitle!)
            clickedbuttons.append(sender)
        }
        if let istouched = buttonisclicked[sender.currentTitle!]{
            if istouched{
                buttonisclicked[sender.currentTitle!] = false
                FilterTableViewController.filterarray.remove(at: FilterTableViewController.filterarray.index(of: sender.currentTitle!)!)
                clickedbuttons.remove(at: clickedbuttons.index(of: sender)!)
                sender.backgroundColor = UIColor(rgb: 0xDFDDE0)
            }
            else{
                buttonisclicked[sender.currentTitle!] = true
                sender.backgroundColor = UIColor(rgb: 0xAF9A90)
            }
        }
        else{
            
            buttonisclicked[sender.currentTitle!] = true
            sender.backgroundColor = UIColor(rgb: 0xAF9A90)
        }
       
    }
    
    @IBAction func dateaction(_ sender: UIButton) {
        if !datebuttonisclicked {
            FilterTableViewController.filterarray.append(sender.currentTitle!)
            clickeddatebutton = sender
            datebuttonisclicked = true
            sender.backgroundColor = UIColor(rgb: 0xAF9A90)
        }
        else{
            FilterTableViewController.filterarray.remove(at: FilterTableViewController.filterarray.index(of: clickeddatebutton.currentTitle!)!)
            if sender == clickeddatebutton{
                sender.backgroundColor = UIColor(rgb: 0xDFDDE0)
                clickeddatebutton = UIButton()
                datebuttonisclicked = false
            }
            else{
                FilterTableViewController.filterarray.append(sender.currentTitle!)
                clickeddatebutton.backgroundColor = UIColor(rgb: 0xDFDDE0)
               
                sender.backgroundColor = UIColor(rgb: 0xAF9A90)
                clickeddatebutton = sender
            }
        }
    }
    
    
    @IBAction func applyfilter(_ sender: UIBarButtonItem) {
        System.category = System.pickcategory(array: FilterTableViewController.filterarray)
        System.state = System.pickstate(array: FilterTableViewController.filterarray)
       
        OfferingHomePage.parameter["category_id"] = System.category
        OfferingHomePage.parameter["zone_id"] = System.state
        
        var selectedDate: [String] = []
        
        for value in FilterTableViewController.filterarray {
            
            if value == "Today" {
                
                selectedDate = getCurrentDate()
                break
                
            }
            else if value == "This weekend" {
                
                selectedDate = getCurrentWeekend()
                break
                
            }
            else if value == "Next 7 days" {
                
                selectedDate = nextSevenDays()
                break
            }
            else {
                
                continue
            }
            
            
            
        }
     
        System.dates = selectedDate
       
        
        performSegue(withIdentifier: "apply", sender: self)
        //dismiss(animated: false, completion: nil)
        
    }
    
    @IBOutlet var tableview: UITableView!

    
  
    @IBAction func clearaction(_ sender: UIBarButtonItem) {
        FilterTableViewController.filterarray = []
        for button in self.clickedbuttons {
            button.backgroundColor = UIColor(rgb: 0xDFDDE0)
        }
        self.clickedbuttons = []
    }
    
    
    
    func getCurrentDate() -> [String]{
        
        var today: [String] = []
        
        let date = Date()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        
        let currentDate = "\(year)-\(month)-\(day)"
        
        today.append(currentDate)
        
        return today
        
    }
    
    func getCurrentWeekend() -> [String] {
        
        var weekend:[String] = []
        let date = Date()
        let component = Calendar.Component.weekday
        let cal = Calendar.current
        let currentWeekday = cal.component(component, from: date)
        
        let saturday = cal.date(byAdding: component, value: 6 - currentWeekday + 1, to: date)
        let sunday = cal.date(byAdding: component, value: 7 - currentWeekday + 1, to: date)
        
        
        formatter.dateFormat = "yyyy"
        let Syear = formatter.string(from: saturday!)
        let Sunyear = formatter.string(from: sunday!)
        formatter.dateFormat = "MM"
        let Smonth = formatter.string(from: saturday!)
        let Sunmonth = formatter.string(from: sunday!)
        formatter.dateFormat = "dd"
        let Sday = formatter.string(from: saturday!)
        let SuDay = formatter.string(from: sunday!)
        
        let sate = "\(Syear)-\(Smonth)-\(Sday)"
        let sun = "\(Sunyear)-\(Sunmonth)-\(SuDay)"
        weekend.append(sate)
        weekend.append(sun)
        
        return weekend
        
        
    }
    
    func nextSevenDays() -> [String] {
        
        var sevenDays:[String] = []
        let date = Date()
        let component = Calendar.Component.weekday
        let cal = Calendar.current
        let currentWeekday = cal.component(component, from: date)
        
        let startday = cal.date(byAdding: component, value: 8 - currentWeekday + 1, to: date)
        let endday = cal.date(byAdding: component, value: 14 - currentWeekday + 1, to: date)
        
        
        formatter.dateFormat = "yyyy"
        let startyear = formatter.string(from: startday!)
        let endyear = formatter.string(from: endday!)
        formatter.dateFormat = "MM"
        let startMonth = formatter.string(from: startday!)
        let endmonth = formatter.string(from: endday!)
        formatter.dateFormat = "dd"
        let startDay = formatter.string(from: startday!)
        let endDay = formatter.string(from: endday!)
        
        let s = "\(startyear)-\(startMonth)-\(startDay)"
        let e = "\(endyear)-\(endmonth)-\(endDay)"
        sevenDays.append(s)
        sevenDays.append(e)
        
        return sevenDays
        
        
    }

    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


