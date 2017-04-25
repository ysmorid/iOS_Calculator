//
//  GraphViewController.swift
//  Calculator
//
//  Created by Ylia Moridzadeh on 4/24/17.
//  Copyright © 2017 Ylia Moridzadeh. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var function: ((Double) -> Double)?

    @IBOutlet weak var graphView: GraphView! {
        didSet {
           graphView.function = function
        }
    }
}
