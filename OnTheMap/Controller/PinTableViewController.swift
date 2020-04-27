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

   var annotations: [MKPointAnnotation] = TestData.annotations

   override func viewDidLoad() {
      super.viewDidLoad()

      
   }

   // MARK: - UITableViewDataSource

   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return annotations.count
   }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let annotation = annotations[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "pinCell", for: indexPath)

      cell.textLabel?.text = annotation.title
      cell.detailTextLabel?.text = annotation.subtitle
      cell.detailTextLabel?.textColor = .systemGray

      return cell
   }

   // MARK: - UITableViewDelegate
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // open url in safari view controller
      let annotation = annotations[indexPath.row]
      let safariVC = SFSafariViewController(url: URL(string: annotation.subtitle!)!)
      safariVC.dismissButtonStyle = .close
      self.present(safariVC, animated: true)
   }
}
