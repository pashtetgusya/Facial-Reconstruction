//
//  ProcessedImage.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import Foundation

// MARK: - ProcessedImage
struct ProcessedImage: Codable {
    let success: Bool?
    let data: ProcessedImageData?
    let error: String?
}

// MARK: - ProcessedImageData
struct ProcessedImageData: Codable {
    let width, height: Int?
    let mode, decoder, format, content: String?
}
