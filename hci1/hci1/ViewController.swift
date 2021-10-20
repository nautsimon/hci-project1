//
//  ViewController.swift
//  hci1
//
//  Created by simonm on 10/20/21.
//
import CoreMotion
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pause: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    let manager = CMMotionManager()
    var volumeNum = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        if manager.isDeviceMotionAvailable {

            manager.deviceMotionUpdateInterval = 0.1

            manager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] (motion, error) -> Void in
               
                 if let attitude = motion?.attitude {
                     let currentRoll = attitude.roll * 180 / Double.pi
                     print(attitude.roll * 180 / Double.pi)

                      DispatchQueue.main.async{
                          var volumeText = Int(self?.volume.text ?? "0") ?? 0
                          if (currentRoll > 70.0) && (volumeText < 100) {
                              volumeText = volumeText + 1
                              self?.volume.text = String(volumeText)
                          }
                          else if (currentRoll < -70.0) && (volumeText > 0) {
                              volumeText = volumeText - 1
                              self?.volume.text = String(volumeText)
                          }
                              
                     }
                 }

             }

             print("Device motion started")
          }
         else {
             print("Device motion unavailable")
          }
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if pause.text == "Paused 🛑"{
                pause.text = "Playing 👍"
            }
            else{
                pause.text = "Paused 🛑"
            }
            
        }
    }
}

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        manager.startAccelerometerUpdates()
//        manager.startGyroUpdates()
//        self.becomeFirstResponder() // To get shake gesture
//
//
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
////            if let data = self.manager.accelerometerData{
////                let x = data.acceleration.x
////                let y = data.acceleration.y
////                let z = data.acceleration.z
////                print(x,y,z)
////            }
//            if let gyroData = self.manager.gyroData{
//                let gyroData = gyroData.rotationRate.z
//                print(gyroData)
//
//            }
//
//        }
//    }



