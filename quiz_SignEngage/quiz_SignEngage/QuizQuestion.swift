//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct QuizQuestion {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let quizQuestions = [
    QuizQuestion(videoName: "Bye - Bye", options: ["Bye Bye", "Hi", "What", "No"], correctAnswerIndex: 0),
    QuizQuestion(videoName: "Good Afternoon (male)", options: ["Good Morning", "Good Night", "Good Evening", "Good Afternoon"], correctAnswerIndex: 3),
    QuizQuestion(videoName: "Good Morning", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 1),
    QuizQuestion(videoName: "Good Night", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 2),
    QuizQuestion(videoName: "Hello", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
    QuizQuestion(videoName: "No", options: ["Yes", "No", "Bye", "Welcome"], correctAnswerIndex: 1),
    QuizQuestion(videoName: "Sorry", options: ["Yes", "No", "Sorry", "Okay"], correctAnswerIndex: 2),
    QuizQuestion(videoName: "Thank You", options: ["Stop", "Welcome", "Okay", "Thank You"], correctAnswerIndex: 3),
    QuizQuestion(videoName: "Welcome", options: ["Welcome", "Hello", "Go", "Thank You"], correctAnswerIndex: 0),
    QuizQuestion(videoName: "Yes", options: ["No", "Yes", "Stop", "Bye"], correctAnswerIndex: 1)
]
