//
//  PinTableViewController.swift
//  OnTheMap
//
//  Created by Shane Lawson on 4/25/20.
//  Copyright © 2020 Shane Lawson. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class PinTableViewController: UITableViewController {

   var locations: [StudentLocation] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.locations
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }

   // MARK: - UITableViewDataSource

   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.count
   }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let location = locations[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "pinCell", for: indexPath)

      cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
      cell.detailTextLabel?.text = "\(location.mediaURL)"
      cell.detailTextLabel?.textColor = .systemGray

      return cell
   }

   // MARK: - UITableViewDelegate
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // open url in safari view controller
      let location = locations[indexPath.row]
      if let url = URL(string: location.mediaURL), UIApplication.shared.canOpenURL(url) {
         let safariVC = SFSafariViewController(url: url)
         safariVC.dismissButtonStyle = .close
         self.present(safariVC, animated: true)
      } else {
         let alertVC = UIAlertController(title: "Invalid URL", message: "Please select a valid URL.", preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alertVC, animated: true, completion: nil)
      }
   }
}
