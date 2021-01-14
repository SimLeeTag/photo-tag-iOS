//
//  NoteNetworkingManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/10.
//

import Foundation
import Combine
import UIKit.UIImage

struct TextNote: Codable {
    let rawMemo: String
}

final class NoteNetworkingManager {
    
    func createNote(with text: String,
                    images: [UIImage],
                    completion: @escaping(Bool) -> Void) {
        
        let boundary = generateBoundaryString()
        guard let endpoint = Endpoint(path: .createNote).url else { return }
        var request = URLRequest(url: endpoint, method: .post)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // memo Text Data
        let rawMemo = ["rawMemo": text]
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(rawMemo) else { return }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        let textData: [String: String] = ["request": jsonString]
        
        var httpBody = NSMutableData()
        
        for (key, value) in textData {
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
        }
        
        // photo Image Data
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
            httpBody.append(convertFileData(fieldName: "file", fileName: "photo.jpg", mimeType: "multipart/form-data", fileData: imageData, using: boundary))
        }
        httpBody.appendString("--\(boundary)--")  // add final boundary with the two trailing dashes
        request.httpBody = httpBody as Data
        
        // request
        UseCase.shared
            .request(request: request)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
            guard case let .failure(error) = $0 else { return }
            debugPrint(error.message)
            // TODO: - present alertController
        }, receiveValue: { [weak self] response in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if httpResponse.statusCode == 200 {
                completion(true)
            }
           completion(false)
        }))
        
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private func convertFormField(named name: String,
                                  value: String,
                                  using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    private func convertFileData(fieldName: String,
                                 fileName: String,
                                 mimeType: String,
                                 fileData: Data,
                                 using boundary: String) -> Data {
        var data = NSMutableData()
        
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        
        return data as Data
    }
}

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
