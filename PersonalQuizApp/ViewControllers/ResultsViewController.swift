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
        let animal = findMostFrequentlyUsedAnimal()
        yourIdentityLabel.text = "Вы - \(animal.rawValue)"
        descriptionLabel.text = "\(animal.definition)"
    }
    
    private func findMostFrequentlyUsedAnimal() -> AnimalType {
        var dogs = 0
        var cats = 0
        var rabbits = 0
        var turtles = 0
        
        var animalCounted: [AnimalType: Int] = [:]
        
        for answer in answers {
            switch answer.type {
            case .dog:
                dogs += 1
                animalCounted[.dog] = dogs
            case .cat:
                cats += 1
                animalCounted[.cat] = cats
            case .rabbit:
                rabbits += 1
                animalCounted[.rabbit] = rabbits
            case .turtle:
                turtles += 1
                animalCounted[.turtle] = turtles
            }
        }
        
        let mostFrequentlyMetAnimal = animalCounted.max { a, b in a.value < b.value }
        return mostFrequentlyMetAnimal!.key
        
    }

}
