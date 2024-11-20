//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct AlphabetsQuizDataModel {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let AlphabetsquizQuestions = [
    AlphabetsQuizDataModel(videoName: "A", options: ["A", "B", "C", "D"], correctAnswerIndex: 0),
    AlphabetsQuizDataModel(videoName: "C", options: ["A", "B", "C", "D"], correctAnswerIndex: 2),
    AlphabetsQuizDataModel(videoName: "I", options: ["G", "H", "I", "J"], correctAnswerIndex: 2),
    AlphabetsQuizDataModel(videoName: "L", options: ["L", "M", "N", "O"], correctAnswerIndex: 0),
    AlphabetsQuizDataModel(videoName: "M", options: ["M", "N", "O", "P"], correctAnswerIndex: 0),
    AlphabetsQuizDataModel(videoName: "N", options: ["L", "M", "N", "O"], correctAnswerIndex: 2),
    AlphabetsQuizDataModel(videoName: "O", options: ["L", "M", "N", "O"], correctAnswerIndex: 3),
    AlphabetsQuizDataModel(videoName: "U", options: ["S", "T", "U", "V"], correctAnswerIndex: 2),
    AlphabetsQuizDataModel(videoName: "V", options: ["V", "W", "X", "Y"], correctAnswerIndex: 0),
    AlphabetsQuizDataModel(videoName: "Z", options: ["W", "X", "Y", "Z"], correctAnswerIndex: 3)
]
