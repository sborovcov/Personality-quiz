//
//  Question.swift
//  Qiuz2021
//
//  Created by Stas Borovtsov on 12.01.2021.
//

struct Question{
    let text: String
    let type: ResponseList
    let answers: [Answer]
    
    static let all: [Question] = [
        Question(text: "Какую еду вы предпочитаете?", type: .single, answers: [
            Answer(text: "Что-нибудь погрызть", type: .rabbit),
            Answer(text: "Что-нибудь пожевать", type: .turtle),
            Answer(text: "Рыбку", type: .cat),
            Answer(text: "Мяско", type: .dog)
        ]),
        Question(text: "Что вы любите делать?", type: .multiply, answers: [
            Answer(text: "Поваляться", type: .dog),
            Answer(text: "Куда-нибудь валить", type: .rabbit),
            Answer(text: "Поспать", type: .cat),
            Answer(text: "Отвалите", type: .turtle)
        ]),
        Question(text: "Любите ли вы поездки на машине?", type: .range, answers: [
            Answer(text: "Бее", type: .cat),
            Answer(text: "Ууу", type: .rabbit),
            Answer(text: "Ммм", type: .turtle),
            Answer(text: "Еее", type: .dog)
        ])
    ]
}

