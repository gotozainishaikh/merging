//
//  CompletedHistoryViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 04/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class CompletedHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
    }
    
}


extension CompletedHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //  self.performSegue(withIdentifier: "requestList", sender: nil)
        
    }
    
    
    
}
