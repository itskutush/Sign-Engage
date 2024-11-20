//
//  DataModel.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

// DataModel.swift
import Foundation

struct GreetingsVideo {
    let fileName: String          // The file name of the video
    let title: String             // Title to display
    let transcriptions: [(String, TimeInterval)]
    var isCompleted: Bool = false
    var alreadyViewed : Bool = false// Transcriptions with timestamps
}
class GreetingsDataModel{
    static let shared = GreetingsDataModel()
    var videos: [GreetingsVideo] = [
        GreetingsVideo(fileName: "Hello", title: "Hello", transcriptions: [
            ("1. Raise your hand your forehead side", 2.0),
            ("2. Wave your hand", 3.0),
            ("3. Bring your hand down", 4.0)
        ],alreadyViewed : true),
        GreetingsVideo(fileName: "Good Morning", title: "Good Afternoon", transcriptions: [
            ("1. Do a thumbs up", 2.0),
            ("2. Make a flower blooming gesture ", 3.0),
            ("3. Move your hand from your stomach to chest", 3.5),
        ]),
        GreetingsVideo(fileName: "Good Afternoon (male)", title: "Good Morning", transcriptions: [
            ("1. Do a thumbs up", 2.0),
            ("2. Raise your hand above your head ", 3.0),
            ("3. Bring your fingers together & release", 3.5),
        ]),
        GreetingsVideo(fileName: "Good Night", title: "Good Night", transcriptions: [
            ("1. Do a thumbs up", 2.0),
            ("2. Bring your finger tips closer and move your hand downwards from your chest to your stomach", 2.5),
            ("3. Close your fingertips", 3.0),
        ]),
        
        GreetingsVideo(fileName: "Yes", title: "Yes", transcriptions: [
            (" 1. Keep your head steady", 1.0),
            (" 2. Nod your hand back & forth", 1.5)
        ]),
        GreetingsVideo(fileName: "No", title: "No", transcriptions: [
            (" 1. Keep your head steady", 1.0),
            (" 2. Move your head sideways", 1.5)
        ]),
        GreetingsVideo(fileName: "Thank You Very Much (male)", title: "Thank You Very Much", transcriptions: [
            (" 1. Move your non-dominant hand from your mouth to chest", 1.0),
            (" 2. Use both hands", 2.7),
            ("3. Sweep hands slightly outwards in a downward motion ", 3.0)
        ]),
        GreetingsVideo(fileName: "Welcome(Male)", title: "Welcome", transcriptions: [
            (" 1. Raise your hand away from your chest", 2.0),
            (" 2. Move your palm from a outward to inward direction ", 3.0),
        ]),
        GreetingsVideo(fileName: "Bye - Bye", title: "Bye Bye", transcriptions: [
            (" 1. Raise your hand", 1.0),
            (" 2. Wave", 2.0),
            
        ]),
        GreetingsVideo(fileName: "Sorry", title: "Sorry", transcriptions: [
            (" 1. Make a fist", 3.0),
            (" 2. Move the fist in a circular motion over ur chest", 5.0),
            
        ]),
        
    ]
    
    
    
    // Array of videos with transcription data
    
}
