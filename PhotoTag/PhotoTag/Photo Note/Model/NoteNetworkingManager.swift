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
    
    private let decoder: JSONDecoder = .init()
    
    // fetch notes list
    func fetchNoteList(tagIds: [TagID],
                       completionHandler: @escaping ([PhotoNote]?) -> Void) {
        UseCase.shared
            .request(type: [PhotoNote].self,
                     urlComponents: Endpoint.fetchPhotoList(tagIds: tagIds), method: .get)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [ weak self ] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
            }, receiveValue: { [ weak self ] data in
                completionHandler(data)
            }))
    }
    
    // get selected note data
    func fetchNote(noteId: NoteID,
                   completionHandler: @escaping (PhotoNote?) -> Void) {
        UseCase.shared.request(noteId: noteId)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [ weak self ] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
            }, receiveValue: { [weak self] data in
                completionHandler(data)
            }))
    }
    
    // create note
    func createNote(with text: NoteText,
                    images: [NoteImage],
                    completion: @escaping(Bool) -> Void) {
        
        let boundary = generateBoundaryString()
        guard let endpoint = Endpoint(path: .createNote).url else { return }
        var request = URLRequest(urlWithToken: endpoint, method: .post)
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
            httpBody.append(convertFileData(fieldName: "file", fileName: "\(Date().millisecondsSince1970)_photo.jpg", mimeType: "multipart/form-data", fileData: imageData, using: boundary))
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
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false)
                return
            }
           completion(true)
        }))
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
}

extension NoteNetworkingManager {
    private func convertFormField(named name: String,
                                  value: String,
                                  using boundary: String) -> String {
        let mimeType = "application/json"
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: \(mimeType)\r\n\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    private func convertFileData(fieldName: String,
                                 fileName: String,
                                 mimeType: String,
                                 fileData: Data,
                                 using boundary: String) -> Data {
        let data = NSMutableData()
        
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        
        return data as Data
    }
}
