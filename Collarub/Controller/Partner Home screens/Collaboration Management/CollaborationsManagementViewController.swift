//
//  CollaborationsManagementViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 02/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class CollaborationsManagementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //tableView.reloadData()
        uiNavegationImage()
        
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    

}



extension CollaborationsManagementViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       self.performSegue(withIdentifier: "nextScreen", sender: nil)
        
    }
    
    
    
}


