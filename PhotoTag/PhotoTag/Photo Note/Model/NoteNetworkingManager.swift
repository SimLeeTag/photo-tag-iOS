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
        var request = URLRequest(baseUrl: endpoint, method: .post)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // memo Text Data
        let rawMemo = ["rawMemo": text]
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(rawMemo) else { return }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        let textData: [String: String] = ["request": jsonString]
        
        var httpBody = Data()
        
        for (key, value) in textData {
            httpBody.append(convertFormField(named: key, value: value, using: boundary))
        }
        
        // photo Image Data
        for image in images {
            guard let imageData = image.pngData() else { return }
            httpBody.append(convertFileData(fieldName: "file", fileName: "photo.png", mimeType: "image/png", fileData: imageData, using: boundary))
            httpBody.append("--\(boundary)--") // add final boundary with the two trailing dashes
            request.httpBody = httpBody
        }
        
        // request
        NetworkManager.shared.session.uploadTask(with: request, from: httpBody) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if httpResponse.statusCode == 200 {
                completion(true)
                return
            }
           completion(false)
        }
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
        var data = Data()
        
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.append("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.append("\r\n")
        
        return data
    }
}

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
