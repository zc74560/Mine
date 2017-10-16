//
//  ViewController.swift
//  Mine
//
//  Created by 赵安 on 2017/9/28.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameTimeField: UITextField!
    @IBOutlet weak var gameNumField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @IBAction func beginGame(_ sender: Any) {
        self.performSegue(withIdentifier: "firstSegue", sender: nil)
    }
    
    
    @IBAction func viewClick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
            let nextController = segue.destination as! GameViewController
            nextController.gameTime = Int(gameTimeField.text!)!
            nextController.gameNum = Int(gameNumField.text!)!
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
