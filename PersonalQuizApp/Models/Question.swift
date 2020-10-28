//
//  Question.swift
//  PersonalQuizApp
//
//  Created by Айдар Рахматуллин on 23.10.2020.
//

struct Question {
    let text: String
    let type: ResponceType
    let answers: [Answer]
}

enum ResponceType {
    case single
    case multiple
    case ranged
}


extension Question {
    
    static func getQuestions() -> [Question] {
        
        return [
            Question(
                text: "Какую пищу Вы предпочитаете?",
                type: .single,
                answers: [
                    Answer(text: "Стейк", type: .dog),
                    Answer(text: "Рыба", type: .cat),
                    Answer(text: "Морковь", type: .rabbit),
                    Answer(text: "Кукуруза", type: .turtle)
                ]
            ),
            Question(
                text: "Что Вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(text: "Плавать", type: .dog),
                    Answer(text: "Спать", type: .cat),
                    Answer(text: "Обниматься", type: .rabbit),
                    Answer(text: "Есть", type: .turtle)
                ]
            ),
            Question(
                text: "Любите ли Вы поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(text: "Ненавижу", type: .cat),
                    Answer(text: "Нервничаю", type: .turtle),
                    Answer(text: "Обожаю", type: .dog),
                    Answer(text: "Не замечаю", type: .turtle)
                ]
            )
        ]
    }
}
