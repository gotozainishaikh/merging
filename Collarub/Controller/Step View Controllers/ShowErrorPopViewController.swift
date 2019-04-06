//
//  ShowErrorPopViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 13/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class ShowErrorPopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
        cell.textLabel?.textColor = UIColor.red
        return cell
    }
    
    var model = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimate()
        
    }
    

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    @IBAction func saveDraft(_ sender: UIButton) {
    
       // self.dismiss(animated: true, completion: nil)
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "partnerTab")
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func edit(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
}
