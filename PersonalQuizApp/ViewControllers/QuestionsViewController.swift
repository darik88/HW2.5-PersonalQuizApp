//
//  QuestionsViewController.swift
//  PersonalQuizApp
//
//  Created by Айдар Рахматуллин on 28.10.2020.
//

import UIKit

class QuestionsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = currentAnswers.count - 1
            rangedSlider.value = Float(answerCount)
        }
    }
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
     
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    // MARK: - Private Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultsVC = segue.destination as? ResultsViewController else { return }
        resultsVC.answers = answersChosen
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
        
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
}


// MARK: - Private methods
extension QuestionsViewController {
    
    private func updateUI() {
        // Hide stacks
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // get current question
        let currentQuestion = questions[questionIndex]
        
        // set current question for question label
        questionLabel.text = currentQuestion.text
        
        // calculate progress
        let totalProgres = Float(questionIndex) / Float(questions.count)
        
        // set progress for progress view
        progressView.setProgress(totalProgres, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // show current stackView
        showCurrentStackView(for: currentQuestion.type)
        
    }
    
    private func showCurrentStackView(for type: ResponceType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
