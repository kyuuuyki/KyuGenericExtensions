//  swiftlint:disable:this file_name
//
//  +String.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

// MARK: - Date to String
public extension String {
	/// Get TimeString from Date.
	init(
		date: Date,
		format: String,
		locale: Locale = Locale(identifier: "en_US_POSIX"),
		calendar: Calendar = Calendar(identifier: .gregorian),
		timeZone: TimeZone = TimeZone(identifier: "UTC")!
	) {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = locale
		formatter.calendar = calendar
		formatter.timeZone = timeZone
		
		self = formatter.string(from: date)
	}
}

// MARK: - String to QRCode Image
public extension String {
	/// Get QRCode Image from String.
	func toQRCodeImage(of size: CGSize, correctionLevel: String = "Q") -> UIImage? {
		let data = self.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
		let filter = CIFilter(name: "CIQRCodeGenerator")
		
		filter?.setValue(data, forKey: "inputMessage")
		filter?.setValue(correctionLevel, forKey: "inputCorrectionLevel")
		
		if let qrImage = filter?.outputImage {
			let scaleX = size.width / qrImage.extent.size.width
			let scaleY = size.height / qrImage.extent.size.height
			let scaledSize = CGAffineTransform(scaleX: scaleX, y: scaleY)
			let transformedQRImage = qrImage.transformed(by: scaledSize)
			
			let colorParameters = [
				"inputColor0": CIColor(color: .label), // Foreground
				"inputColor1": CIColor(color: .clear) // Background
			]
			
			let coloredQRImage = transformedQRImage.applyingFilter(
				"CIFalseColor",
				parameters: colorParameters
			)
			return UIImage(ciImage: coloredQRImage)
		} else {
			return nil
		}
	}
}

// MARK: - Check if String contains other String
public extension String {
	/// Check if String contains other String.
	func contains(string: String, insensitive: Bool = false) -> Bool {
		if insensitive {
			return range(of: string, options: .caseInsensitive) != nil
		}
		
		return range(of: string) != nil
	}
}

// MARK: - Split String by other String
public extension String {
	/// Split String by other String.
	func split(by separator: Set<String>) -> [String] {
		var string = ""
		var desiredOutput = [String]()
		
		for character in self {
			if separator.contains(String(character)) {
				if !string.isEmpty {
					desiredOutput.append(string)
				}
				
				desiredOutput.append(String(character))
				string = ""
			} else {
				string += String(character)
			}
		}
		
		if !string.isEmpty {
			desiredOutput.append(string)
		}
		
		return desiredOutput
	}
}

// MARK: - Calculate width and height from String
public extension String {
	/// Calculate height from String.
	func height(width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(
			with: constraintRect,
			options: .usesLineFragmentOrigin,
			attributes: [NSAttributedString.Key.font: font],
			context: nil
		)
		
		return ceil(boundingBox.height)
	}
	
	/// Calculate width from String.
	func width(height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(
			with: constraintRect,
			options: .usesLineFragmentOrigin,
			attributes: [NSAttributedString.Key.font: font],
			context: nil
		)
		
		return ceil(boundingBox.width)
	}
}
