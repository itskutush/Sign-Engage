//
//  PerformViewController.swift
//  SignEngagePractice
//
//  Created by admin26 on 16/11/24.
//

import UIKit
import AVFoundation
class PerformViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        setupUI()
        setupCamera()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
    }
    @IBAction func openCamera(_ sender: UIButton) {
           // Check if the device has a camera
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               present(imagePicker, animated: true, completion: nil)
           } else {
               let alert = UIAlertController(title: "No Camera", message: "This device has no camera.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               present(alert, animated: true, completion: nil)
           }
       }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Handle the image captured
            if let image = info[.originalImage] as? UIImage {
                // Do something with the image (e.g., display it in an image view)
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    func setupCamera() {
            // Create an instance of AVCaptureSession
            captureSession = AVCaptureSession()
            captureSession?.sessionPreset = .high
            
            // Set up the device (camera)
            guard let camera = AVCaptureDevice.default(for: .video) else {
                print("No camera available")
                return
            }
            
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                if captureSession?.canAddInput(input) == true {
                    captureSession?.addInput(input)
                }
            } catch {
                print("Error accessing camera: \(error)")
                return
            }
            
            // Set up preview layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = cameraView.bounds
            if let layer = videoPreviewLayer {
                cameraView.layer.addSublayer(layer)
            }
            
            // Start the capture session
            captureSession?.startRunning()
        }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // Ensure the preview layer matches the UIView's bounds after layout changes
            videoPreviewLayer?.frame = cameraView.bounds
        }
    func setupUI() {
        // Style button
        nextButton.layer.cornerRadius = 8
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            // Navigate to Learn screen
            //performSegue(withIdentifier: "toLearnScreen", sender: self)
        }
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


