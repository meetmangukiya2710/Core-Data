//
//  ViewController.swift
//  Core Data
//
//  Created by R95 on 24/06/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userIDTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    var obj = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveBtn_Ac(_ sender: Any) {
        if let idString = userIDTxt.text, let id = Int(idString) {
            obj.addData(id: id, name: nameTxt.text ?? "nil")
        } else {
            print("Error: Invalid user ID")
        }
    }

    @IBAction func getData_Ac(_ sender: Any) {
        obj.getData()
    }
}
