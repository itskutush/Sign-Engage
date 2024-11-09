//
//  DataModel.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

// DataModel.swift
import Foundation

struct Video {
    let fileName: String          // The file name of the video
    let title: String             // Title to display
    let transcriptions: [(String, TimeInterval)]  // Transcriptions with timestamps
}

// Array of videos with transcription data
let videos: [Video] = [
    Video(fileName: "Hello", title: "Hello", transcriptions: [
        ("1. Raise your hand", 2.0),
        ("2. Make a fist", 3.0)
    ]),
    Video(fileName: "Good Afternoon", title: "Good Afternoon", transcriptions: [
        ("1. Wave your hand", 2.0),
        ("2. Smile", 4.0)
    ]),
    Video(fileName: "Yes", title: "Yes", transcriptions: [
        (" 1. Nod your hand", 2.0),
        (" 2. Keep a happy face", 4.0)
    ]),
    Video(fileName: "No", title: "No", transcriptions: [
        (" 1. Move your head left to right", 2.0),
        (" 2. Keep a steady face", 4.0)
    ])
    
        

]
//added by itskutush
