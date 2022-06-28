//
//  GeneratedImage.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import Foundation

// MARK: - ReconstructedImage
struct ReconstructedImage: Codable {
    let success: Bool?
    let data: ReconstructedImageData?
    let error: String?
}

// MARK: - ReconstructedImageData
struct ReconstructedImageData: Codable {
    let width, height: Int?
    let content: String?
}
