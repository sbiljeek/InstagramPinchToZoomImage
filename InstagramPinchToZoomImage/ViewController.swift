//
//  ViewController.swift
//  InstagramPinchToZoomImage
//
//  Created by Salman Biljeek on 12/14/22.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemFill
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let image = UIImage(named: "image1") ?? UIImage()
        imageView.image = image
        let ratio = image.size.height / image.size.width
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch))
        pinch.delegate = self
        imageView.addGestureRecognizer(pinch)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio).isActive = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "image2")
            let imageHeight = CGFloat(30)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
            let profileImageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
            profileImageViewHeightConstraint.isActive = true
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageHeight / 2
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
            return imageView
        }()
        let usernameButton: UIButton = {
            var configuration = UIButton.Configuration.plain()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 15)
            container.foregroundColor = .label
            configuration.contentInsets = .zero
            configuration.attributedTitle = AttributedString("summer", attributes: container)
            let button = UIButton(configuration: configuration, primaryAction: nil)
            return button
        }()
        lazy var captionTextView: UITextView = {
            let textView = UITextView()
            textView.text = "In this guide we are building Instagram's pinch to zoom feature for images. We build this using a Pinch Gesture Recognizer"
            textView.font = .systemFont(ofSize: 14)
            textView.textColor = .label
            textView.textAlignment = .left
            textView.backgroundColor = .clear
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.isSelectable = true
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.textContainer.lineBreakMode = .byTruncatingTail
            return textView
        }()
        let optionsButton: UIButton = {
            let image = UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        let likeButton: UIButton = {
            let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.label).withConfiguration(UIImage.SymbolConfiguration(weight: .bold)) ?? UIImage()
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .zero
            configuration.image = image
            let button = UIButton(configuration: configuration, primaryAction: nil)
            return button
        }()
        let commentButton: UIButton = {
            let image = UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal).withTintColor(.label).withConfiguration(UIImage.SymbolConfiguration(weight: .bold)) ?? UIImage()
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .zero
            configuration.image = image
            let button = UIButton(configuration: configuration, primaryAction: nil)
            return button
        }()
        let shareButton: UIButton = {
            let image = UIImage(systemName: "paperplane")?.withRenderingMode(.alwaysOriginal).withTintColor(.label).withConfiguration(UIImage.SymbolConfiguration(weight: .bold)) ?? UIImage()
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .zero
            configuration.image = image
            let button = UIButton(configuration: configuration, primaryAction: nil)
            return button
        }()
        let bookmarkButton: UIButton = {
            let image = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.label).withConfiguration(UIImage.SymbolConfiguration(weight: .bold)) ?? UIImage()
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .zero
            configuration.image = image
            let button = UIButton(configuration: configuration, primaryAction: nil)
            return button
        }()
        let numberOfLikesLabel: UILabel = {
            let label = UILabel()
            label.text = "316 likes"
            label.textColor = .label
            label.font = .boldSystemFont(ofSize: 14)
            return label
        }()
        let timestampLabel: UILabel = {
            let label = UILabel()
            label.text = "14 minutes ago"
            label.textColor = .secondaryLabel
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        let usernameStack = UIStackView(arrangedSubviews: [
            usernameButton,
            UIView()
        ])
        usernameStack.axis = .horizontal
        usernameStack.spacing = 3
        usernameStack.alignment = .center
        
        let headerStack = UIStackView(arrangedSubviews: [
            profileImageView,
            usernameStack,
            UIView(),
            optionsButton
        ])
        headerStack.axis = .horizontal
        headerStack.spacing = 12
        headerStack.alignment = .center
        headerStack.layoutMargins = .init(top: 10, left: 16, bottom: 10, right: 16)
        headerStack.isLayoutMarginsRelativeArrangement = true
        
        let buttonsStack = UIStackView(arrangedSubviews: [
            likeButton,
            commentButton,
            shareButton,
            UIView(),
            bookmarkButton
        ])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 14
        buttonsStack.isLayoutMarginsRelativeArrangement = true
        buttonsStack.layoutMargins = .init(top: 4, left: 0, bottom: 0, right: 0)
        
        let numberOfLikesStack = UIStackView(arrangedSubviews: [
            numberOfLikesLabel,
            UIView()
        ])
        numberOfLikesStack.axis = .horizontal
        
        let topStack = UIStackView(arrangedSubviews: [
            buttonsStack,
            numberOfLikesStack
        ])
        topStack.axis = .vertical
        topStack.spacing = 8
        
        let footerStack = UIStackView(arrangedSubviews: [
            topStack,
            captionTextView,
            timestampLabel
        ])
        footerStack.axis = .vertical
        footerStack.spacing = 8
        footerStack.layoutMargins = .init(top: 8, left: 16, bottom: 12, right: 16)
        footerStack.isLayoutMarginsRelativeArrangement = true
        
        let mainView = UIStackView(arrangedSubviews: [
            headerStack,
            imageView,
            footerStack,
            UIView()
        ])
        mainView.axis = .vertical
        
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    weak var delegate: ZoomDelegate?
    var overlayView: UIView!
    let maxOverlayAlpha: CGFloat = 0.8
    let minOverlayAlpha: CGFloat = 0.2
    var initialCenter: CGPoint?
    var windowImageView: UIImageView?
    var startingRect = CGRect.zero
    
    @objc fileprivate func pinch(sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            let newScale = currentScale * sender.scale
            if newScale > 1 {
                guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                self.delegate?.zooming(started: true)
                overlayView = UIView.init(
                    frame: CGRect(x: 0, y: 0, width: (currentWindow.frame.size.width), height: (currentWindow.frame.size.height))
                )
                overlayView.backgroundColor = UIColor.black
                overlayView.alpha = CGFloat(minOverlayAlpha)
                currentWindow.addSubview(overlayView)
                initialCenter = sender.location(in: currentWindow)
                windowImageView = UIImageView.init(image: self.imageView.image)
                windowImageView?.contentMode = .scaleAspectFit
                windowImageView?.clipsToBounds = true
                windowImageView?.accessibilityIgnoresInvertColors = true
                let point = self.imageView.convert(imageView.frame.origin, to: nil)
                startingRect = CGRect(x: point.x/2, y: point.y/2, width: imageView.frame.size.width, height: imageView.frame.size.height)
                windowImageView?.frame = startingRect
                currentWindow.addSubview(windowImageView!)
                imageView.alpha = 0
            }
        } else if sender.state == .changed {
            guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), let initialCenter = initialCenter, let windowImageWidth = windowImageView?.frame.size.width else { return }
            let numberOfTouches = sender.numberOfTouches
            if numberOfTouches < 2 { return }
            let currentScale = windowImageWidth / startingRect.size.width
            let senderScale = (currentScale > 4) ? (sender.scale > 1) ? 1 : sender.scale : sender.scale
            let newScale = currentScale * senderScale
            overlayView.alpha = minOverlayAlpha + (newScale - 1) < maxOverlayAlpha ? minOverlayAlpha + (newScale - 1) : maxOverlayAlpha
            let centerXDif = initialCenter.x - sender.location(in: currentWindow).x
            let centerYDif = initialCenter.y - sender.location(in: currentWindow).y
            let zoomScale = (newScale * windowImageWidth >= imageView.frame.width) ? newScale : currentScale
            let transform = currentWindow.transform.scaledBy(x: zoomScale, y: zoomScale).translatedBy(x: -centerXDif, y: -centerYDif)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.windowImageView?.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            guard let windowImageView = self.windowImageView else { return }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut) {
                windowImageView.transform = CGAffineTransform.identity
                self.overlayView.alpha = 0
            } completion: { _ in
                windowImageView.removeFromSuperview()
                self.overlayView.removeFromSuperview()
                self.imageView.alpha = 1
                self.delegate?.zooming(started: false)
            }
        }
    }
}

protocol ZoomDelegate: AnyObject {
    func zooming(started: Bool)
}
