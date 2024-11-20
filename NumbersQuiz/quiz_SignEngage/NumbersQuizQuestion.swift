//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct NumbersQuizQuestion {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let quizQuestions = [
    NumbersQuizQuestion(videoName: "1", options: ["1", "2", "3", "4"], correctAnswerIndex: 0),
    NumbersQuizQuestion(videoName: "2", options: ["1", "2", "3", "4"], correctAnswerIndex: 1),
    NumbersQuizQuestion(videoName: "3", options: ["1", "2", "3", "4"], correctAnswerIndex: 2),
    NumbersQuizQuestion(videoName: "4", options: ["1", "2", "3", "4"], correctAnswerIndex: 3),
    NumbersQuizQuestion(videoName: "5", options: ["3", "4", "5", "6"], correctAnswerIndex: 2),
    NumbersQuizQuestion(videoName: "6", options: ["4", "5", "6", "7"], correctAnswerIndex: 2),
    NumbersQuizQuestion(videoName: "7", options: ["7", "8", "9", "10"], correctAnswerIndex: 0),
    NumbersQuizQuestion(videoName: "8", options: ["7", "8", "9", "10"], correctAnswerIndex: 1),
    NumbersQuizQuestion(videoName: "9", options: ["9", "10", "11", "12"], correctAnswerIndex: 0),
    NumbersQuizQuestion(videoName: "10", options: ["8", "9", "10", "11"], correctAnswerIndex: 2)
]
