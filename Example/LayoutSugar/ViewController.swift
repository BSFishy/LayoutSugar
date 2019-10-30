//
//  ViewController.swift
//  LayoutSugar
//
//  Created by Matt Provost on 10/25/2019.
//  Copyright (c) 2019 Matt Provost. All rights reserved.
//

import UIKit
import LayoutSugar

class ViewController: UIViewController {
    fileprivate var label: UILabel!
    fileprivate var textField: UITextField!
    fileprivate var button: UIButton!

    fileprivate var switchLabel: UILabel!
    fileprivate var uiSwitch: UISwitch!

    fileprivate var segmentedLabel: UILabel!
    fileprivate var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        prepareLabel()
        prepareTextField()
        prepareButton()

        prepareSwitchLabel()
        prepareSwitch()

        prepareSegmentedControl()
        prepareSegmentedLabel()
    }
}

extension ViewController {
    fileprivate func prepareLabel() {
        label = UILabel()

        label.text = "Enter some text"
        label.numberOfLines = 1

        view.layout(label)
            .leading(30)
            .trailing(30)
            .top(view.centerY).multiply(0.5)
    }

    fileprivate func prepareTextField() {
        textField = UITextField()

        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect

        view.layout(textField)
            .top(label.bottom, 15)
            .leading(30)
    }

    fileprivate func prepareButton() {
        button = UIButton(type: .system)

        button.setTitle("Enter", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)

        view.layout(button)
            .top(label.bottom, 15)
            .leading(textField.trailing, 20)
            .trailing(30)
            .width(64)
    }

    fileprivate func prepareSwitchLabel() {
        switchLabel = UILabel()

        switchLabel.numberOfLines = 1

        view.layout(switchLabel)
            .top(textField.bottom, 25)
            .leading(35)
    }

    fileprivate func prepareSwitch() {
        uiSwitch = UISwitch()

        handleSwitch(uiSwitch: uiSwitch)
        uiSwitch.addTarget(self, action: #selector(handleSwitch(uiSwitch:)), for: .valueChanged)

        view.layout(uiSwitch)
            .top(textField.bottom, 25)
            .leading(switchLabel.trailing, 15, >=)
            .trailing(35)
    }

    fileprivate func prepareSegmentedControl() {
        segmentedControl = UISegmentedControl(items: [RED, GREEN, BLUE])

        segmentedControl.addTarget(self, action: #selector(handleSegmented(segment:)), for: .valueChanged)

        view.layout(segmentedControl)
            .top(switchLabel.bottom, 25)
            .trailing(35)
    }

    fileprivate func prepareSegmentedLabel() {
        segmentedLabel = UILabel()

        segmentedLabel.text = "Choose a color"
        segmentedLabel.numberOfLines = 1

        view.layout(segmentedLabel)
            .centerY(segmentedControl.centerY)
            .leading(35)
            .trailing(segmentedControl.leading)
    }
}

fileprivate let RED = "Red"
fileprivate let GREEN = "Green"
fileprivate let BLUE = "Blue"

extension ViewController {
    @objc fileprivate func handleButton() {
        label.text = "Value: \(textField.text ?? "nothing")"
    }

    @objc fileprivate func handleSwitch(uiSwitch: UISwitch) {
        switchLabel.text = "Switch value: \(uiSwitch.isOn ? "on" : "off")"
    }

    @objc fileprivate func handleSegmented(segment: UISegmentedControl) {
        let color = segment.titleForSegment(at: segment.selectedSegmentIndex)
        segmentedLabel.text = "Value: \(color ?? "unknown")"

        switch color {
            case RED:
                segmentedLabel.textColor = .systemRed
            case GREEN:
                segmentedLabel.textColor = .systemGreen
            case BLUE:
                segmentedLabel.textColor = .systemBlue
            default:
                segmentedLabel.textColor = .darkText
        }
    }
}
