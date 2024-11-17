//
//  QuizQuestion.swift
//  quiz_SignEngage
//
//  Created by user@89 on 13/11/24.
//

import Foundation

struct GreetingsQuizQuestion {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

let quizQuestions = [
    GreetingsQuizQuestion(videoName: "Bye - Bye", options: ["Bye Bye", "Hi", "What", "No"], correctAnswerIndex: 0),
    GreetingsQuizQuestion(videoName: "Good Afternoon (male)", options: ["Good Morning", "Good Night", "Good Evening", "Good Afternoon"], correctAnswerIndex: 3),
    GreetingsQuizQuestion(videoName: "Good Morning", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 1),
    GreetingsQuizQuestion(videoName: "Good Night", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 2),
    GreetingsQuizQuestion(videoName: "Hello", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
    GreetingsQuizQuestion(videoName: "No", options: ["Yes", "No", "Bye", "Welcome"], correctAnswerIndex: 1),
    GreetingsQuizQuestion(videoName: "Sorry", options: ["Yes", "No", "Sorry", "Okay"], correctAnswerIndex: 2),
    GreetingsQuizQuestion(videoName: "Thank You Very Much (male)", options: ["Stop", "Welcome", "Okay", "Thank You Very Much"], correctAnswerIndex: 3),
    GreetingsQuizQuestion(videoName: "Welcome", options: ["Welcome", "Hello", "Go", "Thank You"], correctAnswerIndex: 0),
    GreetingsQuizQuestion(videoName: "Yes", options: ["No", "Yes", "Stop", "Bye"], correctAnswerIndex: 1)
]
