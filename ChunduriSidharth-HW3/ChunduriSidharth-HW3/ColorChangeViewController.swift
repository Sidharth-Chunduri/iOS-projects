// Project: ChunduriSidharth-HW3
// EID: sc69966
// Course: CS329E

import UIKit

protocol ColorChangeDelegate: AnyObject {
    func didPickColor(_ color: UIColor)
}

final class ColorChangeViewController: UIViewController {

    weak var delegate: ColorChangeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Color"
    }

    @IBAction private func blueTapped(_ sender: UIButton) {
        delegate?.didPickColor(.systemBlue)
        // Stay on this screen; user will tap Back to return. :contentReference[oaicite:3]{index=3}
    }

    @IBAction private func redTapped(_ sender: UIButton) {
        delegate?.didPickColor(.systemRed)
    }
}
