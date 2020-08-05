//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Anisha Lamichhane on 6/12/20.
//  Copyright © 2020 Anisha Lamichhane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestion = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SCORE", style: .plain, target: self, action: #selector(showScore))

    }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = " tap on \(countries[correctAnswer].uppercased())'s flag "
    }
    func startNewGame(action: UIAlertAction!) {
        score = 0
        askedQuestion = 0
        askQuestion()
    }
    func close(action: UIAlertAction!) {
        return
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title:String = ""
         UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],animations: { [weak self] in
        for i in 0...2 {
            if sender.tag == self?.correctAnswer {
                sender.transform = CGAffineTransform(translationX: 8 ,y: 8)
                
                title = "Correct!"
                self?.score += 1
               
            }
            else {
                if i != self?.correctAnswer && sender.tag == i {
                    sender.transform = CGAffineTransform(translationX: 8 ,y: 8)
                    
                    title = "wrong ! this is \(self!.countries[i])"
                     self?.score -= 1
                    
                }
            }
        }
    }){ finished in
        sender.transform = .identity
    }
            if askedQuestion < 10 {
                let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
                askedQuestion += 1
            }
            else {
                let finalAlertController = UIAlertController(title: title, message: "Your final score is \(score).", preferredStyle: .alert)
                finalAlertController.addAction(UIAlertAction(title: "Start a new game", style: .default, handler: startNewGame))
                               present(finalAlertController, animated: true)
            }
            
        }
    @objc func showScore() {
        let scoreAlert = UIAlertController(title: "SCORE", message: "Your final score is \(score).", preferredStyle: .alert)
                       scoreAlert.addAction(UIAlertAction(title: "CLOSE", style: .default, handler: close))
                                      present(scoreAlert, animated: true)
     }
    }
    


