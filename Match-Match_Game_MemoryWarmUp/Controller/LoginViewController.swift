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
    
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
        
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
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of FaceBook")
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        guard error == nil else {
            print(error)
            return
        }
        print("LogIn")
//        //Запрос пользовательских данных
//        let request = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields": "id, name, email"])
//        request?.start(completionHandler: { (connection, result, err) in
//            if err != nil {
//                print("Failed with", err!)
//                return
//            }
//
//            // Получаем Имя и Емейл пользователя для передачи в КорДату
//            let fbDetails = result as! NSDictionary
//            let userName = fbDetails["name"] as! String
//             let userEmail = fbDetails["email"] as! String
//
//        })

    }
}

extension LoginViewController {
    //Прячем клавиатуру при при окончании ввода
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
