//
//  ViewController.swift
//  OfflineManager
//
//  Created by Prashant G on 7/20/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var fileNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func readmyJson(fileName: String)  {
        
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        let dataURL = documentsDirectoryPath.appendingPathComponent("MyFolder")
        let jsonFilePath = dataURL?.appendingPathComponent(fileName + ".json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let finalDataDict = NSKeyedUnarchiver.unarchiveObject(withFile: (jsonFilePath?.absoluteString)!) as! [String: String]
            print(finalDataDict)
            fullNameTextField.text = finalDataDict["Name"]
            designationTextField.text = finalDataDict["Designation"]
        }
        else{
            print("File does not exists")
        }
    }
    
    
    func writeToFile(fileName: String)  {
        let finalDataDict = ["Name":fullNameTextField.text ?? "Vijay Singh",
                             "Designation": designationTextField.text ?? "ios dev"
                            ]
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        let dataURL = documentsDirectoryPath.appendingPathComponent("MyFolder")
        do {
            try FileManager.default.createDirectory(atPath: (dataURL?.absoluteString)!, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        let jsonFilePath = dataURL?.appendingPathComponent(fileName + ".json")
        NSKeyedArchiver.archiveRootObject(finalDataDict, toFile:(jsonFilePath?.absoluteString)!)
        
        fullNameTextField.text = ""
        designationTextField.text = ""
    }
    
    @IBAction func saveJsonDataAction(_ sender: Any) {
        self.writeToFile(fileName: fileNameTextField.text ?? "Test")
        
    }
    
    @IBAction func getJsonFromDbAction(_ sender: Any) {
        self.readmyJson(fileName:fileNameTextField.text ?? "Test")
    }
    
}

