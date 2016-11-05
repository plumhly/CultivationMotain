//
//  AttachPhotoViewController.swift
//  UnCloudNotes
//
//  Created by Richard Turton on 26/07/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit
import CoreData

class AttachPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var note : Note?
  
  lazy var imagePicker : UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    self.addChildViewController(picker)
    return picker
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imagePicker.view)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imagePicker.view.frame = view.bounds
  }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let note = note {
            if let attachment = NSEntityDescription.insertNewObject(forEntityName: "Attachment", into: note.managedObjectContext!) as? Attachment {
                attachment.dateCreated = NSDate.init()
                attachment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
                attachment.note = note
            }
            
        }
       _ = self.navigationController?.popViewController(animated: true)
    }
}
