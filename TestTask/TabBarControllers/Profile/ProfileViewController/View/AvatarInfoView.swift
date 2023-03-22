import UIKit

protocol AvatarInfoViewDelegate: AnyObject {
    func showViewController(_ viewController: UIViewController)
    func dismissImagePicker()
}

final class AvatarInfoView: UIView {
    
    weak var delegate: AvatarInfoViewDelegate?
    
    private enum Constants {
        static let profileLabelText = "Profile"
        static let changePhotoButtonTittle = "Change photo"
        static let uploadItemButtonTittle = "Upload item"
    }
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.text = Constants.profileLabelText
        return label
    }()
    
    private lazy var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.ttGray, for: .normal)
        button.setTitle(Constants.changePhotoButtonTittle, for: .normal)
        button.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 10)
        return button
    }()
    
    private lazy var profileFirstAndLastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var uploadItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ttPurple
        button.layer.cornerRadius = 18
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 70)
        button.tintColor = .ttLightGray
        button.setImage(UIImage(named: "UploadItem"), for: .normal)
        button.setTitleColor(.ttLightGray, for: .normal)
        button.setTitle(Constants.uploadItemButtonTittle, for: .normal)
        button.addTarget(self, action: #selector(uploadItemButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        return button
    }()
    
    init(frame: CGRect, imageURL: String?, profileName: String?) {
        super.init(frame: frame)
        profileFirstAndLastNameLabel.text = profileName
        setupView()
        
        if let imageURL = imageURL {
            profileAvatarImageView.image = UIImage(named: imageURL)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubviews()
        activateConstraints()
    }
    
    private func addSubviews() {
        addSubviews(
            profileLabel,
            profileAvatarImageView,
            changePhotoButton,
            profileFirstAndLastNameLabel,
            uploadItemButton
        )
    }
    
    private func activateConstraints() {
        
        let imageViewSide = frame.height / 10
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: frame.height / 3),
            widthAnchor.constraint(equalToConstant: frame.width),
            
            profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileLabel.topAnchor.constraint(equalTo: topAnchor),
            
            profileAvatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileAvatarImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: frame.height / 60),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: imageViewSide),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: imageViewSide),
            
            changePhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            changePhotoButton.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 5),
            
            profileFirstAndLastNameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 5),
            profileFirstAndLastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 10),
            profileFirstAndLastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width / 10),
            
            uploadItemButton.heightAnchor.constraint(equalToConstant: 44),
            uploadItemButton.topAnchor.constraint(equalTo: profileFirstAndLastNameLabel.bottomAnchor, constant: frame.height / 25),
            uploadItemButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 10),
            uploadItemButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width / 10),
            uploadItemButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func changePhotoButtonTapped() {
        showActionSheet()
    }
    
    @objc private func uploadItemButtonTapped() {}
    
    private func showActionSheet() {
        let cameraIcon = UIImage(systemName: "camera")
        let photoIcon = UIImage(systemName: "photo")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        delegate?.showViewController(actionSheet)
    }
}

extension AvatarInfoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            
            delegate?.showViewController(imagePicker)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileAvatarImageView.image = info[.editedImage] as? UIImage
        profileAvatarImageView.contentMode = .scaleAspectFill
        profileAvatarImageView.clipsToBounds = true
        profileAvatarImageView.layer.cornerRadius = profileAvatarImageView.frame.size.width / 2
        delegate?.dismissImagePicker()
    }
}
