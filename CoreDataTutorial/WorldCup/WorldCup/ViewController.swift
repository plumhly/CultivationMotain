//
//  ViewController.swift
//  WorldCup
//
//  Created by Pietro Rea on 8/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

private let teamCellIdentifier = "teamCellReuseIdentifier"

class ViewController: UIViewController {
  
  var coreDataStack: CoreDataStack!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  func configureCell(cell: TeamCell, indexPath: NSIndexPath) {
    cell.flagImageView.backgroundColor = UIColor.blue
    cell.teamLabel.text = "Team Name"
    cell.scoreLabel.text = "Wins: 0"
  }
}

extension ViewController: UITableViewDataSource {
  
  private func numberOfSectionsInTableView
    (tableView: UITableView) -> Int {
      
      return 1
  }
  
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      
      return 20
  }
  
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      
      let cell =
        tableView.dequeueReusableCell(
            withIdentifier: teamCellIdentifier, for: indexPath)
        as! TeamCell
      
      configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
      
      return cell
  }
}

extension ViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
      
  }
}
