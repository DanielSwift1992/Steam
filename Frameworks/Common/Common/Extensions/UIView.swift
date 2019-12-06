import SnapKit

public extension UIView {

    enum ViewSide: CaseIterable {
        case left, right, top, bottom
    }

    @discardableResult
    func add(subviews: UIView...) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }

    func add(sublayers: CALayer...) {
        sublayers.forEach { layer.addSublayer($0) }
    }

    func addBorder(color: UIColor, width: CGFloat, to sides: ViewSide...) {
        sides.forEach { addBorder(color: color, width: width, side: $0) }
    }

    func addBorder(color: UIColor, width: CGFloat, except sides: ViewSide...) {
        ViewSide.allCases.filter { !sides.contains($0) }.forEach {
            addBorder(color: color, width: width, side: $0)
        }
    }

}

private extension UIView {

    func addBorder(color: UIColor, width: CGFloat, side: ViewSide) {
        let border = UIView()
        border.backgroundColor = color
        addSubview(border)

        switch side {
        case .left:
            border.snp.makeConstraints {
                $0.width.equalTo(width)
                $0.left.top.bottom.equalToSuperview()
            }
        case .right:
            border.snp.makeConstraints {
                $0.width.equalTo(width)
                $0.right.top.bottom.equalToSuperview()
            }
        case .top:
            border.snp.makeConstraints {
                $0.height.equalTo(width)
                $0.top.right.left.equalToSuperview()
            }
        case .bottom:
            border.snp.makeConstraints {
                $0.height.equalTo(width)
                $0.bottom.right.left.equalToSuperview()
            }
        }
    }

}
