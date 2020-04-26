//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/25/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

   @IBOutlet weak var locationTextField: UITextField!
   @IBOutlet weak var urlTextField: UITextField!
   @IBOutlet weak var findLocationButton: UIButton!
   @IBOutlet weak var navBar: UINavigationItem!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      findLocationButton.layer.cornerRadius = 4.0
    }
    
   @IBAction func cancelButton(_ sender: UIBarButtonItem) {
      dismiss(animated: true, completion: nil)
   }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
