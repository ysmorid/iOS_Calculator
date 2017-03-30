//
//  ViewController.swift
//  Calculator
//
//  Created by Ylia Moridzadeh on 3/30/17.
//  Copyright © 2017 Ylia Moridzadeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle
        print("\(String(describing: digit)) was pressed.")
    }

}

