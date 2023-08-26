//
//  MultipartFile.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/25/23.
//

import Foundation
import SwiftUI

class Multipart{
    
    let boundry = "Boundry-\(UUID().uuidString)"
    func getContentType() -> String{
        return "multipart/form-data; boundry=" + boundry
    }
    func fromDataBody(image : UIImage) -> Data{
        let fromName = ApplicationCache.loggedInUser?.name ?? "nullUser"
        let lineBreak = "\r\n"
        var body = Data()
        
        body.append("--\(boundry + lineBreak)")
        body.append("Content-Disposition: form-data;name=\"fromName\"\(fromName + lineBreak)")
        body.append("\(fromName + lineBreak)")
        
        // Process image data
        if let imageUUID = UUID().uuidString.components(separatedBy: "-").first{
            body.append("--\(boundry + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"imageUploads\";filename=\"\(imageUUID).jpg\"\(lineBreak)")
            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
            body.append(image.jpegData(compressionQuality: 0.99)!)
            body.append(lineBreak)
        }
        
        body.append("--\(boundry)--\(lineBreak)")
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
