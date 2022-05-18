//
//  SketchDrawingView.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import UIKit

class SketchDrawingView: UIView {
    
    lazy var buttonsStackView = UIStackView()
    lazy var clearButton = UIButton()
    lazy var goToBackButton = UIButton()
    
    lazy var brushThicknessValue = UILabel()
    lazy var brushThicknessSlider = UISlider()

    lazy var skethImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterface() {
        backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.1960784314, blue: 0.3019607843, alpha: 1)
        
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(goToBackButton)
        buttonsStackView.addArrangedSubview(clearButton)
        
        addSubview(skethImageView)
        
        addSubview(brushThicknessValue)
        addSubview(brushThicknessSlider)
        
        setupButtonsStackView()
        setupButtons()
        setupImageView()
        setupLabel()
        setupSlider()
    }
    
    private func setupButtons() {
        goToBackButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        goToBackButton.tintColor = .white
        
        clearButton.setImage(UIImage(systemName: "trash"), for: .normal)
        clearButton.tintColor = .white
    }
    
    private func setupButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonsStackView.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
//            buttonsStackView.bottomAnchor.constraint(equalTo: skethImageView.topAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 5
    }

    private func setupImageView() {
        skethImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skethImageView.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
            skethImageView.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
//            skethImageView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
//            skethImageView.bottomAnchor.constraint(equalTo: brushThicknessSlider.topAnchor),
            skethImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            skethImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            skethImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        skethImageView.layer.borderWidth = 1
        skethImageView.layer.cornerRadius = 10
        skethImageView.backgroundColor = .white
    }
    
    private func setupLabel() {
        brushThicknessValue.translatesAutoresizingMaskIntoConstraints = false
        brushThicknessValue.textColor = .white
        brushThicknessValue.text = "5"
        NSLayoutConstraint.activate([
//            brushThicknessValue.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.heightAnchor),
//            brushThicknessValue.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
//            brushThicknessSlider.topAnchor.constraint(equalTo: skethImageView.bottomAnchor),
            brushThicknessValue.bottomAnchor.constraint(equalTo: brushThicknessSlider.topAnchor),
            brushThicknessValue.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
//            brushThicknessValue.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
//            brushThicknessValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),

        ])
    }
    
    private func setupSlider() {
        brushThicknessSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            brushThicknessSlider.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.heightAnchor),
            brushThicknessSlider.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor),
//            brushThicknessSlider.topAnchor.constraint(equalTo: skethImageView.bottomAnchor),
            brushThicknessSlider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            brushThicknessSlider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            brushThicknessSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),

        ])
        brushThicknessSlider.minimumValue = 1
        brushThicknessSlider.maximumValue = 10
        brushThicknessSlider.value = 5
        brushThicknessSlider.tintColor = .white
        brushThicknessSlider.minimumValueImage = UIImage(systemName: "1.square")
        brushThicknessSlider.maximumValueImage = UIImage(systemName: "10.square")
    }
    
    func setupButtonSelector(button: UIButton, selector: Selector) {
        button.addTarget(nil, action: selector, for: .touchUpInside)
    }

}
