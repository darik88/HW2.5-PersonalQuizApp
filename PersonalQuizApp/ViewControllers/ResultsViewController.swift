//
//  ResultsViewController.swift
//  PersonalQuizApp
//
//  Created by Айдар Рахматуллин on 28.10.2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var answers: [Answer]!
    @IBOutlet var yourIdentityLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        updateResults()
    }
    
    private func updateResults() {
        
        var animalCounted: [AnimalType: Int] = [:]
        var animals: [AnimalType] = []
        
        for answer in answers {
            animals.append(answer.type)
        }
        
        for animal in animals {
            animalCounted[animal] = (animalCounted[animal] ?? 0) + 1
        }
        
        let mostFrequentlyMetAnimal = animalCounted.max { a, b in a.value < b.value }
        guard let animal = mostFrequentlyMetAnimal?.key else { return }
        
        updateViewController(with: animal)
        
    }
    
    private func updateViewController(with animal: AnimalType) {
        yourIdentityLabel.text = "\(animal.rawValue)"
        descriptionLabel.text = "\(animal.definition)"
    }

}
