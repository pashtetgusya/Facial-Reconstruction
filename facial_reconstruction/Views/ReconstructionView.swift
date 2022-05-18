//
//  ReconstructionView.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import UIKit

class ReconstructionView: UIView {
    
//    Пикер для работы с камерой и галереей
    let sketchImagePicker = UIImagePickerController()

//    Стак вью, в которых хранятся вью кнопок и изображений
    lazy var buttonsStackView = UIStackView()
    lazy var imagesStackView = UIStackView()
    
//    Кнопки
    lazy var uploadNewSketchButton = UIButton()
    lazy var sendSketchForProcessingButton = UIButton()
    lazy var sendSketchForReconstructionButton = UIButton()
    lazy var goToDrawScetchScreenButtin = UIButton()
//    lazy var goToSettingsScreenButton = UIButton()

//    Вью для отображения изображений
    lazy var sketchImageView = UIImageView()
    lazy var reconstructedImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterface() {
//        backgroundColor = #colorLiteral(red: 0.6423236132, green: 0.2392926514, blue: 0.3226928711, alpha: 1)
        backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.1960784314, blue: 0.3019607843, alpha: 1)
        
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(uploadNewSketchButton)
        buttonsStackView.addArrangedSubview(sendSketchForProcessingButton)
        buttonsStackView.addArrangedSubview(sendSketchForReconstructionButton)
        buttonsStackView.addArrangedSubview(goToDrawScetchScreenButtin)
//        buttonsStackView.addArrangedSubview(goToSettingsScreenButton)drawnImage
        
        addSubview(imagesStackView)
        imagesStackView.addArrangedSubview(sketchImageView)
        imagesStackView.addArrangedSubview(reconstructedImageView)

        setupImageStackView()
        setupButtons()
        setupButtonsStackView()
    }
    
    private func setupImageStackView() {
        imagesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesStackView.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.heightAnchor),
            imagesStackView.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
            imagesStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imagesStackView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -8),
            imagesStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            imagesStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
        
        imagesStackView.axis = .vertical
        imagesStackView.alignment = .fill
        imagesStackView.distribution = .fillEqually
        imagesStackView.spacing = 5

        for imageView in imagesStackView.subviews {
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = .white
        }

    }
    
    private func setupButtons() {
        uploadNewSketchButton.setImage(UIImage(systemName: "camera"), for: .normal)
        sendSketchForProcessingButton.setImage(UIImage(systemName: "wand.and.stars.inverse"), for: .normal)
        sendSketchForReconstructionButton.setImage(UIImage(systemName: "lasso.and.sparkles"), for: .normal)
        goToDrawScetchScreenButtin.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//        goToSettingsScreenButton.setImage(UIImage(systemName: "gear"), for: .normal)
    }
    
    private func setupButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonsStackView.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 5

        for button in buttonsStackView.subviews {
            button.tintColor = .white
            button.backgroundColor =  #colorLiteral(red: 0.568627451, green: 0.1647058824, blue: 0.2549019608, alpha: 1)
            button.layer.borderWidth = 1
            button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            button.layer.cornerRadius = 10
        }

    }
    
    func setupButtonSelector(button: UIButton, selector: Selector) {
        button.addTarget(nil, action: selector, for: .touchUpInside)
    }
}
