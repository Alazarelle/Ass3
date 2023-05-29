//
//  ViewController.swift
//  Digital Pantry
//
//  Created by Federico Amor on 9/5/2023.
//

import UIKit

class ViewController: UIViewController {

    var executeDB = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.navigationItem.setHidesBackButton(true, animated: true)
//        importFoodDataCSV()
    }
    
    @IBAction func tableUpdate(_ sender: Any) {
        createTables()
        insertTableData()
//        importFoodDataCSV()
//        readAllergyTable()
    }
    
}

