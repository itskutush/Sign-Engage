//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct NumbersQuizDataModel {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let NumbersquizQuestions = [
    NumbersQuizDataModel(videoName: "1", options: ["1", "2", "3", "4"], correctAnswerIndex: 0),
    NumbersQuizDataModel(videoName: "2", options: ["1", "2", "3", "4"], correctAnswerIndex: 1),
    NumbersQuizDataModel(videoName: "3", options: ["1", "2", "3", "4"], correctAnswerIndex: 2),
    NumbersQuizDataModel(videoName: "4", options: ["1", "2", "3", "4"], correctAnswerIndex: 3),
    NumbersQuizDataModel(videoName: "5", options: ["3", "4", "5", "6"], correctAnswerIndex: 2),
    NumbersQuizDataModel(videoName: "6", options: ["4", "5", "6", "7"], correctAnswerIndex: 2),
    NumbersQuizDataModel(videoName: "7", options: ["7", "8", "9", "10"], correctAnswerIndex: 0),
    NumbersQuizDataModel(videoName: "8", options: ["7", "8", "9", "10"], correctAnswerIndex: 1),
    NumbersQuizDataModel(videoName: "9", options: ["9", "10", "11", "12"], correctAnswerIndex: 0),
    NumbersQuizDataModel(videoName: "10", options: ["8", "9", "10", "11"], correctAnswerIndex: 2)
]
