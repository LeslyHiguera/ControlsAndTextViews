//  ProyectoCompartido


import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPikerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    
    
    
    // MARK: - IBAction
    
    @IBAction func myButtonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPagesControlAction(_ sender: Any) {
        myPikerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        
        mySegmentedControl.selectedSegmentIndex =
        myPageControl.currentPage
    }
    
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        myPikerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage =
        mySegmentedControl.selectedSegmentIndex
        
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        
        var progress: Float = 0
        
        print(mySlider.value)
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            progress = 0.2
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            progress = 0.4
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progress = 0.6
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progress = 0.8
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progress = 1

        }
        myProgressView.progress = progress
    }
    
    
    
    @IBAction func myStepperAction(_ sender: Any) {
        let value = myStepper.value
        mySlider.value = Float(value)
        
        myStepperLabel.text = "\(value)"
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn {
            myPikerView.isHidden = false
            myActivityIndicator.stopAnimating()

            mySwitchLabel.text = "Esta encendido"
            
        } else {
            myPikerView.isHidden = true
            myActivityIndicator.startAnimating()
            mySwitchLabel.text = "Esta apagado"
        }
        
    }
    
    // MARK: - Private Properties
    
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    // MARK:  - Life cycle view controlers methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        
        myButton.setTitle("My button", for: .normal)
        myButton.backgroundColor = .green
        myButton.setTitleColor(.white, for: .normal)
        
        // Pickers
        
        myPikerView.backgroundColor = .lightGray
        myPikerView.dataSource = self
        myPikerView.delegate = self
        myPikerView.isHidden = true
        
        // Pages Controls
        
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .yellow
        myPageControl.pageIndicatorTintColor = . lightGray
    
        // Segmented Controls

        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated() {
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Slider
        
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        // Steppers
        
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        
        // Switch
        
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        // Progress Indicators
        
        myProgressView.progress = 0
        myActivityIndicator.color = .orange
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        
        //Labels
        
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 11)
        myStepperLabel.text = "1"
        mySwitchLabel.text = "Esta apagado"

        // Text Field
        
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        // Text View
        
        myTextView.textColor = .brown
        myTextView.delegate = self
    }
    
}

// UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        myPageControl.currentPage = row
        mySegmentedControl.selectedSegmentIndex = row
    }
    
}

// UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextField.text, for: .normal)
    }
    
}

// UITextViewDelegate

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
    
}

