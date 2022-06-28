//
//  ReconstructionController.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import UIKit


class ReconstructionController: UIViewController {

    let reconstructionView = ReconstructionView()
    let sketchDravingController = SketchDrawingController()
    
    let sketchImage = Image()
    let reconstructedImage = Image()
    
    private var sideMenuShadowView = UIView()
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    override func loadView() {
        view = reconstructionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.reconstructionView.setupButtonSelector(
            button: self.reconstructionView.uploadNewSketchButton,
            selector: #selector(uploadSketchImage(_:))
        )
        self.reconstructionView.setupButtonSelector(
            button: self.reconstructionView.sendSketchForProcessingButton,
            selector: #selector(sendSketchToProcessing(_:))
        )
        self.reconstructionView.setupButtonSelector(
            button: self.reconstructionView.sendSketchForReconstructionButton,
            selector: #selector(sendSketchToReconstruction(_:))
        )
        self.reconstructionView.setupButtonSelector(
            button: self.reconstructionView.goToDrawScetchScreenButtin,
            selector: #selector(showSketchDrawingView(_:))
        )
    }
    
    override func viewWillLayoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            reconstructionView.imagesStackView.axis = .horizontal
        } else {
            reconstructionView.imagesStackView.axis = .vertical
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func uploadSketchImage(_ sender: UIButton) {
        let allert = UIAlertController(
            title: "Загрузка скетча",
            message: "Пожалуйста сделайте новое фото или загрузите скетч из галереии",
            preferredStyle: .actionSheet
        )

        let selectCameraAction = UIAlertAction(title: "Камера", style: .default) {_ in
            self.reconstructionView.sketchImagePicker.delegate = self
            self.reconstructionView.sketchImagePicker.sourceType = .camera
            self.reconstructionView.sketchImagePicker.allowsEditing = true
            
            self.present(self.reconstructionView.sketchImagePicker, animated: true)
        }
        let selectGalleryAction = UIAlertAction(title: "Галерея", style: .default) {_ in
            self.reconstructionView.sketchImagePicker.delegate = self
            self.reconstructionView.sketchImagePicker.sourceType = .photoLibrary
            self.reconstructionView.sketchImagePicker.allowsEditing = true
            
            self.present(self.reconstructionView.sketchImagePicker, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        allert.addAction(selectCameraAction)
        allert.addAction(selectGalleryAction)
        allert.addAction(cancelAction)
        
        present(allert, animated: true)

    }
    
    @objc func sendSketchToProcessing(_ sender: UIButton) {
        let sendSketchInfo = [
            "image": sketchImage.convertImageToBase64String(image: sketchImage.image),
            "width": sketchImage.width.description,
            "height": sketchImage.height.description,
        ]
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: sendSketchInfo, options: [])
        
        ApiManager.shared.sendImageForProcessing(httpBodyParametrs: httpBodyParametrs!){ processedScetchInfo in
            DispatchQueue.main.async {
                self.sketchImage.image = self.sketchImage.convertBase64StringToImage(imageString: (processedScetchInfo.data?.content)!)
                self.sketchImage.width = (processedScetchInfo.data?.width)!
                self.sketchImage.height = (processedScetchInfo.data?.height)!
                
                self.reconstructionView.sketchImageView.image = self.sketchImage.image
            }
        }
    }
    
    @objc func sendSketchToReconstruction(_ sender: UIButton) {
        let sendSketchInfo = [
            "image": sketchImage.convertImageToBase64String(image: sketchImage.image),
            "width": sketchImage.width.description,
            "height": sketchImage.height.description,
        ]
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: sendSketchInfo, options: [])
        
        ApiManager.shared.sendImageForReconstruction(httpBodyParametrs: httpBodyParametrs!){ reconstructedImageInfo in
            DispatchQueue.main.async {
                self.reconstructedImage.image = self.sketchImage.convertBase64StringToImage(imageString: (reconstructedImageInfo.data?.content)!)
                self.reconstructedImage.width = (reconstructedImageInfo.data?.width)!
                self.reconstructedImage.height = (reconstructedImageInfo.data?.height)!
                
                self.reconstructionView.reconstructedImageView.image = self.reconstructedImage.image
            }
        }
    }
    
    @objc func showSketchDrawingView(_ sender: UIButton) {
        sketchDravingController.doAfterDrawing = { [self] drawnImage in
            self.reconstructionView.sketchImageView.image = drawnImage
            sketchImage.image = drawnImage
            sketchImage.width = Int(drawnImage.size.width.exponent)
            sketchImage.height = Int(drawnImage.size.height)
        }
        
        sketchDravingController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(sketchDravingController, animated: true)
    }
}

extension ReconstructionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.reconstructionView.sketchImageView.image = image
            sketchImage.image = image
            sketchImage.width = Int(image.size.width.exponent)
            sketchImage.height = Int(image.size.height)
        } else if let image = info[.originalImage] as? UIImage {
            self.reconstructionView.sketchImageView.image = image
            sketchImage.image = image
            sketchImage.width = Int(image.size.width)
            sketchImage.height = Int(image.size.height)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
