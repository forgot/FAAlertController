//
//  InitialViewController.swift
//  FAAlertController
//
//  Created by Jesse Cox on 11/1/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.isToolbarHidden = true
        navigationController?.toolbar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor(red:0, green:0.478, blue:1, alpha:1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dark" {
            self.navigationController?.navigationBar.tintColor = .orange
        }
    }
    
}
