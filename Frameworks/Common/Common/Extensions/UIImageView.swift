import AlamofireImage

public extension UIImageView {

    func setImage(url: URL?) {
        af_cancelImageRequest()
        guard let url = url else { return }
        af_setImage(withURL: url)
    }

}
