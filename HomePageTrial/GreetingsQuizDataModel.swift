//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct GreetingsQuizDataModel {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let quizQuestions = [
    GreetingsQuizDataModel(videoName: "Bye - Bye", options: ["Bye Bye", "Hi", "What", "No"], correctAnswerIndex: 0),
    GreetingsQuizDataModel(videoName: "Good Afternoon (male)", options: ["Good Morning", "Good Night", "Good Evening", "Good Afternoon"], correctAnswerIndex: 3),
    GreetingsQuizDataModel(videoName: "Good Morning", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 1),
    GreetingsQuizDataModel(videoName: "Good Night", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 2),
    GreetingsQuizDataModel(videoName: "Hello", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
    GreetingsQuizDataModel(videoName: "No", options: ["Yes", "No", "Bye", "Welcome"], correctAnswerIndex: 1),
    GreetingsQuizDataModel(videoName: "Sorry", options: ["Yes", "No", "Sorry", "Okay"], correctAnswerIndex: 2),
    GreetingsQuizDataModel(videoName: "Thank You Very Much (male)", options: ["Stop", "Welcome", "Okay", "Thank You Very Much"], correctAnswerIndex: 3),
    GreetingsQuizDataModel(videoName: "Welcome", options: ["Welcome", "Hello", "Go", "Thank You"], correctAnswerIndex: 0),
    GreetingsQuizDataModel(videoName: "Yes", options: ["No", "Yes", "Stop", "Bye"], correctAnswerIndex: 1)
]
