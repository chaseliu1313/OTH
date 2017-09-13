//
//  OfferDeatil.swift
//  On the House
//
//  Created by Geng Xu on 2017/9/13.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class OfferDeatil: UIViewController {

    @IBOutlet weak var offerVideo: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "pg_zfIDoKSw")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getVideo(videoCode: String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        offerVideo.loadRequest(URLRequest(url:url!))
        
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
