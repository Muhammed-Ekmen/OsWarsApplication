//
//  ViewController.swift
//  OsWarsApplication
//
//  Created by Semih Ekmen on 24.02.2023.
//
/*

 In this applciation, I wanted to learn some Ui component usages. These are Slider,Progressbar and perform function also other alternative of perform.
 
 PERFORM FUCNTION USAGE
    * perform function is alternative of asycnAfter. if you remember the DispatchQueue.main.asyncAfter we were using this for delaying some operatinons. both of them making some process. whatever you want, both of them are useful. Its usage and descriptions at the below.
 
 SLIDER USAGE
    * It is totaly simple. create an object and onChanged action. After that, set up the value,min and max on the storyboard. Do not forget the these.
    * After that, just use it.
 
 TIMER SCHEDULE
    * That is kind of previous structures but there are some differences. In this structure, we have to add interval time, repeat situation and
    closure fields.
    Basic definition is we can do some operations in our time that setted up before.
*/


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageOfOS: UIImageView!
    @IBOutlet weak var osSlider: UISlider!
    @IBOutlet weak var counterNumberLabel: UILabel!
        
    let maxTime:Float = 10.0
    var currentTime:Float = 0.0
    var counterNumber:Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        imageOfOS.isHidden=true
        counterNumberLabel.isHidden = true
        showProgressBar()
    }
    
    func showProgressBar(){
        progressBar.setProgress(0.0, animated: true)
        perform(#selector(processingProgressBar), with: nil, afterDelay: 2.0)  // use #selector and enter your delayin funcstion to inside. Do not forget the how many second later, this function will run.
    }
    
    @objc func processingProgressBar(){       //NOTE: when you use the function in the #selector, you gotta add the @objc library tag.
        currentTime+=1
        let progressValue = currentTime/maxTime
        if currentTime < maxTime {
            progressBar.setProgress(progressValue, animated: true)
            perform(#selector(processingProgressBar), with: nil, afterDelay: 1.0)  // in here,we have acquired the loop with certain circumstances.
        }else{
            imageOfOS.isHidden = false
            progressBar.setProgress(1.0, animated: true)
        }
    }
    
    
    @IBAction func osSliderOnChange(_ sender: UISlider) {
        let fixed = roundf(osSlider.value/5.0) * 5.0
        osSlider.setValue(fixed, animated: true)
        setUpImage()
    }
    
     
    fileprivate func detectImage(_ value: ImageCodes) {
        switch value {
        case ImageCodes.Linux:
            imageOfOS.image = UIImage(named: "linux")
        case ImageCodes.MacOS:
            imageOfOS.image = UIImage(named: "apple")
        case ImageCodes.MicrosoftWindows:
            imageOfOS.image = UIImage(named: "windows")
        }
    }
    
    func setUpImage(){
        guard let value = ImageCodes(rawValue: osSlider.value) else {
            imageOfOS.isHidden = true
            return
        }
        detectImage(value)
    }
    
    
    
    @IBAction func startCounterAction(_ sender: UIButton) {
        counterNumberLabel.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (timer) in
            if self.counterNumber >= 0 {
                self.counterNumberLabel.text = String(self.counterNumber)
                self.counterNumber-=1
            }
            if self.counterNumber == 0 {
                self.counterNumberLabel.text = "Timer Has Finished"
            }
        })
        
    }
}


enum ImageCodes:Float{
    case Linux = 10.0
    case MicrosoftWindows = 5.0
    case MacOS = 0.0
}
