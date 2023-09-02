//
//  MultipartFile.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/25/23.
//

import Foundation
import SwiftUI

final class MultipartImageFile{
    
    let boundary = "example.neupanesushant.boundary.\(ProcessInfo.processInfo.globallyUniqueString)"
    
    func getContentType() -> String{
        return "multipart/form-data; boundary=\(boundary)"
    }
    func fromDataBody(image : UIImage) -> Data{
        
        let fromName = ApplicationCache.loggedInUser?.name ?? "nullUser"
        let lineBreak = "\r\n"
        var body = Data()
        
        guard let imageData = image.jpegData(compressionQuality: 0.99) else {return body}

        if let imageUUID = UUID().uuidString.components(separatedBy: "-").first{
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"upload_image\"; filename=\"\(imageUUID).jpeg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        }
        
        return body;
    }
}

extension Data{
    mutating func append(_ string : String){
        if let data = string.data(using: .utf8){
            self.append(data)
        }
    }
}
