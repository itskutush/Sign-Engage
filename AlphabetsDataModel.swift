//
//  DataModel.swift
//  videoLesson
//
//  Created by user@90 on 20/11/24.
//

// DataModel.swift
import Foundation

struct AlphabetsVideo {
    let fileName: String          // The file name of the video
    let title: String             // Title to display
    let transcriptions: [(String, TimeInterval)]
    var isCompleted: Bool = false
    var alreadyViewed:Bool = false// Transcriptions with timestamps
}
class AlphabetsDataModel{
    static let shared = AlphabetsDataModel()
    var videos: [AlphabetsVideo] = [
        AlphabetsVideo(fileName: "A", title: "A", transcriptions: [
            ("1. Make fists with both hands", 3.0),
            ("2. Join the tips of your thumbs", 4.0)
        ],alreadyViewed: true),
        AlphabetsVideo(fileName: "C", title: "C", transcriptions: [
            ("1. Raise your hand", 1.0),
            ("2. Curve your thumb and index finger to form a C ", 2.5),
        ]),
        AlphabetsVideo(fileName: "E", title: "E", transcriptions: [
            ("1. Point your index finger towards your left hand ", 2.0),
            ("2. Form a C shape with your left hand ", 2.5),
            ("3. Place your index finger in between the C to form E ", 5.6),
        ]),
        AlphabetsVideo(fileName: "E(2)", title: "E(2)", transcriptions: [
            ("1. Lift your index finger up", 2.0),
            ("2. Lift three fingers up from your other hand", 2.5),
            ("3. Place your index finger on the tips of your fingers", 3.0)
        ]),
        
        AlphabetsVideo(fileName: "F", title: "F", transcriptions: [
            (" 1. Make a 2 and keep your palm flat", 2.0),
            (" 2. The  rest your other index and middle fingers on top of that", 2.5)
        ]),
        AlphabetsVideo(fileName: "G", title: "G", transcriptions: [
            (" 1. Form fists with both of your hands", 2.0),
            (" 2. place one fist on top of the other", 3.0)
        ]),
        AlphabetsVideo(fileName: "I", title: "I", transcriptions: [
            (" 1. Lift your index finger like 1", 2.0),
            (" 2. Curl your other index finger", 2.7),
            ("3. Place it slightly above the 1 ", 3.0)
        ]),
        AlphabetsVideo(fileName: "L", title: "L", transcriptions: [
            (" 1. Form a fist", 2.0),
            (" 2. Lift your index finger and your thumb", 2.5),
        ]),
        AlphabetsVideo(fileName: "M", title: "M", transcriptions: [
            (" 1. Keep your palm flat facing outwards", 1.0),
            (" 2. Rest three fingers of your other hand on the palm", 2.0),
            
        ]),
        AlphabetsVideo(fileName: "N", title: "N", transcriptions: [
            (" 1. Keep your palm flat facing outwards", 3.0),
            (" 2. Rest two fingers of your other hand on the palm", 5.0),
            
        ]),
        AlphabetsVideo(fileName: "O", title: "O", transcriptions: [
            (" 1. Join the tips of your fingers together to form a circle", 2.7),
        ]),
        AlphabetsVideo(fileName: "T2(ML)", title: "T", transcriptions: [
            (" 1. Lift the index finger of your hand", 1.0),
            (" 2. Lift the other index finger of your hand horizontally", 1.3),
            (" 3. Place the index finger horizontally on top of the other", 1.5),
            
            
        ]),
        AlphabetsVideo(fileName: "U", title: "U", transcriptions: [
            (" 1. Lift your index and middle finger ", 2.0),
            (" 2. Move your fingers closer to each other", 3.0),
            
        ]),
        AlphabetsVideo(fileName: "V", title: "V", transcriptions: [
            (" 1. Lift your index and middle finger ", 2.0),
            (" 2. Make a victory sign", 3.0)
            
        ]),
        AlphabetsVideo(fileName: "X", title: "X", transcriptions: [
            (" 1. Lift your index finger of both hands", 2.0),
            (" 2. Criss cross your index fingers", 3.0)
            
        ]),
        AlphabetsVideo(fileName: "Y", title: "Y", transcriptions: [
            (" 1. Extend your index finger and thumb", 2.0),
            (" 2. Place your other index finger on the palm of the other", 3.0)
            
        ]),
        AlphabetsVideo(fileName: "Z", title: "Z", transcriptions: [
            (" 1. Raise your hand facing your other hand", 1.8),
            (" 2. Move your other hand horizontally to touch the palm of your other hand", 2.0)
            
        ]),

        
        
    ]
    
    
    
    // Array of videos with transcription data
    
}
