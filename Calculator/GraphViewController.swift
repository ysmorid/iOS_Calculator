
import UIKit

class GraphViewController: UIViewController {
    
    var function: ((Double) -> Double)?

    @IBOutlet weak var graphView: GraphView! {
        didSet {
           graphView.function = function
            
            let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GraphView.changeView(byReactingTo: )))
            graphView.addGestureRecognizer(panRecognizer)

            let pinchRecognizer = UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.changeScale(byReactingTo: )))
            graphView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(GraphView.changeOrigin(byReactingTo: )))
            tapRecognizer.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapRecognizer)
        }
    }
}
