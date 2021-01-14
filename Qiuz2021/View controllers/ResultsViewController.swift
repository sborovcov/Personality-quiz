//
//  ResultsViewController.swift
//  Qiuz2021
//
//  Created by Stas Borovtsov on 12.01.2021.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let answers: [Answer]
    
    // все что касается coder: NSCoder и required init?(coder: NSCoder) объясняется в модуле по Quiz в части 16
    init?(coder: NSCoder, _ answers: [Answer]){
        self.answers = answers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePersonalResult(){
        
        let frequencyOfAnswers = answers.reduce(into: [:]) { counts, answer in
            //counts[answer.type] может быть nil и тогда его нельзя сложить с 1, поэтому можно написать проверку
            //counts[answer.type] = (counts[answer.type] ?? 0) + 1
            // но можно это же самое сделать так
            counts[answer.type, default: 0] += 1
        }
        //агрументы можно заменять на $ с номером и тогда сократить эту строку до(синтаксический сахар)
        //let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { pair1, pair2 in pair1.value > pair2.value }
        let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { $0.value > $1.value }
        //print(frequencyOfAnswersSorted)
        let mostCommonAnswers = frequencyOfAnswersSorted.first!.key
        UpdateUI(with: mostCommonAnswers)
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // уберем на этом view стандартную кнопку возврата на предыдущий экран
        navigationItem.hidesBackButton = true
        calculatePersonalResult()
    }
    
    func UpdateUI(with animal: AnimalType){
        //rawValue - без него вывелось бы слово, соответсвующее картинке, а так непосредственно само значение
        animalLabel.text = "Вы - это \(animal.rawValue)"
        descriptionLabel.text = animal.definition
    }
    
}
