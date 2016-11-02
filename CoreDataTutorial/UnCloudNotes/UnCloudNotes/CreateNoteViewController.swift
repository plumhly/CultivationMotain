//
//  CreateNoteViewController.swift
//  UnCloudNotes
//
//  Created by Saul Mora on 6/11/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit
import CoreData

class CreateNoteViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate
{
  var managedObjectContext : NSManagedObjectContext?
  lazy var note: Note? =
  {
    if let context = self.managedObjectContext
    {
      return NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as? Note
    }
    return .none
  }()
  
  @IBOutlet var titleField : UITextField!
  @IBOutlet var bodyField : UITextView!
  @IBOutlet var attachPhotoButton : UIButton!
  @IBOutlet var attachedPhoto : UIImageView!
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    titleField.becomeFirstResponder()
  }
  
  @IBAction func saveNote()
  {
    note?.title = titleField.text as NSString!
    note?.body = bodyField.text as NSString!
    
    if let managedObjectContext = managedObjectContext {
      do {
        try  managedObjectContext.save()
      }
      catch let error as NSError {
        print("Error saving \(error)", terminator: "")
      }
    }
    performSegue(withIdentifier: "unwindToNotesList", sender: self)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    saveNote()
    textField.resignFirstResponder()
    return false
  }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AttachPhoto" {
            if let nextViewController = segue.destination as? AttachPhotoViewController {
                nextViewController.note = note
            }
        }
    }
  
}
