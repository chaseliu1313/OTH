//
//  TeamMemberTableViewController.swift
//  On the House
//
//  Created by James zhang on 22/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class TeamMemberTableViewController: UITableViewController {

    var Array = ["Boshi Liu","Shuyang Liu","Kalaiselvan Maruthappa Raj","Geng Xu","Zhang Zhang" ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Array[indexPath.row]
        return cell
    }
   
}
