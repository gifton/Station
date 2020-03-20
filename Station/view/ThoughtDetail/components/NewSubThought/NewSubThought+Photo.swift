
import UIKit
import AVFoundation

extension NewSubThoughtController {
    func setImageView() {
        
        // TODO: implement image sourcing
        // create capture session, .medium for meh quality photos
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        //guard into back camera
        //TODO: add front camera support
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else { print("Unable to access back camera"); setupLivePreview(); return }
        do {
            // recieve input
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            // check if input and output is validated
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        setupLivePreview()
        
    }
    
    func setupLivePreview() {
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        view.layer.addSublayer(cameraPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.captureSession.startRunning()
            DispatchQueue.main.async { self.cameraPreviewLayer.frame = self.camFrame }
        }
        
        let captureHandler = UIView(frame: self.camFrame)
        captureHandler.backgroundColor = .clear
        captureHandler.addTapGestureRecognizer(action: self.didTakePhoto)
        self.view.addSubview(captureHandler)
        
        let tapForPhotoLabel = UILabel.title("Tap to take photo", .xLarge)
        tapForPhotoLabel.textColor = .black
        tapForPhotoLabel.sizeToFit()
        tapForPhotoLabel.center.x = view.center.x
        tapForPhotoLabel.top = camFrame.top.addPadding()
        tapForPhotoLabel.textDropShadow(.white)
        view.addSubview(tapForPhotoLabel)
        
        let getImageFromLibrary = ConfirmationButton(
            point: .init(Styles.Padding.xLarge.rawValue, captureHandler.bottom.addPadding()),
            color: .monoChrome,
            text: "Upload photo",
            width: .half,
            font: Styles.Font.body(ofSize: .xLarge)
        )
        getImageFromLibrary.center.x = view.center.x
        getImageFromLibrary.addTapGestureRecognizer(action: uploadFormLibrary)
        view.addSubview(getImageFromLibrary)
    }
    
    internal func didTakePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        guard let  image = UIImage(data: imageData) else {
            print ("unable to process photo from session")
            return
        }
        
        endSession()
        setSelectedImage(image)
        
        preview = SubThoughtPreview(img: image, thought: nil)
        
    }
    
    // end session public for call form MSGCenterPhotoView
    public func endSession() {
        print("ending camera session")
        captureSession.stopRunning()
        cameraPreviewLayer.removeFromSuperlayer()
    }
    
    private func setSelectedImage(_  image: UIImage) {
        outputImage.contentMode = .scaleAspectFill
        outputImage.layer.masksToBounds = true
        outputImage.image = image
        outputImage.frame = camFrame
        outputImage.layer.borderColor = UIColor.white.cgColor
        outputImage.layer.borderWidth = 10
        view.addSubview(outputImage)
    }
    
}

extension NewSubThoughtController: AVCapturePhotoCaptureDelegate { }

extension NewSubThoughtController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func uploadFormLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.setSelectedImage(image)
        preview = SubThoughtPreview(img: image, thought: nil)
    }
}
