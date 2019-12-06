import UIKit

public extension CALayer {

    func add(sublayers: CALayer...) {
        sublayers.forEach { addSublayer($0) }
    }

}
