//
//  AddEditRadio.swift
//  RadioDataCoreData
//
//  Created by John Diczhazy on 9/12/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit
import CoreData


class AddEditRadio: UIViewController {
    
    @IBOutlet weak var txtMake: UITextField!
    
    @IBOutlet weak var txtModel: UITextField!
    
    @IBOutlet weak var txtSerialNo: UITextField!
    
    
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var editRecNo = Int()
    var dataArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editRecNo != -1 {
            
            txtMake.text = self.dataArray[editRecNo].value(forKey: kMakeStr) as? String
            txtModel.text = self.dataArray[editRecNo].value(forKey: kModelStr) as? String
            txtSerialNo.text = self.dataArray[editRecNo].value(forKey: kSerialNoStr) as? String
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: AnyObject) {
        
        if editRecNo != -1 {
           
            self.dataArray[editRecNo].setValue(txtMake.text!, forKey: kMakeStr)
            self.dataArray[editRecNo].setValue(txtModel.text!, forKey: kModelStr)
            self.dataArray[editRecNo].setValue(txtSerialNo.text!, forKey: kSerialNoStr)
            
            
            
            do {
                try self.dataArray[editRecNo].managedObjectContext?.save()
            } catch {
                print("Error occured during updating entity")
            }
        } else {
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntityStr, in: appDelegateObj.managedObjectContext)
            let newRadio = NSManagedObject(entity: entityDescription!, insertInto: appDelegateObj.managedObjectContext)
                       
            newRadio.setValue(txtMake.text!, forKey: kMakeStr)
            newRadio.setValue(txtModel.text!, forKey: kModelStr)
            newRadio.setValue(txtSerialNo.text!, forKey: kSerialNoStr)
            
            
            do {
                try newRadio.managedObjectContext?.save()
            } catch {
                print("Error occured during save entity")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelTappe(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

