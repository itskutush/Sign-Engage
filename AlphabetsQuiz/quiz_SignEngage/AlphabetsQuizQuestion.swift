//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct AlphabetsQuizQuestion {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let quizQuestions = [
    AlphabetsQuizQuestion(videoName: "A", options: ["A", "B", "C", "D"], correctAnswerIndex: 0),
    AlphabetsQuizQuestion(videoName: "C", options: ["A", "B", "C", "D"], correctAnswerIndex: 2),
    AlphabetsQuizQuestion(videoName: "I", options: ["G", "H", "I", "J"], correctAnswerIndex: 2),
    AlphabetsQuizQuestion(videoName: "L", options: ["L", "M", "N", "O"], correctAnswerIndex: 0),
    AlphabetsQuizQuestion(videoName: "M", options: ["M", "N", "O", "P"], correctAnswerIndex: 0),
    AlphabetsQuizQuestion(videoName: "N", options: ["L", "M", "N", "O"], correctAnswerIndex: 2),
    AlphabetsQuizQuestion(videoName: "O", options: ["L", "M", "N", "O"], correctAnswerIndex: 3),
    AlphabetsQuizQuestion(videoName: "U", options: ["S", "T", "U", "V"], correctAnswerIndex: 2),
    AlphabetsQuizQuestion(videoName: "V", options: ["V", "W", "X", "Y"], correctAnswerIndex: 0),
    AlphabetsQuizQuestion(videoName: "Z", options: ["W", "X", "Y", "Z"], correctAnswerIndex: 3)
]
