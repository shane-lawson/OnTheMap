//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/26/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   // MARK: IBOutlets

   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var loginButton: UIButton!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   // MARK: Overrides

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      loginButton.layer.cornerRadius = 4.0
    }
   
   // MARK: IBActions

   @IBAction func loginButtonTapped(_ sender: UIButton) {
      setLoggingIn(true)
      if emailTextField.text! == "" {
         showLoginFailed(message: "It looks like you forgot to enter an email address.")
      } else if passwordTextField.text! == "" {
         showLoginFailed(message: "It looks like you forgot to enter a password.")
      } else {
         UdacityAPI.login(username: emailTextField.text!, password: passwordTextField.text!, completionHandler: handleLoginResponse(success:error:))
      }
   }
   
   @IBAction func signUpButtonTapped(_ sender: UIButton) {
      UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
   }
   
   @IBAction func revertLoginSegue(_ segue: UIStoryboardSegue) {
      emailTextField.text = nil
      passwordTextField.text = nil
   }
      
   // MARK: Helpers

   fileprivate func handleLoginResponse(success: Bool, error: Error?) {
      if success {
         UdacityAPI.getUserData(completionHandler: handleUserDataResponse(success:error:))
      } else {
         DispatchQueue.main.async { [unowned self] in
            self.showLoginFailed(message: error!.localizedDescription)
         }
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
   
   fileprivate func showLoginFailed(message: String) {
      self.setLoggingIn(false)
      let alertVC = UIAlertController(title: "Login failed", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
   }
}
