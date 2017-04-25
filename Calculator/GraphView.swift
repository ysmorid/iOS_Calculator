import UIKit

@IBDesignable
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
    
    func changeView(byReactingTo panRecognizer: UIPanGestureRecognizer) {
        switch panRecognizer.state {
        case .changed, .ended:
            let move = panRecognizer.translation(in: self)
            origin = CGPoint(x: origin.x + move.x, y: origin.y + move.y)
            panRecognizer.setTranslation(CGPoint.zero, in: self)

        default:
            break
        }
    }
    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer) {
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    func changeOrigin(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            origin = tapRecognizer.location(in: self)
        }
    }
    
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
        
        var startingPoint: Bool = true
        
        if function != nil {
            for x in 0...Int(bounds.width * scale) {
                let pointX = CGFloat(x) / scale
                
                let xValue = Double((pointX - origin.x) / scale)
                let yValue = function!(xValue)
                
                if !yValue.isZero && !yValue.isNormal {
                    startingPoint = true
                    continue
                }
                
                let pointY = origin.y - CGFloat(yValue) * scale
                
                if startingPoint {
                    path.move(to: CGPoint(x: pointX, y: pointY))
                    startingPoint = false
                } else {
                    path.addLine(to: CGPoint(x: pointX, y: pointY))
                    
                }
            }
        }
        path.stroke()
    }
    
}


