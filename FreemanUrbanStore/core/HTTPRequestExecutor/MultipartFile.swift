//
//  MultipartFile.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/25/23.
//

import Foundation
import SwiftUI

final class MultipartImageFile{
    
    let boundary = "Boundary-\(UUID().uuidString)"
    
    func getContentType() -> String{
        return "multipart/form-data; boundary=\(boundary)"
    }
    
    func generateRequest(httpBody : Data) -> URLRequest{
        var request = URLRequest(url: URL(string : Constants.BASE_URL + "/image/")!)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue(getContentType(), forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func multipartFormDataBody(_ fromName:String, _ images:[UIImage]) -> Data{
        let lineBreak = "\r\n"
        var body = Data()
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(fromName)\"\(lineBreak + lineBreak)")
        body.append("\(fromName + lineBreak)")
        
        for image in images{
            if let uuid = UUID().uuidString.components(separatedBy: "-").first{
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fromName)_\(uuid).jpg\"\(lineBreak)")
                body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                body.append(image.jpegData(compressionQuality: 0.99)!)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        
        return body
    }
}

extension Data{
    mutating func append(_ string : String){
        if let data = string.data(using: .utf8){
            self.append(data)
        }
    }
}
