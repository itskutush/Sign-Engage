//
//  PerformViewController.swift
//  SignEngagePractice
//
//  Created by admin26 on 16/11/24.
//

import UIKit
import AVFoundation
class PerformViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var learnButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet var doneButton: UIButton!
    
    
        
        // Property to hold the selected alphabet
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let imagePicker = UIImagePickerController()
    var selectedAlphabet: String?
    var selectedVideoURL: URL?
    var selectedVideo: AlphabetsVideo?
        
        // Label to display the message
       
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        setupUI()
        setupCamera()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        updateTitleLabel()
        if let alphabet = selectedAlphabet {
                    titleLabel.text = "Perform the gesture for \(alphabet)"
                }
        
        
    }
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLearnScreen" {
            if let learnVC = segue.destination as? LearnViewController {
                // Pass the selected alphabet or other relevant data to the LearnViewController
                
            }
        }
    }*/

    func updateTitleLabel() {
           // Get the selected segment's title
        let selectedOption = "unknown option"
           // Update the label's text
           titleLabel.text = "Perform the gesture for \(selectedOption)"
       }
    @IBAction func learnButtonTapped(_ sender: UIButton) {
        // Pass the selected alphabet to the LearnViewController
        //performSegue(withIdentifier: "toLearnScreen", sender: self)
        guard let selectedAlphabet = selectedAlphabet else {
               print("No alphabet selected")
               return
           }

           // Fetch the corresponding video based on the selected alphabet
           if let video = AlphabetsDataModel.shared.videos.first(where: { $0.title == selectedAlphabet }) {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let learnVC = storyboard.instantiateViewController(withIdentifier: "LearnViewController") as? LearnViewController {
                   learnVC.selectedVideo = video // Pass the selected video
                   // Print a message confirming the video was found and is being loaded
                   print("Matching video loaded: \(video.title)")

                   navigationController?.pushViewController(learnVC, animated: true)
                   print("LearnViewController pushed to navigation stack with video: \(video.title)")
               }
           } else {
               print("Video not found for the selected alphabet")
           }
       
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
        doneButton.isEnabled = true
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
        //nextButton.layer.cornerRadius = 8
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


