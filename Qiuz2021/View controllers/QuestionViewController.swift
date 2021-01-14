//
//  QuestionViewController.swift
//  Qiuz2021
//
//  Created by Stas Borovtsov on 12.01.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var multiplyStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwiches: [UISwitch]!
    
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet var rangeLabels: [UILabel]!
    
    @IBOutlet weak var quiestionProgressView: UIProgressView!
    
    private var answersChoosen = [Answer](){
        didSet{
            //print(answersChoosen)
        }
    }
    
    private var currentAnswers: [Answer]{
        currentQuestion.answers
    }
    
    private var currentQuestion: Question{
        Question.all[questionIndex]
    }
            
    var questionIndex = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeSlider.maximumValue = 0.99999
        updateUI()
    }
    
    // функция для изменения интерфейса как рекомендует apple
    func updateUI() {
        
        // сначала эти функции были снаружи updateUI() и им был недоступен answers, но мы можем сделать функцию в функции и
        // тогда вложенным функциям будут доступны переменные updateUI(), но сами функции не будут видны вне updateUI()
        func updateSingleStack(){
            singleStackView.isHidden = false
            
            for (index, button) in singleButtons.enumerated(){
                button.setTitle("", for: [])
                button.tag = index // если поменяем количество кнопок, то в tag  точно будет значение, а его мы используем при нажатии на кнопку для запоминания ответа пользователя
            }
            
            // здесь может быть ошибка, если ответов меньше, чем кнопок
//            for (index, button) in singleButtons.enumerated() {
//                button.setTitle(answers[index].text, for: [])
//            }
            // поэтому переделаем на использование функции zip, которая из двух последовательностей выбирает пары
            for (button, answer) in zip(singleButtons, currentAnswers){
                button.setTitle(answer.text, for: [])
            }
        }
        
        func updatemultiplyStackView(){
            multiplyStackView.isHidden = false
            
            for label in multiLabels{
                label.text = ""
            }
            
            for (label, answer) in zip(multiLabels, currentAnswers){
                label.text = answer.text
            }
        }
        
        func updaterangeStackView(){
            rangeStackView.isHidden = false
            
            rangeLabels.first?.text = currentAnswers.first?.text
            rangeLabels.last?.text = currentAnswers.last?.text
        }
        
        // можно задать свойство по отдельности
//        singleStackView.isHidden = true
//        multiplyStackView.isHidden = true
//        rangeStackView.isHidden = true
        
        // можно задать свойство в цикле
        for stackView in [singleStackView, multiplyStackView, rangeStackView]{
            stackView?.isHidden = true
        }
        
        // определим тип текущего вопроса
        //let currentQuestion = Question.all[questionIndex]
        //let currentAnswers = question.answers
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        
        navigationItem.title = "Вопрос №\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        quiestionProgressView.setProgress(totalProgress, animated: true)
        
        
        // нарисуем на форме элементы, соответствующие типу вопроса
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiply:
            updatemultiplyStackView()
        case .range:
            updaterangeStackView()
        }
        
    }

    func nextQuestion(){
        // так мы делали что бы просто ходить по окнам зацикленно, но нам недо на последнем вопросе перейти к показу результата
        //questionIndex = (questionIndex + 1) % Question.all.count
        questionIndex += 1
        if questionIndex < Question.all.count{
            updateUI()
        }else{
            // вызываем view с переданным идентификатором(задается в свойствах segue - перехода между формами. Вот те стрелочки в main.storyboard)
            performSegue(withIdentifier: "Result segue", sender: nil)
        }
    }
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = Question.all[questionIndex].answers
        let index = sender.tag
        
        guard 0 <= index && index < answers.count else{
            return
        }
        
        let answer = answers[index]
        answersChoosen.append(answer)
        
        nextQuestion()
    }
 
    @IBAction func multiButtonPressed(){
        for (index, multiSwich) in multiSwiches.enumerated(){
            if multiSwich.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answersChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangeButtonPressed(){
        let index = Int(round(rangeSlider.value * Float(currentAnswers.count - 1)))
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answersChoosen.append(answer)
        }
        
        nextQuestion()
    }
    
    // этот экшн сделан от стрелочки перехода между формами и заменен инициализатор формы на наш с двумя параметрами
    @IBSegueAction func resultSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answersChoosen)
    }
}
