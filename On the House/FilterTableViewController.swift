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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            rowcount = 15
        }
        return rowcount
    }
    
    @IBAction func filteraction(_ sender: UIButton) {
        if !FilterTableViewController.filterarray.contains(sender.currentTitle!){
            FilterTableViewController.filterarray.append(sender.currentTitle!)
        }
        if let istouched = buttonisclicked[sender.currentTitle!]{
            if istouched{
                buttonisclicked[sender.currentTitle!] = false
                FilterTableViewController.filterarray.remove(at: FilterTableViewController.filterarray.index(of: sender.currentTitle!)!)
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
        print(FilterTableViewController.filterarray)
        //buttonisclicked
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
