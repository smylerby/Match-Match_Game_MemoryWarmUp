//
//  LoginViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var saveNameOutlet: UIButton!
    
    @IBAction func showResults(_ sender: UIButton) {
        
    }
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Жест для скрывания клавиатуры при нажатии на вью
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launchGameSegue" {
            let destVC = segue.destination as! MatchGameViewController
            if let playersName = nameTextField.text {
                destVC.playersName = playersName
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
