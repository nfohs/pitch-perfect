//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Nick Fohs on 11/1/16.
//  Copyright © 2016 Nick Fohs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  var audioRecorder: AVAudioRecorder!
  
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
  
  
  @IBAction func recordAudio(_ sender: Any) {
    //print("Record button was pressed")
    recordingLabel.text = "Recording in progress"
    stopButton.isEnabled = true
    recordButton.isEnabled = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
    //print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(_ sender: Any) {
    print("Stop Recording was pressed")
    stopButton.isEnabled = false
    recordButton.isEnabled = true
    recordingLabel.text = "Tap to Record"
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    } else {
      print("recording was not successful")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      let recordedAudioURL = sender as! URL
      playSoundsVC.recordedAudioURL = recordedAudioURL
    } 
  }
}

