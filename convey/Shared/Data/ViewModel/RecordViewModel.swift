//
//  RecordViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI
import Speech

class RecordViewModel : NSObject, ObservableObject, AVAudioRecorderDelegate {
    
    private var firestoreService : FirestoreService
    private var authService : AuthService
    
    @AppStorage("RECORD_ALLOWED") var canRecord : Bool = false
    @AppStorage("TRANSCRIBE_ALLOWED") var canTranscribe : Bool = false
    
    @Published var isRecording = false
    @Published var promptAction = false
    @Published var recordName : String = ""
    
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    @Published var timer: Timer? = nil
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    
    @Published var time = 0.0
   
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
        
    }
    
    func signOut() {
        
        firestoreService.stop()
        authService.signOut()
    }
    
    
    func onStartRecordingTap() {
        
        
        if canRecord == false {
            
            requestRecordingPermissions()
            
        }
        
        if canTranscribe == false {
            
            requestTranscribePermissions()
            
        }
        
        
        
        if canRecord && canTranscribe && audioRecorder == nil {
            
            print("Starting recording")
            startRecording()
            
        }
        
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            isRecording = true
            recordName = ""
            startTimer()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func onStopRecordingTap() {
        print("Stopping Recording")
        
        stopTimer()
        
        finishRecording(success: true)
        
        
        
        time = (Double(seconds) + (60.0 * Double(minutes)))
        
        seconds = 0
        minutes = 0
        hours = 0
        
    }
    
    func finishRecording(success: Bool) {
        
//        time = audioRecorder.currentTime
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            
            
            isRecording = false
            promptAction = true
            
            
        } else {
            
            // also change record text to Re-Record here letting the user know the first recording didnt go through
            
            
            
            isRecording = false
            promptAction = false
            
        }
        
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func requestRecordingPermissions() {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                        print("Recording allowed by user!")
                        canRecord = true
                        
                    } else {
                        print("Recording permission was declined.")
                        
                        canRecord = false
                    }
                }
            }
        } catch {
    
            
            canRecord = false
        }
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Transcription allowed by user!")
                    
                    canTranscribe = true
                } else {
                    print("Transcription permission was declined.")
                    
                    canTranscribe = false
                }
            }
        }
    }
    
    func transcribeAudio(url: URL) {
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)
        
        if recognizer != nil {
            
            print("RECOGNIZER NOT NIL")
        if recognizer!.isAvailable {
            
            print("RECOGNIZER IS AVAILABLE")

        
        recognizer?.recognitionTask(with: request) { result, error in
            
            guard let result = result else {
                
                print("There was an error: \(error?.localizedDescription ?? nil)")
                
                
                return
            }

            
            if result.isFinal {
                
                print(result.bestTranscription.formattedString)
                
                self.firestoreService.uploadRecordToUser(text: result.bestTranscription.formattedString, time: self.time, recordName: self.recordName)
                
//                recognizer?.finalize()
//                self.time = 0
                
                // sends data to firebase
            }
        }
            
        }
    }
    }
    
    func saveRecord() {
        promptAction = false
        
        print("transcribing audio")
        
        if getDocumentsDirectory().appendingPathComponent("recording.m4a").isFileURL {
            print("is file")
        }
        
        print(getDocumentsDirectory().appendingPathComponent("recording.m4a"))
        
        transcribeAudio(url: getDocumentsDirectory().appendingPathComponent("recording.m4a"))
        
        
    }
    
    func deleteRecord() {
        
        promptAction = false
        
    
        
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if !flag {
            finishRecording(success: false)
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 59 {
                
                self.seconds = 0
                
                if self.minutes == 59 {
                    
                    self.minutes = 0
                    self.hours = self.hours + 1
                    
                }
                else {
                    
                    self.minutes = self.minutes + 1
                    
                }
            }
            else {
                
                self.seconds = self.seconds + 1
                
            }
        }
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        timer = nil
        
    }
    
}
