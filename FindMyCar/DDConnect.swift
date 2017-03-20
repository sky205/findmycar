//
//  DDConnect.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/9.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import Foundation
import UIKit

typealias ConnectComplete = (URLResponse?, Data?, Error?) -> Swift.Void;

class DDConnect {
    
    var task: URLSessionTask?;
    var request: URLRequest;
    var timeout: TimeInterval = 15;
    var headers: [AnyHashable: Any] = [AnyHashable: Any]();
    
    init(url: String) {
        self.request = URLRequest(url: URL(string: url)!);
    }
    
    init(request: URLRequest) {
        self.request = request;
    }
    
    init(request: URLRequest, headers: [String: Any]) {
        self.request = request;
        self.setHeaders(headers);
    }
    
    func setHeaders(_ headers: [String: Any]) {
        for (title, value) in headers {
            self.headers[title] = value;
        }
    }
    
    private func createConfigure() -> URLSessionConfiguration {
        let configure = URLSessionConfiguration.default;
        configure.timeoutIntervalForRequest = 15;
        configure.timeoutIntervalForResource = 15;
        configure.httpShouldSetCookies = true;
        configure.httpAdditionalHeaders = self.headers;
        
        return configure
    }
    
    private func createSession() -> URLSession {
        let configure = self.createConfigure();
        let session = URLSession(configuration: configure);
        return session;
    }
    
    
    
    func response(complete: @escaping ConnectComplete) {
        let session = self.createSession();
        self.task = session.dataTask(with: request) { (data, response, error) in
            complete(response, data, error);
            session.finishTasksAndInvalidate();
        }
        self.task?.resume();
    }
    
    func responseForImage(complete: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        let session = self.createSession();
        self.task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                complete(image, nil);
            } else {
                complete(nil, error);
            }
            session.finishTasksAndInvalidate();
        });
        self.task?.resume();
    }
    
    
    
}

