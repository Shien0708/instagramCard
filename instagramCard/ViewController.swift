//
//  ViewController.swift
//  instagramCard
//
//  Created by 方仕賢 on 2022/5/11.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var instagramView: UIView!
    
    //text
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var likedNameLabel: UILabel!
    @IBOutlet weak var storyIdLabel: UILabel!
    
    //share
    @IBOutlet weak var containerView: UIStackView!
    
    // image
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var idImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var tabBarIdImageView: UIImageView!
    var isIDImage = true //判斷是否為大頭貼
    var isStoryImage = false //判斷是否為貼文照片
    var imageController = UIImagePickerController()
    
    
    //icon
    @IBOutlet var icons: [UIButton]!
    var selectedIconIndex = 0
   
    @IBOutlet weak var tabBar: UITabBar!
    //date
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarIdImageView.layer.cornerRadius = tabBarIdImageView.bounds.width/2
    }
    
    //edit date
    @IBAction func changeDate(_ sender: Any) {
        dateView.isHidden = false
        dateButton.isHidden = false
    }
    
    @IBAction func saveDate(_ sender: Any) {
        dateView.isHidden = true
        dateButton.isHidden = true
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        dateLabel.text = formatter.string(from: datePicker.date)
    }
    
    
    //edit text
    func showTextFieldAlert(editedLabel: UILabel){
        let controller = UIAlertController(title: "Type your story", message: nil, preferredStyle: .alert)
        controller.addTextField()
        controller.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            if let text = controller.textFields?.first?.text {
                if editedLabel == self.likedNameLabel {
                    editedLabel.text = "Liked by \(text) and others"
                    
                } else {
                    editedLabel.text = text
                    self.storyIdLabel.text = self.idLabel.text
                }
            }
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(controller, animated: true)
    }
    
    @IBAction func editLikedName(_ sender: Any) {
        showTextFieldAlert(editedLabel: likedNameLabel)
        
    }
    
    @IBAction func editLoacation(_ sender: Any) {
        showTextFieldAlert(editedLabel: locationLabel)
    }
    
    @IBAction func editID(_ sender: Any) {
        showTextFieldAlert(editedLabel: idLabel)
        storyIdLabel.font = UIFont.boldSystemFont(ofSize: storyIdLabel.font.pointSize)
    }
    
    @IBAction func editStory(_ sender: Any) {
        showTextFieldAlert(editedLabel: storyLabel)
    }
    
    // edit icon color
    @IBAction func changeColor(_ sender: UIButton) {
        while sender != icons[selectedIconIndex] {
            selectedIconIndex += 1
        }
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    // edit image
    @IBAction func takePhoto(_ sender: Any) {
        isStoryImage = true
        imageController.sourceType = .camera
        imageController.delegate = self
        present(imageController, animated: true)
    }
    
    func showImagePickerController() {
        imageController.sourceType = .photoLibrary
        imageController.delegate = self
        present(imageController, animated: true)
    }
    
    @IBAction func changeIDImage(_ sender: Any) {
        isIDImage = true
        isStoryImage = false
        showImagePickerController()
    }
    
    @IBAction func changeStroyImage(_ sender: Any) {
        isStoryImage = true
        showImagePickerController()
    }
    
    @IBAction func changeLikedImage(_ sender: Any) {
        isIDImage = false
        isStoryImage = false
        showImagePickerController()
    }
    
    
    // snapshot and share
    @IBAction func share(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(bounds: containerView.bounds)
        let image = renderer.image { (context) in
            instagramView.drawHierarchy(in: instagramView.bounds, afterScreenUpdates: true)
        }
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true)
    }
}


extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("no image")
            return}
        
        if isStoryImage {
            storyImageView.image = image
        } else if isIDImage {
            idImageView.image = image
            tabBarIdImageView.image = image
            tabBarIdImageView.layer.cornerRadius = tabBarIdImageView.bounds.width/2
        } else {
            likeImageView.image = image
        }
        dismiss(animated: true)
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        icons[selectedIconIndex].tintColor =  viewController.selectedColor
        selectedIconIndex = 0
        dismiss(animated: true)
    }
}

