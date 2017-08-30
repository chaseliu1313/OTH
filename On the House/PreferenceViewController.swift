//
//  PreferenceViewController.swift
//  On the House
//
//  Created by Zhang Zhang on 8/29/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var picker: UIPickerView!
    
    
    var Array = ["Please select","Adult Industry","Art & Craft","Ballet","Cabaret","CD","CD (Product)","Children","Circus & Physical Theatre","Comedy","Dance","DVD (Product)","Family","Festival","Film","Health","Health and Fitness","Magic","Miscellaneous","Music","Musical","Natural Health","Networking, Seminars, Workshops","Opera","Operetta","Reiki Course","Soiree","Speaking Engagement","Sport","Studio Audience","Test","Theatre","Vaudeville","Young Adults"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Array[row]
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
