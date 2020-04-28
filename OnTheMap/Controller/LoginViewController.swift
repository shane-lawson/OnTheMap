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
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      loginButton.layer.cornerRadius = 4.0
    }
   
   @IBAction func loginButtonTapped(_ sender: UIButton) {
      setLoggingIn(true)
      UdacityAPI.login(username: emailTextField.text!, password: passwordTextField.text!, completionHandler: handleLoginResponse(success:error:))
   }
   
   @IBAction func signUpButtonTapped(_ sender: UIButton) {
      UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!, options: [:], completionHandler: nil)
   }
   
   fileprivate func handleLoginResponse(success: Bool, error: Error?) {
      if success {
         DispatchQueue.main.async { [unowned self] in
            self.setLoggingIn(false)
            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
         }
      } else {
         print(error!)
      }
   }
   
   fileprivate func setLoggingIn(_ loggingIn: Bool) {
      if loggingIn {
         activityIndicator.startAnimating()
      } else {
         activityIndicator.stopAnimating()
      }
      loginButton.isEnabled = !loggingIn
      emailTextField.isEnabled = !loggingIn
      passwordTextField.isEnabled = !loggingIn
   }
}
