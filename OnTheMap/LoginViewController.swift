//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var loginButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      loginButton.layer.cornerRadius = 4.0
    }
   
   @IBAction func loginButtonTapped(_ sender: UIButton) {
      // TODO: Implement login. REMOVE TEMPORARY SEGUE
      print("login button tapped")
   }
   
   @IBAction func signUpButtonTapped(_ sender: UIButton) {
      UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!, options: [:], completionHandler: nil)
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
