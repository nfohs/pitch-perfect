//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Nick Fohs on 11/1/16.
//  Copyright © 2016 Nick Fohs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var recordingLabel: UILabel!
  
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      stopButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear called")
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func recordAudio(_ sender: Any) {
    //print("Record button was pressed")
    recordingLabel.text = "Recording in Progress"
    stopButton.isEnabled = true
    recordButton.isEnabled = false
  }

  @IBAction func stopRecording(_ sender: Any) {
    print("Stop Recording was pressed")
    stopButton.isEnabled = false
    recordButton.isEnabled = true
    recordingLabel.text = "Tap to Record"
  }
}

