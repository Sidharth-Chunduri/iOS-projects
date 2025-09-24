// Project: ChunduriSidharth-HW3
// EID: sc69966
// Course: CS329E

import UIKit

protocol TextChangeDelegate: AnyObject {
    func didSaveText(_ text: String)
}

final class TextChangeViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!

    weak var delegate: TextChangeDelegate?
    var initialText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Text"
        textField.text = initialText
    }

    @IBAction private func saveTapped(_ sender: UIButton) {
        delegate?.didSaveText(textField.text ?? "")
        // Do NOT pop here. The spec says the screen does not return
        // to Main until the user taps Back. :contentReference[oaicite:2]{index=2}
    }
}
