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
//            
//            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(recognizer:)))
//            graphView.addGestureRecognizer(panGestureRecognizer)
//            
            let handler = #selector(GraphView.changeScale(byReactingTo: ))
            let pinchRecognizer = UIPinchGestureRecognizer(target: graphView, action: handler)
            graphView.addGestureRecognizer(pinchRecognizer)
        }
    }
}
