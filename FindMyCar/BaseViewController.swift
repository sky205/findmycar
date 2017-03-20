//
//  BaseViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/9.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

typealias MessageAction = () -> Void;

class BaseViewController: UIViewController {
    
    var className: String = "";
    
    weak var waitingController: WaitingViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.className = String(describing: type(of: self));
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("\(self.className) is deinit");
    }
    
    
    //MARK SYNC FUNC
    func delay(_ second: Int, action: @escaping MessageAction) {
        let delayTime = DispatchTime.now()+DispatchTimeInterval.seconds(second)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: action);
    }
    
    func async(_ queue: DispatchQueue? = nil, action: @escaping MessageAction) {
        if let queue = queue {
            queue.async {
                action();
            }
        } else {
            DispatchQueue.main.async {
                action();
            }
        }
    }
    
    
    //MARK ShowMessage Func
    func showMessage(_ title: String, message: String?) {
        self.showMessage(title, message: message) { 
            
        }
    }
    
    func showMessage(_ title: String, message: String?, done: @escaping MessageAction) {
        
        self.showMessage(title, message: message, isShowCancel: false, done: done) { 
            
        }
    }
    
    func showMessage(_ title: String, message: String?, isShowCancel: Bool = true, done: @escaping MessageAction, cancel: @escaping MessageAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let doneAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { (action) in
            done();
        });
        alert.addAction(doneAction);
        
        if isShowCancel {
            let action = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (aciton) in
                cancel();
            })
            alert.addAction(action);
        }
        
        self.present(alert, animated: true, completion: nil);
        
    }
    
    //MARK: SHOW/CLOSE WaitingController
    func showWaitingView(message: String) {
        if let controller = self.waitingController {
            controller.message = message;
        } else {
            self.waitingController = self.getController(WaitingViewController.classForCoder()) as? WaitingViewController;
            self.waitingController?.message = message;
            self.addChildViewController(self.waitingController!);
            self.view.addSubview(self.waitingController!.view);
            self.waitingController?.view.alpha = 0;
            self.waitingController?.startShowMessage();
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.waitingController?.view.alpha = 1;
            })
            
        }
    }
    
    
    func closeWaitingView() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.waitingController?.view.alpha = 0;
        }) { (complete) in
            self.waitingController?.viewWillDisappear(false);
            self.waitingController?.view.removeFromSuperview();
            self.waitingController?.removeFromParentViewController();
            self.waitingController?.didMove(toParentViewController: self);
            self.waitingController = nil;
        }
    }
    
    
    
    func goBack(animated: Bool = true) {
        if self.navigationController != nil {
            _ = self.navigationController?.popViewController(animated: animated);
        } else {
            self.dismiss(animated: animated, completion: nil);
        }
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated);
    }
    
    func getController(_ controller: AnyClass) -> UIViewController {
        let className = NSStringFromClass(controller).components(separatedBy: ".").last!;
        let controllerObject = self.storyboard!.instantiateViewController(withIdentifier: className);
        return controllerObject;
    }
    
    
}


