//
//  StarControl.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class StarControl: UIControl {
	var value = 0
	
	private let componentDimension: CGFloat = 40.0
	private let componentCount = 4
	private let componentActiveColor = UIColor.black
	private let componentInactiveColor = UIColor.gray
	
	private(set) var wasTriggered = false
	private(set) var starLabels: [UILabel] = []
	
	required init?(coder aCoder: NSCoder) {
		super.init(coder: aCoder)
		setup()
	}
	
	
	private func setup() {
		for i in 0...4 {
			let label = UILabel()
			let frame =  CGRect(x: 8.0 + componentDimension * CGFloat(i), y: 0, width: componentDimension, height: componentDimension)
			label.frame = frame
			label.tag = i + 1
			label.font = UIFont.boldSystemFont(ofSize: 32)
			//"★"
			label.text = "☆"
			performFlare()
			starLabels.append(label)
		}
//		starLabels[0].textColor = .red
		starLabels.forEach( { addSubview( $0 )} )
	}
	
	override var intrinsicContentSize: CGSize {
		let componentsWidth = CGFloat(componentCount) * componentDimension
		let componentsSpacing = CGFloat(componentCount + 1) * 8.0
		let width = componentsWidth + componentsSpacing
		return CGSize(width: width, height: componentDimension)
	}
	
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		updateValue(at: touch)
		return true
	}
	
	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let location = touch.location(in: self)
		
		if bounds.contains(location) {
			updateValue(at: touch)
			sendActions(for: [.touchDragInside,  .touchDragOutside])
		} else {
			updateValue(at: touch)
		}
		
		return true
	}
	
	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		guard let touch = touch else { return }
		let location = touch.location(in: self)
		
		if bounds.contains(location) {
			sendActions(for: [.touchUpInside, .touchUpOutside])
		} else {
			updateValue(at: touch)
		}
		sendActions(for: [.valueChanged])
		
	}
	
	override func cancelTracking(with event: UIEvent?) {
		sendActions(for: [.touchCancel])
	}
	
	func updateValue(at touch: UITouch) {
		let location = touch.location(in: self)
		for label in starLabels {
			if label.frame.contains(location) {
				value = label.tag
				isRated(value: value)
				label.performFlare()
//				sendActions(for: [.valueChanged])
			}
		}
		
		
	}
	
	func isRated(value: Int) {
		for i in 0..<value {
			starLabels[i].textColor = .red
		}
		
		unRated(value: value)
	}
	
	func unRated(value: Int) {
		for label in starLabels {
			if label.tag > value {
				label.textColor = .black
			}
		}
	}
}
