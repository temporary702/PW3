//
//  WishMakerViewController.swift
//  eapakhomovPW2
//
//  Created by Home on 05.11.2024.
//

import UIKit

enum Constants {
    static let alphaval: Double = 1.0
    static let maxRGB: Double = 255.0
    
    static let sliderMin: Double = 0
    static let sliderMax: Double = 255.0
    
    static let red: String = "Red"
    static let green: String = "Green"
    static let blue: String = "Blue"
    
    static let stackRadius: CGFloat = 20
    static let stackBottom: CGFloat = -40
    static let stackLeading: CGFloat = 20
    
    static let sliderLeading: CGFloat = 20
    static let sliderBottom: CGFloat = -10
    static let sliderTitleTop: CGFloat = 10
    
    static let titleLeading: CGFloat = 20
    static let titleTop: CGFloat = 30
    
    static let descLeading: CGFloat = 20
    static let descTop: CGFloat = 80
    
    static let mesg: String = "Enter your color wish"
    static let title: String = "WishMaker"
    
    static let buttonHeight: CGFloat = 50
    static let buttonBottom: CGFloat = -20
    static let buttonWidth: CGFloat = 362
    static let buttonText: String = "Add wish"
    static let buttonRadius: CGFloat = 20
    
    static let tableCornerRadius: CGFloat = 20
    static let tableOffset: CGFloat = 10
    
    static let wishesKey: String = "Wishes";
}

final class WishMakerViewController: UIViewController {
    
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        configureTitle()
        configureDescription()
        addWishButtonPressed()
        configureSliders()
        configureAddWishButton()
    }
    
    private func configureTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.title
        title.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        title.textColor = .systemIndigo
        title.shadowOffset = .init(width: 3, height: 2)
        title.shadowColor = .systemGray
        
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: Constants.titleLeading),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    private func configureDescription() {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.mesg
        description.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        description.textColor = .systemGray
        
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descLeading),
            description.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.descTop)
        ])
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(
            title: Constants.red,
            min: Constants.sliderMin,
            max: Constants.sliderMax)
        let sliderGreen = CustomSlider(
            title: Constants.green,
            min: Constants.sliderMin,
            max: Constants.sliderMax)
        let sliderBlue = CustomSlider(
            title: Constants.blue,
            min: Constants.sliderMin,
            max: Constants.sliderMax)
        
        stack.addArrangedSubview(sliderRed)
        stack.addArrangedSubview(sliderGreen)
        stack.addArrangedSubview(sliderBlue)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: -Constants.buttonHeight - Constants.buttonBottom + Constants.stackBottom - 15)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: CGFloat(value) / Constants.maxRGB,
                green: CGFloat(sliderGreen.slider.value) / Constants.maxRGB,
                blue: CGFloat(sliderBlue.slider.value) / Constants.maxRGB,
                alpha: Constants.alphaval)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: CGFloat(sliderRed.slider.value) / Constants.maxRGB,
                green: CGFloat(value) / Constants.maxRGB,
                blue: CGFloat(sliderBlue.slider.value) / Constants.maxRGB,
                alpha: Constants.alphaval)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: CGFloat(sliderBlue.slider.value) / Constants.maxRGB,
                green: CGFloat(sliderGreen.slider.value) / Constants.maxRGB,
                blue: CGFloat(value) / Constants.maxRGB,
                alpha: Constants.alphaval)
        }
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.buttonBottom),
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            addWishButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
        addWishButton.backgroundColor = .white
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        addWishButton.setTitleColor(.red, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor,
                                           constant: Constants.sliderTitleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Constants.sliderLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor,
                                           constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: Constants.sliderLeading)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
