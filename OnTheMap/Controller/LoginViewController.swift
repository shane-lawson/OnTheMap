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
      UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
   }
   
   @IBAction func revertLoginSegue(_ segue: UIStoryboardSegue) {
      emailTextField.text = nil
      passwordTextField.text = nil
   }
   
   fileprivate func handleLoginResponse(success: Bool, error: Error?) {
      if success {
         UdacityAPI.getUserData(completionHandler: handleUserDataResponse(success:error:))
      } else {
         print(error!)
      }
   }
   
   fileprivate func handleUserDataResponse(success: Bool, error: Error?) {
      if success {
         DispatchQueue.main.async { [unowned self] in
            self.setLoggingIn(false)
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
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
