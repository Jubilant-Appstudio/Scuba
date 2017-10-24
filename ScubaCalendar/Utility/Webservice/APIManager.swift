//
//  APIManager.swift
//  CredDirectory
//
//  Created by Mahipal on 11/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit
import Foundation
import MobileCoreServices

@objc protocol APIManagerDelegate {
    /// This will return response from webservice if request successfully done to server
    func apiResponseSuccess(response: NSDictionary, apiIdentifier: String)
    
    /// This will return response from webservice if request fail to server
    func apiResponseFail(response: NSDictionary, apiIdentifier: String)
    
    /// This is for Fail request or server give any error
    func apiResponseError(error: Error?, apiIdentifier: String)
}

class APIManager: NSObject {
    
    var apiIdentifier: String = ""
    var strFileName: String = "default.pdf"
    static var downloadStatus = false
    lazy var session: Foundation.URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = false
        let session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    weak var delegate: APIManagerDelegate?
    
    func requestForURL(strUrl: String, httpMethod: String, parameters: String, includeHeader: Bool, apiIdentifier: String) {
        
        print(strUrl)
        print(httpMethod)
        print(parameters)
        
        self.apiIdentifier = apiIdentifier
        var request = URLRequest(url: URL(string: strUrl)!)
        request.httpMethod = httpMethod
        
        if httpMethod == "post" {
            request.httpBody = parameters.data(using: .utf8)
        }
        
        session.configuration.timeoutIntervalForRequest = 15.0
        session.configuration.timeoutIntervalForResource = 30.0
        
        session.configuration.timeoutIntervalForRequest = 1.0
        session.configuration.timeoutIntervalForResource = 1.0
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            if error != nil {
                
                if self.delegate != nil {
                    
                    self.delegate?.apiResponseError(error: error!, apiIdentifier: self.apiIdentifier)
                }
                
            } else {
                
                do {
                    
                    // ---------------------------------------------------------------
                    /*
                    
                    do {
                        if let resDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions .mutableContainers) as? NSDictionary {
                            print(resDictionary)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    do {
                        
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                        let currentConditions = parsedData?["data"]
                        
                        print(currentConditions ?? "")
                        
                        //let currentTemperatureF = currentConditions["temperature"] as! Double
                        //print(currentTemperatureF)
                    } catch let error as NSError {
                        print(error)
                    }
                    
                    
                    do {
                        let result = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments])
                        print(result) //-> -1
                    } catch {
                        print(error)
                    }
                    
                    do {
                        
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let currentConditions = parsedData["data"]
                        
                        print(currentConditions)
                        
                        //let currentTemperatureF = currentConditions["temperature"] as! Double
                        //print(currentTemperatureF)
                    } catch let error as NSError {
                        print(error)
                    }
                    
                    */
                    
                    // ---------------------------------------------------------------
                    
                    if let responseDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                        print(responseDictionary)
                        
                        if self.checkForValidResponse(responseDict: responseDictionary) {
                            
                            if let getSuccess = (responseDictionary.object(forKey: "success")) {
                                
                                if String(describing: getSuccess) == "1" {
                                    
                                    if self.delegate != nil {
                                        self.delegate?.apiResponseSuccess(response: responseDictionary, apiIdentifier: self.apiIdentifier)
                                    }
                                    
                                } else {
                                    
                                    if self.delegate != nil {
                                        self.delegate?.apiResponseFail(response: responseDictionary, apiIdentifier: self.apiIdentifier)
                                    }
                                    
                                }
                                                               
                            } else {
                                print("fail")
                                if self.delegate != nil {
                                    self.delegate?.apiResponseFail(response: responseDictionary, apiIdentifier: self.apiIdentifier)
                                }
                            }
                            
                        }
                    }
                } catch {
                    //let responseString = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                    if self.delegate != nil {
                        
                        self.delegate?.apiResponseError(error: nil, apiIdentifier: self.apiIdentifier)
                    }
                }
            }
        }
        task.resume()
        
    }
    
    func requestForFileDownload(strUrl: String, apiIdentifier: String, fileName: String) {
        self.apiIdentifier = apiIdentifier
        let url = URL(string: strUrl)!
        strFileName = fileName
        let req = URLRequest(url: url)
        let task = session.downloadTask(with: req)
        task.resume()
    }
    
    // MARK: - Other Methods
    func checkForValidResponse(responseDict: NSDictionary) -> Bool {
        if let status = responseDict.object(forKey: "code") as? Int, status == 400 {
            return false
        }
        return true
    }
    
}

extension APIManager: URLSessionDownloadDelegate {
    // MARK: - URLSession Download Delegate
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        
        let downloadPercentage = (Float(100*writ/exp))
        CommonMethods.hud.progress = downloadPercentage / 100
        CommonMethods.hud.label.text = "Resume Downloding... \(downloadPercentage)%"
        
        DispatchQueue.main.async(execute: {
            // CommonMethods.hud.progress = Float(100*writ/exp)
            return
        })
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("completed: error: \(error!)")
            if self.delegate != nil {
                self.delegate?.apiResponseError(error: error!, apiIdentifier: self.apiIdentifier)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print(location)
        
    /*
        // Create destination URL
        let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent(strFileName)
        
        // Remove File -----------------
        // -------------------------------------------------------------
        let fileManager = FileManager.default
        //let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path
        
        do {
            if let documentPath = String(documentsPath) {
                
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache: \(fileNames)")
                for fileName in fileNames {
                    
                    if fileName.hasSuffix(".pdf") {
                        let filePathName = "\(documentPath)/\(fileName)"
                        try fileManager.removeItem(atPath: filePathName)
                    }
                }
                
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache after deleting images: \(files)")
            }
            
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        
        // ---------------------------------
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationFileUrl)
        } catch (let writeError) {
            print("Error creating a file \(destinationFileUrl) : \(writeError)")
        }
        
        if self.delegate != nil {
            let responseDict = NSMutableDictionary()
            responseDict.setValue(200, forKey: "code")
            responseDict.setValue(destinationFileUrl, forKey: "filepath")
            self.delegate?.apiResponseSuccess(response: responseDict, apiIdentifier: self.apiIdentifier)
        }
        */
    }
}
