//
//  ViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/9.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBAction func newAction(_ sneder: AnyObject) {
        
//        let page = self.storyboard?.instantiateViewController(withIdentifier: "DDImagePickerController") as! DDImagePickerController;
//        self.navigationController?.pushViewController(page, animated: true);
        
        self.showMessage("go next?", message: nil, done: { 
            let page = self.storyboard?.instantiateViewController(withIdentifier: "DDImagePickerController") as! DDImagePickerController;
            self.navigationController?.pushViewController(page, animated: true);
        }) { 
            
        };
        
        
    }
    
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    var imageDictionary: ImageDictionary?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        self.imageDictionary = ImageDictionary(MAX_CACHE_NUMRIC: 100);
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        DDConnect(url: "https://m.ruten.com.tw/").response { [unowned self] (response, data, error) in
            if let data = data, error == nil {
                print("load https success!");
            } else {
                print(error?.localizedDescription);
            }
        }
        
    }
    
    
    
    func goCameraPage() {
        let cameraPage = UIImagePickerController(rootViewController: self);
        cameraPage.delegate = self;
        cameraPage.videoQuality = .typeHigh;
        cameraPage.sourceType = .camera;
        cameraPage.allowsEditing = false;
        self.present(cameraPage, animated: true) { 
            self.newButton.isEnabled = true;
        }
    }
    

}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            
        } else {
            
        }
    }
    
    
}

