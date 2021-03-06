//
//  LoginViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var saveNameOutlet: UIButton!
    
    @IBAction func showResultsPressed(_ sender: UIButton) {

        let resultsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resultsVC") as! ResultsViewController
        self.present(resultsVC, animated: true, completion: nil)

    }
    
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
        
        // При пустом ТекстФилде не пускаем в игру
        if nameTextField.text != "" {
            nameTextField.alpha = 0.6
            nameTextField.isUserInteractionEnabled = false
            sender.setTitle("LOGGED!", for: .normal)
            sender.backgroundColor = UIColor(hue: 0.3361, saturation: 0.76, brightness: 0.8, alpha: 1)
            sender.isUserInteractionEnabled = false
            startButtonOutlet.isHidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Let's warm up!"
        
        //Жест для скрывания клавиатуры при нажатии на вью
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //Добавляем кнопку Логина через Фейсбук
        let loginFBButton = FBSDKLoginButton()
        loginFBButton.frame = CGRect(x: 16, y: 100, width: view.frame.width - 32 , height: 50)
        view.addSubview(loginFBButton)
        loginFBButton.delegate = self
        
    }
    // Показать результаты из логинки
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launchGameSegue" {
            let destVC = segue.destination as! MatchGameViewController
            if let playersName = nameTextField.text {
                destVC.playersName = playersName
            }
        }
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    // При логауте из Фейсбука возврадаем кнопку SAVE
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        nameTextField.text = ""
        saveNameOutlet.setTitle("SAVE", for: .normal)
        saveNameOutlet.backgroundColor = UIColor(red: 0.252, green: 0.529, blue: 0.97, alpha: 1)
        startButtonOutlet.isHidden = true
    }
    
    // Действия при нажатии на Логин
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        guard error == nil else {
            print(error)
            return
        }
        //Запрос пользовательских данных
        let request = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields": "id, name, email"])
        request?.start(completionHandler: { (connection, result, err) in
            if err != nil {
                print("Failed with", err!)
                return
            }
            // Получаем Имя и Емейл пользователя для передачи в КорДату
            let fbDetails = result as! NSDictionary
            let userName = fbDetails["name"] as! String
            
            // Присваиваем Полю ввода имени Имя пользлвателя из Фейсбука
            self.nameTextField.text = userName
        })
    }
}

extension LoginViewController {
    //Прячем клавиатуру при окончании ввода
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
