//
//  FAAlertControllerHeaderView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/21/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


protocol FAAlertControllerHeaderViewDataSource {
    var title: String? { get set }
    var message: String? { get set }
    var textFields: [UITextField]? { get set }
    var items: [Pickable]? { get set }
}

protocol FAAlertControllerHeaderViewLayoutDataSource {
    var numberOfActions: Int { get }
}


class FAAlertControllerGradientView: UIView {
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        (layer as! CAGradientLayer).colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 0.045).cgColor]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.5, y: 0)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FAAlertControllerHeaderView: UIScrollView {
    
    static let horizontalInset: CGFloat = 16.0
    
    var title: String?
    var message: String?
    var items: [Pickable]?
    var pickerDelegate: FAAlertControllerDelegate?
    var textFields: [UITextField]?
    var stackViewSpacing: CGFloat {
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert:
            return 3.0
        case .actionSheet:
            return 12.0
        case .picker:
            return 20
        }
    }
    
    let layoutView = UIView(frame: .zero)
    let primaryStackView = UIStackView(arrangedSubviews: [UIView]())
    var labelStackView: UIStackView?
    var titleLabel: UILabel?
    var messageLabel: UILabel?
    var itemsView: UIView?
    var textFieldsView: FAAlertControllerTextFieldsView?
    var gradientView: FAAlertControllerGradientView?
    
    var stackViewTopConstraint: NSLayoutConstraint?
    var stackViewBottomConstraint: NSLayoutConstraint?
    var stackViewTopConstraintConstant: CGFloat {
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert, .picker:
            return primaryStackView.arrangedSubviews.isEmpty ? 0 : -20
        case .actionSheet:
            return primaryStackView.arrangedSubviews.isEmpty ? 0 : -14.5
        }
    }
    var stackViewBottomConstraintConstant: CGFloat {
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert:
            if let textFields = textFields {
                if !textFields.isEmpty {
                    return 0
                } else {
                    return 20.5
                }
            } else {
                return primaryStackView.arrangedSubviews.isEmpty ? 0 : 20.5
            }
        case .actionSheet:
            if primaryStackView.arrangedSubviews.isEmpty {
                return 0
            } else if FAAlertControllerAppearanceManager.sharedInstance.numberOfActions > 0 {
                return 24.5
            } else {
                return 14
            }
        case .picker:
            return 0
        }
    }
    
    var _maxWidth: CGFloat {
        return FAAlertControllerAppearanceManager.sharedInstance.maxWidth
    }
    var _titleFontSize: CGFloat {
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert, .picker:
            return 17
        case .actionSheet:
            return 13
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: _maxWidth).isActive = true
        
        // This is the primary "content view" for the scroll view
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // This view is used to layout the other subviews
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(layoutView)
        
        contentView.addSubview(layoutView)
        
        let constraint = heightAnchor.constraint(equalTo: layoutView.heightAnchor)
        constraint.priority = 750
        constraint.isActive = true
        
        let margin: CGFloat = FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .picker ? 0 : 16
        
        layoutView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        layoutView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        layoutView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        layoutView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // This view is used to arrange the other subviews
        primaryStackView.translatesAutoresizingMaskIntoConstraints = false
        primaryStackView.axis = .vertical
        primaryStackView.alignment = .center
        primaryStackView.distribution = .fill
        primaryStackView.spacing = stackViewSpacing
        layoutView.addSubview(primaryStackView)
        
        primaryStackView.widthAnchor.constraint(equalTo: layoutView.widthAnchor).isActive = true
        primaryStackView.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor).isActive = true
        stackViewTopConstraint = layoutView.topAnchor.constraint(equalTo: primaryStackView.topAnchor, constant: stackViewTopConstraintConstant)
        stackViewBottomConstraint = layoutView.bottomAnchor.constraint(equalTo: primaryStackView.bottomAnchor, constant: stackViewBottomConstraintConstant)
        
        stackViewTopConstraint!.isActive = true
        stackViewBottomConstraint!.isActive = true
        
        // If `preferredStyle == .picker`, then setup an additional stackview to place the title and message labels in
        if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .picker {
            
            let _layoutView = UIView(frame: .zero)
            _layoutView.translatesAutoresizingMaskIntoConstraints = false
            primaryStackView.addArrangedSubview(_layoutView)
            _layoutView.leadingAnchor.constraint(equalTo: primaryStackView.leadingAnchor, constant: 16).isActive = true
            _layoutView.trailingAnchor.constraint(equalTo: primaryStackView.trailingAnchor, constant: -16).isActive = true
            
            labelStackView = UIStackView(arrangedSubviews: [UIView]())
            labelStackView?.axis = .vertical
            labelStackView?.translatesAutoresizingMaskIntoConstraints = false
            labelStackView?.spacing = 3.0
            _layoutView.addSubview(labelStackView!)
            
            labelStackView?.leadingAnchor.constraint(equalTo: _layoutView.leadingAnchor).isActive = true
            labelStackView?.trailingAnchor.constraint(equalTo: _layoutView.trailingAnchor).isActive = true
            labelStackView?.topAnchor.constraint(equalTo: _layoutView.topAnchor).isActive = true
            labelStackView?.bottomAnchor.constraint(equalTo: _layoutView.bottomAnchor).isActive = true
        }
    }
    
    override func layoutSubviews() {
        
        if gradientView == nil {
            gradientView = FAAlertControllerGradientView(frame: CGRect(x: 0, y: frame.maxY - 2, width: frame.width, height: 2))
            addSubview(gradientView!)
            gradientView?.alpha = 0.0
        }
        
        super.layoutSubviews()
        
        contentSize = CGSize(width: frame.width, height: layoutView.frame.height)
        if layoutView.frame.height > frame.height {
            gradientView?.alpha = 1.0
        } else {
            gradientView?.alpha = 0.0
            gradientView!.removeFromSuperview()
            gradientView = nil
        }
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        stackViewTopConstraint?.constant = stackViewTopConstraintConstant
        stackViewBottomConstraint?.constant = stackViewBottomConstraintConstant
    }
    
    
    /// Creates the supplemental views, and adds them to the stackview
    func prepareForLayout() {
        
        if titleLabel == nil {
            if let _title = title {
                let color = FAAlertControllerAppearanceManager.sharedInstance.titleTextColor
                titleLabel = titleLabel(withText: _title, color: color)
                if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .picker {
                    guard labelStackView != nil else {
                        fatalError("The labelStackView should not be nil")
                    }
                    labelStackView!.addArrangedSubview(titleLabel!)
                } else {
                    primaryStackView.addArrangedSubview(titleLabel!)
                }
                setNeedsUpdateConstraints()
            }
        }
        
        if messageLabel == nil {
            if let _message = message {
                let color = FAAlertControllerAppearanceManager.sharedInstance.messageTextColor
                messageLabel = messageLabel(withText: _message, color: color)
                if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .picker {
                    guard labelStackView != nil else {
                        fatalError("The labelStackView should not be nil")
                    }
                    labelStackView!.addArrangedSubview(messageLabel!)
                } else {
                    primaryStackView.addArrangedSubview(messageLabel!)
                }
                setNeedsUpdateConstraints()
            }
        }
        
        if itemsView == nil {
            if let _items = items {
                let _itemsView = FAAlertControllerPickerView(items: _items)
                itemsView = _itemsView
                primaryStackView.addArrangedSubview(itemsView!)
                itemsView!.leadingAnchor.constraint(equalTo: primaryStackView.leadingAnchor).isActive = true
                itemsView!.trailingAnchor.constraint(equalTo: primaryStackView.trailingAnchor).isActive = true
                setNeedsUpdateConstraints()
            }
        }
        
        if textFieldsView == nil {
            if let _textFields = textFields {
                textFieldsView = FAAlertControllerTextFieldsView(withTextFields: _textFields)
                primaryStackView.addArrangedSubview(textFieldsView!)
                textFieldsView!.leadingAnchor.constraint(equalTo: primaryStackView.leadingAnchor).isActive = true
                textFieldsView!.leadingAnchor.constraint(equalTo: primaryStackView.leadingAnchor).isActive = true
                setNeedsUpdateConstraints()
            }
        }
        
    }
    
    func createLabel() -> UILabel {
        let _label = UILabel(frame: .zero)
        _label.preferredMaxLayoutWidth = _maxWidth - (FAAlertControllerHeaderView.horizontalInset * 2)
        _label.setContentCompressionResistancePriority(1000, for: .vertical)
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.setContentHuggingPriority(1000, for: .vertical)
        _label.numberOfLines = 0
        _label.textAlignment = .center
        return _label
    }
    
    func titleLabel(withText text: String, color: UIColor) -> UILabel {
        var font: UIFont? = nil
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert, .picker:
            font = UIFont.preferredFont(forTextStyle: .headline)
        case .actionSheet:
            let textStyle = UIFontTextStyle("UICTFontTextStyleEmphasizedFootnote")
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }
        let _label = createLabel()
        _label.font = font
        _label.textColor = color
        _label.text = text
        _label.sizeToFit()
        return _label
    }
    
    func messageLabel(withText text: String, color: UIColor) -> UILabel {
        var font: UIFont? = nil
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert, .picker:
            let textStyle = UIFontTextStyle("UICTFontTextStyleShortFootnote")
            font = UIFont.preferredFont(forTextStyle: textStyle)
        case .actionSheet:
            font = UIFont.preferredFont(forTextStyle: .footnote)
        }
        let _label = createLabel()
        _label.font = font
        _label.textColor = color
        _label.text = text
        _label.sizeToFit()
        return _label
    }
    
}
