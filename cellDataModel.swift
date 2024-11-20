//
//  cellDataModel.swift
//  HomePageTrial
//
//  Created by user@90 on 17/11/24.
//

import UIKit
//DataModel for Chapter
struct Chapter {
    let name: String
    let description: String
    let bannerColor: UIColor
}
let chapters: [Chapter] = [
    Chapter(name: "Chapter 1", description: "Introduction to ISL",bannerColor: .systemGreen),
    Chapter(name: "Chapter 2", description: "Time and Directions", bannerColor: .systemBlue),

]
//DATAMODEL for buttons
struct Button {
    var symbolName: String
    var isUnlocked: Bool
    var chapter: Int
}

var ButtonState: [Button] = [
    //Chapter 1 buttons
    Button(symbolName: "numbers", isUnlocked: true,chapter: 1 ),
    Button(symbolName: "trophy.fill", isUnlocked: false, chapter: 1),
    Button(symbolName: "characters.uppercase", isUnlocked: false, chapter: 1),
    Button(symbolName: "trophy.fill", isUnlocked: false, chapter: 1),
    Button(symbolName: "figure.wave", isUnlocked: false,  chapter: 1),
    Button(symbolName: "trophy.fill", isUnlocked: false, chapter: 1),
    
    // Chapter 2 buttons, locked initially
    Button(symbolName: "clock", isUnlocked: false, chapter: 2),           // Button 7 (Chapter 2)
    Button(symbolName: "trophy.fill", isUnlocked: false,chapter: 2),            // Button 8 (Chapter 2)
    Button(symbolName: "map", isUnlocked: false,chapter: 2),           // Button 9 (Chapter 2)
    Button(symbolName: "trophy.fill", isUnlocked: false, chapter: 2),        // Button 10 (Chapter 2)
    Button(symbolName: "location", isUnlocked: false, chapter: 2),
    Button(symbolName: "trophy.fill", isUnlocked: false,chapter: 2),  // Button 11 (Chapter 2)

]



