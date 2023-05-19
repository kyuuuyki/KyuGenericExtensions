//  swiftlint:disable:this file_name
//
//  +String.swift
//  KyuGenericExtensions
//

//  swiftlint:disable line_length

import Foundation
import UIKit

// MARK: - Date to String
public extension String {
	/// Returns a string representation of a specified date.
	///
	/// - Parameters:
	/// 	- date: The date to format.
	/// 	- format: The date format for represented date.
	/// 	- calendar: The calendar for represented date. If unspecified, the logical calendar for the current user is used.
	/// 	- timeZone: The timezone for represented date. If unspecified, the system time zone is used.
	/// 	
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
	/// Return QRCode image representation of current string.
	///
	/// - Parameters:
	/// 	- size: Size of the generated image.
	/// 	- correctionLevel: Input correction level for the generated image.
	///
	/// - Returns: Generated QRCode Image
	///
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
	/// Finds and returns the boolean indicating whether current string contains a specified substring.
	///
	/// - Parameters:
	/// 	- string: Substring to find.
	/// 	- parameter insensitive: Boolean specified matching mode. `true` for caseInsensitive. `false` if not specified.
	///
	/// - Returns: Boolean for checking result. `true` if current string contains specified substring.
	///
	func contains(string: String, insensitive: Bool = false) -> Bool {
		if insensitive {
			return range(of: string, options: .caseInsensitive) != nil
		}
		return range(of: string) != nil
	}
}

// MARK: - Calculate width and height from String
public extension String {
	/// Returns calculated maximum height of current string for specified width and font.
	///
	/// - Parameters:
	/// 	- width: Maximum width for each line.
	/// 	- font: Font for target string.
	///
	/// - Returns: Calculated height of the string.
	///
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
	
	/// Returns calculated maximum width of current string for specified height and font.
	/// - Parameters:
	/// 	- height: Maximum height for all lines.
	/// 	- font: Font for target string.
	///
	/// - Returns: Calculated width of the string.
	///
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
