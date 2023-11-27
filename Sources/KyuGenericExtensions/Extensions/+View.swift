//  swiftlint:disable:this file_name
//
//  +View.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

#if canImport(SwiftUI)
import SwiftUI

public extension View {
	/// Rounding current view and apply border to it.
	///
	/// - Parameters:
	///   - cornerRadius: The radius of the rounded corners.
	///   - borderWidth: The width of the stroke that outlines this shape.
	///   - borderColor: The color with which to stroke this shape.
	func cornerRadius(
		_ radius: CGFloat,
		borderWidth: CGFloat,
		borderColor: Color
	) -> some View {
		self.clipShape(
			RoundedRectangle(cornerRadius: radius)
		)
		.overlay(
			RoundedRectangle(cornerRadius: radius)
				.inset(by: borderWidth / 2)
				.stroke(borderColor, lineWidth: borderWidth)
		)
	}
}

@available(iOS 15.0, *)
public extension View {
	/// Overlays this view with shape applied with a color or gradient.
	///
	/// - Parameters:
	///   - fill: The color or gradient to use when filling this shape.
	///   - fillHeight: The heigt of color or gradient to use when filling this shape.
	///   - blurHeight: The heigt of blurred color or gradient to use when filling this shape.
	///   - startPoint: The start point that determine how the fill renders.
	///   - endPoint: The end point that determine how the fill renders.
	/// - Returns: A view overlayed with shape filled with the color or gradient you supply.
	func gradient<S>(
		_ fill: S,
		fillHeight: CGFloat = .zero,
		blurHeight: CGFloat? = nil,
		startPoint: VerticalEdge,
		endPoint: VerticalEdge
	) -> some View where S: ShapeStyle {
		self.overlay(
			Rectangle()
				.fill(fill)
				.mask {
					VStack(spacing: .zero) {
						if startPoint == .top {
							Rectangle()
								.frame(height: fillHeight)
						} else {
							Spacer(minLength: .zero)
						}
						LinearGradient(
							colors: [
								Color.primary.opacity(1),
								Color.primary.opacity(0),
							],
							startPoint: startPoint == .top ? .top : .bottom,
							endPoint: endPoint == .top ? .top : .bottom
						)
						.frame(height: blurHeight)
						if startPoint == .bottom {
							Rectangle()
								.frame(height: fillHeight)
						} else {
							Spacer(minLength: .zero)
						}
					}
				}
		)
	}
	
	/// Overlays this view with shape applied with a color or gradient.
	///
	/// - Parameters:
	///   - fill: The color or gradient to use when filling this shape.
	///   - fillWidth: The heigt of color or gradient to use when filling this shape.
	///   - blurWidth: The width of blurred color or gradient to use when filling this shape.
	///   - startPoint: The start point that determine how the fill renders.
	///   - endPoint: The end point that determine how the fill renders.
	/// - Returns: A view overlayed with shape filled with the color or gradient you supply.
	func gradient<S>(
		_ fill: S,
		fillWidth: CGFloat = .zero,
		blurWidth: CGFloat? = nil,
		startPoint: HorizontalEdge,
		endPoint: HorizontalEdge
	) -> some View where S: ShapeStyle {
		self.overlay(
			Rectangle()
				.fill(fill)
				.mask {
					HStack(spacing: .zero) {
						if startPoint == .leading {
							Rectangle()
								.frame(width: fillWidth)
						} else {
							Spacer(minLength: .zero)
						}
						LinearGradient(
							colors: [
								Color.primary.opacity(1),
								Color.primary.opacity(0),
							],
							startPoint: startPoint == .leading ? .leading : .trailing,
							endPoint: endPoint == .leading ? .leading : .trailing
						)
						.frame(width: blurWidth)
						if startPoint == .trailing {
							Rectangle()
								.frame(width: fillWidth)
						} else {
							Spacer(minLength: .zero)
						}
					}
				}
		)
	}
}

public extension View {
	/// A size that specifies the height and width of the connected scenes' keyWindow.
	var windowSize: CGSize {
		UIApplication.shared.window?.bounds.size ?? .zero
	}
	
	/// The insets that you use to determine the safe area for the connected scenes' keyWindow.
	var safeAreaInsets: EdgeInsets {
		let insets = UIApplication.shared.window?.safeAreaInsets ?? .zero
		return EdgeInsets(
			top: insets.top,
			leading: insets.left,
			bottom: insets.bottom,
			trailing: insets.right
		)
	}
}

@available(iOS 16.0, *)
public extension View {
	/// Adds an action to perform when the frame changes.
	///
	/// - Parameters:
	///   - coordinateSpace: The coordinate space of the view hierarchy
	///   that will be used as a reference frame.
	///   - action: The action to perform when the value for frame changes. The
	///     `action` closure passes the new value as its parameter.
	///
	/// - Returns: A view that triggers `action` when the value for frame changes.
	func onPreferenceFrameChange(
		in coordinateSpace: CoordinateSpace = .global,
		perform action: @escaping (CGRect) -> Void
	) -> some View {
		self
			.overlay {
				GeometryReader { geo in
					Color.clear.preference(
						key: FramePreferenceKey.self,
						value: geo.frame(in: coordinateSpace)
					)
				}
			}
			.onPreferenceChange(FramePreferenceKey.self, perform: action)
	}
}

struct FramePreferenceKey: PreferenceKey {
	static var defaultValue: CGRect = .zero
	
	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
		value = nextValue()
	}
}
#endif
