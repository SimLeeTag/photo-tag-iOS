//
//  NoteNetworkingManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/10.
//

import Foundation
import Combine
import UIKit.UIImage

final class NoteNetworkingManager {
    
    func createNote(with text: String, images: [UIImage], completion: @escaping(Any?, Error?, Bool) -> Void) {

        let parameters = ["rawMemo" : text]
        let stringUrl = Endpoint(path: .createNote).url
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = stringUrl else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        for(key, value) in parameters {
            // Add the reqtype field and its value to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)".data(using: .utf8)!)
        }
        
        for (index, imageData) in images.enumerated() {
            // Add the image data to the raw http request data
            let key = "photos"
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(Data())\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(imageData.pngData()!)
        }
        
        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: request, from: data, completionHandler: { data, response, error in
            
            if let checkResponse = response as? HTTPURLResponse {
                if checkResponse.statusCode == 200 {
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                        completion(nil, error, false)
                        return
                    }
                    let jsonString = String(data: data, encoding: .utf8)!
                    print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                    print(json)
                    completion(json, nil, true)
                } else {
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                        completion(nil, error, false)
                        return
                    }
                    let jsonString = String(data: data, encoding: .utf8)!
                    print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                    print(json)
                    completion(json, nil, false)
                }
            } else {
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion(nil, error, false)
                    return
                }
                completion(json, nil, false)
            }
            
        }).resume()
        
    }
}

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
