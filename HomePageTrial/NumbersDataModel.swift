//
//  DataModel.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

// DataModel.swift
import Foundation

struct NumbersVideo {
    let fileName: String          // The file name of the video
    let title: String             // Title to display
    let transcriptions: [(String, TimeInterval)]
    var isCompleted:Bool = false
    var alreadyViewed:Bool = false // Transcriptions with timestamps
}
class NumbersDataModel{
    static let shared = NumbersDataModel()

    
    var videos: [NumbersVideo] = [
        NumbersVideo(fileName: "1", title: "1", transcriptions: [
            ("1. Raise your index finger to sign 1", 0.5),
        ]),
        NumbersVideo(fileName: "2", title: "2", transcriptions: [
            ("1. Raise your index and middle fingers together to sign 2", 0.5)

        ]),
        NumbersVideo(fileName: "3", title: "3", transcriptions: [
            ("1. Raise your index, middle and ring fingers together to sign 3", 1.0)
        ]),
        NumbersVideo(fileName: "4", title: "4", transcriptions: [
            ("1. Raise your index, middle,ring and little fingers together to sign 4", 1.0),
        ]),
        
        NumbersVideo(fileName: "5", title: "5", transcriptions: [
            ("1. Raise all of your fingers to sign 5", 0.5),

        ]),
        NumbersVideo(fileName: "6", title: "6", transcriptions: [
            ("1. Lift your little finger", 1.0),
            ("2. Move your little finger in the air in the shape of 6 to sign 6", 1.5),

     
        ]),
        NumbersVideo(fileName: "7", title: "7", transcriptions: [
            (" 1.Lift your index finger and bend it to sign 7", 1.0),
        ]),
        NumbersVideo(fileName: "8", title: "8", transcriptions: [
            (" 1. Raise your index, middle and thumb fingers in one hand to sign 8", 1.0),
        ]),
        NumbersVideo(fileName: "9", title: "9", transcriptions: [
            (" 1. Form a fist and release your thumb to sign 9", 0.0)
            
        ]),
        NumbersVideo(fileName: "10", title: "10", transcriptions: [
            (" 1. Sign 1", 1.0),
            (" 2. Release", 2.0),
            ("3. Bring your fingertips together to form a circle to sign 10",2.2)
            
        ]),
        
    ]
    
    
    
}
