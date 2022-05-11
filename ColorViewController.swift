//
//  ColorViewController.swift
//  instagramCard
//
//  Created by Shien on 2022/5/11.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var red: UIView!
    @IBOutlet weak var orange: UIView!
    @IBOutlet weak var pink: UIView!
    @IBOutlet weak var purple: UIView!
    @IBOutlet weak var brown: UIView!
    @IBOutlet weak var yellow: UIView!
    @IBOutlet weak var black: UIView!
    @IBOutlet weak var green: UIView!
    @IBOutlet weak var blue: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func snapShot(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(bounds: mainView.bounds)
        let image = renderer.image { (context) in
            pink.drawHierarchy(in: orange.frame, afterScreenUpdates: true)
        }
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true)
    }
    
   
}
