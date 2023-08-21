//
//  HTTPStatusMessage.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

struct HTTPStatusMessage{
    let statusCode : Int
    
    
    func get() -> String {
        switch statusCode {
        case 100:
            return "Continue"
        case 101:
            return "Switching Protocols"
        case 200:
            return "OK - Request Successful"
        case 201:
            return "Created - Resource Created Successfully"
        case 202:
            return "Accepted - Request Accepted, Processing Ongoing"
        case 204:
            return "No Content - Request Successful, No Response Body"
        case 206:
            return "Partial Content - Partial Response"
        case 300:
            return "Multiple Choices - Multiple Options for Resource"
        case 301:
            return "Moved Permanently - Resource Moved Permanently"
        case 302:
            return "Found - Resource Found"
        case 304:
            return "Not Modified - Resource Not Modified"
        case 307:
            return "Temporary Redirect - Temporary Redirect to Different Resource"
        case 400:
            return "Bad Request - Invalid Request Syntax"
        case 401:
            return "Unauthorized - Authentication Required"
        case 403:
            return "Forbidden - Access Denied"
        case 404:
            return "Not Found - Resource Not Found"
        case 405:
            return "Method Not Allowed - Request Method Not Supported"
        case 408:
            return "Request Timeout - Request Timed Out"
        case 500:
            return "Internal Server Error - Server Error"
        case 501:
            return "Not Implemented - Requested Functionality Not Supported"
        case 502:
            return "Bad Gateway - Invalid Response from Upstream Server"
        case 503:
            return "Service Unavailable - Server Temporarily Unavailable"
        default:
            return "Unknown Status Code"
        }
        
    }
}
