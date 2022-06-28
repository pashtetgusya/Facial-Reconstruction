//
//  ApiManager.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import Foundation

enum ApiType {
    
    case processingImage
    case reconstructionImage
    
    var baseURL: String {
        return "http://192.168.43.126:8000/service/"
    }
    
    var path: String {
        switch self {
        case .processingImage: return "image_process"
        case .reconstructionImage: return "network_process"
        }
    }
        
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        
        let urlConponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var request = URLRequest(url: (urlConponents?.url)!)
        
        switch self {
        case .processingImage:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            return request
        case .reconstructionImage:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            return request
        }
    }
}

class ApiManager {
    
    static let shared = ApiManager()
    
    func sendImageForProcessing(httpBodyParametrs: Data, completion: @escaping (ProcessedImage) -> Void) {
        var request = ApiType.processingImage.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let imageProcessingResult = try? JSONDecoder().decode(ProcessedImage.self, from: data) {
                completion(imageProcessingResult)
            }
        }
        task.resume()
    }

    func sendImageForReconstruction(httpBodyParametrs: Data, completion: @escaping (ReconstructedImage) -> Void) {
        var request = ApiType.reconstructionImage.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let imageReconstructionResult = try? JSONDecoder().decode(ReconstructedImage.self, from: data) {
                completion(imageReconstructionResult)
            }
        }
        task.resume()
    }
    
  }
