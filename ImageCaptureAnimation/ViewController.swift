//
//  ViewController.swift
//  ImageCaptureAnimation
//
//  Created by verma mukesh on 27/3/22.
//

import UIKit

class ViewController: UIViewController {
    var imgCapture: UIImageView = UIImageView()
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var previewView: UIView!
    var isFrontCaptured = false
    
    let image = UIImage(named: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewView.layoutIfNeeded()
        self.imgCapture.frame = self.previewView.frame
    }
    @IBAction func btnCaptureTapped(_ sender: Any) {
        self.imgCapture.transform = .identity
        imgCapture.image = image
        print(self.view.window ?? "no window")
        self.view.window?.addSubview(imgCapture)
        self.imgCapture.transform = .identity
        UIView.animate(withDuration: 0.2, delay: 0.5, options: UIView.AnimationOptions.preferredFramesPerSecond60) {
            self.imgCapture.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { completed in
            if completed {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.preferredFramesPerSecond60) {
                    self.imgCapture.frame = (self.isFrontCaptured) ? (self.imgRight.globalFrame ?? .zero) : (self.imgLeft.globalFrame ?? .zero)
                    self.view.layoutIfNeeded()
                } completion: { scaleCompleted in
                    if scaleCompleted {
                        self.view.layoutIfNeeded()
                        self.imgCapture.image = nil
                        self.imgCapture.removeFromSuperview()
                        self.imgCapture.transform = .identity
                        if self.isFrontCaptured {
                            self.imgRight.image = self.image
                        } else {
                            self.imgLeft.image = self.image
                        }
                        self.isFrontCaptured.toggle()
                    }
                }
            }
        }
    }
    
}
extension UIView{
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}

