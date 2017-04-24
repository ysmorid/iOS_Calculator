import UIKit

class GraphView: UIView {
    
    var function: ((Double) -> Double)? {
        didSet { setNeedsDisplay() }
    }
    
    private var isOriginSet: Bool = false
    private var origin = CGPoint(x:0, y:0) { didSet { setNeedsDisplay()}}
    
    @IBInspectable
    var scale: CGFloat = 10.0 { didSet { setNeedsDisplay()}}
    @IBInspectable
    var lineWidth: CGFloat = 3.0 { didSet { setNeedsDisplay()}}
    @IBInspectable
    var color: UIColor = UIColor.black { didSet { setNeedsDisplay()}}
    
    override func draw(_ rect: CGRect) {
        if !isOriginSet {
            origin = CGPoint(x: bounds.midX, y: bounds.midY)
            isOriginSet = true
        }
        
        let axesDrawer = AxesDrawer()
        axesDrawer.drawAxes(in: rect, origin: origin, pointsPerUnit: scale)
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        color.set()
        path.stroke()
    }
    
}


