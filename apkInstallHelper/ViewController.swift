//
//  ViewController.swift
//  apkInstallHelper
//
//  Created by Zhangbeiyi on 2016/12/15.
//  Copyright © 2016年 Zhangbeiyi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var apkPath = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.info.textColor = NSColor(calibratedRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        self.info.stringValue =
        "Before install your APP, please make sure: \n - USB debugging is enabled \n\n After press install button, you need:\n - Allow USB debugging, press \"install\" again \n - Allow install the app"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBOutlet weak var filePath: NSTextField!
    
    @IBOutlet weak var info: NSTextField!
    
    @IBAction func link(_ sender: Any) {
        let guideUrl = URL(string: "https://github.com/Beiyi/apk_install_helper/tree/master/guide")
        NSWorkspace.shared().open(guideUrl!)
    }
    
    @IBAction func selectFile(_ sender: Any) {
        let dialog = NSOpenPanel();
        dialog.title = "Select apk file"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["apk"]
        if (dialog.runModal() == NSModalResponseOK){
            let result = dialog.url
            
            if(result != nil){
                apkPath = result!.path
                filePath.stringValue = apkPath
            }
            else{
                return
            }
        }
    }
    @IBAction func installApk(_ sender: NSButton) {
        let adbPath = "/Applications/Apk Install Helper/adb"
        let adbCmd = "install"
        let arguments = [adbCmd,apkPath]
        sender.isEnabled = false
        let task = Process.launchedProcess(launchPath: adbPath, arguments: arguments)
        task.waitUntilExit()
        sender.isEnabled = true
    }

}

