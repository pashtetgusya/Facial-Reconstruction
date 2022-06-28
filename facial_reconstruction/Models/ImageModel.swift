//
//  FaceImageModel.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import Foundation
import UIKit

protocol ImageProtocol {
    var image: UIImage { get set }
    var width: Int { get set }
    var height: Int { get set }
    
    func convertImageToBase64String(image: UIImage) -> String
    func convertBase64StringToImage(imageString: String) -> UIImage
}

class Image: ImageProtocol {
    var image: UIImage = UIImage()
    var width: Int = 0
    var height: Int = 0
    
    func convertImageToBase64String(image: UIImage) -> String {
        let imageData: NSData = image.jpegData(compressionQuality: 1.0)! as NSData
        let imageString = imageData.base64EncodedString()
        
        return imageString
    }
    
    func convertBase64StringToImage(imageString: String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageString)
        let image = UIImage(data: imageData!)
        
        return image!
    }
}
