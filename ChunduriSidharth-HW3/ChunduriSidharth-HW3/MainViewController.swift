// Project: ChunduriSidharth-HW3
// EID: sc69966
// Course: CS329E

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var displayLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple Segue"
        displayLabel.text = "Text goes here"
        displayLabel.backgroundColor = .systemGray6
        displayLabel.layer.cornerRadius = 8
        displayLabel.clipsToBounds = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let textVC = segue.destination as? TextChangeViewController {
            // Pass current label text forward
            textVC.initialText = displayLabel.text ?? ""
            // Set delegate for callbacks
            textVC.delegate = self
        } else if let colorVC = segue.destination as? ColorChangeViewController {
            colorVC.delegate = self
        }
    }
}

extension MainViewController: TextChangeDelegate {
    func didSaveText(_ text: String) {
        displayLabel.text = text
    }
}

extension MainViewController: ColorChangeDelegate {
    func didPickColor(_ color: UIColor) {
        displayLabel.backgroundColor = color
    }
}
