//
//  LazyXGrid.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

import SwiftUI

/// A container view that arranges its child views in a grid that
/// grows horizontally or vertically, creating items only as needed.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct LazyXGrid<Content>: View where Content: View {
	// MARK: INITIALIZERS
	
	// swiftlint:disable line_length
	/// Creates a grid that grows horizontally.
	///
	/// - Parameters:
	///   - height: Designated height of the grid.
	///   Required when header exists.
	///   May be specify outside of the grid using 
	///   [frame(width:height:alignment:)](https://developer.apple.com/documentation/swiftui/view/frame(width:height:alignment:))
	///   - rows: A number of rows in the grid.
	///   - alignment: The alignment of the grid within its parent view.
	///   - spacing: The spacing between the grid and the next item in its
	///   parent view.
	///   - pinnedViews: Views to pin to the bounds of a parent scroll view.
	///   - content: The content of the grid.
	public init(
		height: CGFloat? = nil, // Required when header exists
		rows: Int,
		alignment: VerticalAlignment = .center,
		spacing: CGFloat? = nil,
		pinnedViews: PinnedScrollableViews = .init(),
		@ViewBuilder content: @escaping () -> Content
	) {
		self.axis = .horizontal
		self.gridSize = height
		self.gridItems = Array(
			repeating: GridItem(
				.flexible(),
				spacing: spacing ?? .zero,
				alignment: .center
			),
			count: rows
		)
		self.spacing = spacing ?? .zero
		self.verticalAlignment = alignment
		self.pinnedViews = pinnedViews
		self.content = content
	}
	// swiftlint:enable line_length
	
	// swiftlint:disable line_length
	/// Creates a grid that grows vertically.
	///
	/// - Parameters:
	///   - width: Designated width of the grid.
	///   Required when header exists.
	///   May be specify outside of the grid using 
	///   [frame(width:height:alignment:)](https://developer.apple.com/documentation/swiftui/view/frame(width:height:alignment:))
	///   - columns: A number of columns in the grid.
	///   - alignment: The alignment of the grid within its parent view.
	///   - spacing: The spacing between the grid and the next item in its
	///   parent view.
	///   - pinnedViews: Views to pin to the bounds of a parent scroll view.
	///   - content: The content of the grid.
	public init(
		width: CGFloat? = nil,
		columns: Int,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		pinnedViews: PinnedScrollableViews = .init(),
		@ViewBuilder content: @escaping () -> Content
	) {
		self.axis = .vertical
		self.gridSize = width
		self.gridItems = Array(
			repeating: GridItem(
				.flexible(),
				spacing: spacing ?? .zero,
				alignment: .center
			),
			count: columns
		)
		self.horizontalAlignment = alignment
		self.spacing = spacing ?? .zero
		self.pinnedViews = pinnedViews
		self.content = content
	}
	// swiftlint:enable line_length
	
	// MARK: VARIABLES
	var axis: Axis
	var gridSize: CGFloat?
	var gridItems: [GridItem]
	var verticalAlignment: VerticalAlignment = .center
	var horizontalAlignment: HorizontalAlignment = .center
	var spacing: CGFloat?
	var pinnedViews: PinnedScrollableViews
	var content: () -> Content
	
	// MARK: BODY
	public var body: some View {
		switch axis {
		case .horizontal:
			LazyHGrid(
				rows: gridItems,
				alignment: verticalAlignment,
				spacing: spacing,
				pinnedViews: pinnedViews,
				content: content
			)
			.frame(height: gridSize)
			
		case .vertical:
			LazyVGrid(
				columns: gridItems,
				alignment: horizontalAlignment,
				spacing: spacing,
				pinnedViews: pinnedViews,
				content: content
			)
			.frame(width: gridSize)
		}
	}
}

// MARK: - PREVIEW
@available(iOS 15.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct LazyXGrid_Previews: PreviewProvider {
	static var previews: some View {
		let viewModels: [String] = (1..<12).compactMap { number in
			var title = "\(number)\n"
			for _ in 0..<number {
				title += "•"
			}
			return title
		}
		let spacing: CGFloat = 16
		let contentViewRatio: CGFloat = 2 / 3
		let backgroundColor: Color = .gray.opacity(0.15)
		
		ScrollView {
			VStack {
				Text("Horizontal - View Height")
				ScrollView(.horizontal) {
					LazyXGrid(
						height: 180,
						rows: 2,
						spacing: spacing,
						pinnedViews: [.sectionHeaders]
					) {
						Section {
							ForEach(viewModels, id: \.self) { viewModel in
								ContentView(text: viewModel)
									.aspectRatio(contentViewRatio, contentMode: .fill)
							}
						} header: {
							HeaderView()
						}
					}
					.background(backgroundColor)
					.padding()
				}
				
				Text("Horizontal - Content Height")
				ScrollView(.horizontal) {
					LazyXGrid(
						rows: 2,
						spacing: spacing,
						pinnedViews: [.sectionHeaders]
					) {
						Section {
							ForEach(viewModels, id: \.self) { viewModel in
								ContentView(text: viewModel)
									.aspectRatio(contentViewRatio, contentMode: .fill)
							}
						} header: {
							HeaderView()
						}
					}
					.frame(height: 180) // Required when header exists
					.background(backgroundColor)
					.padding()
				}
				
				Text("Vertical - View Width")
				LazyXGrid(
					width: 320,
					columns: 4,
					spacing: spacing,
					pinnedViews: [.sectionHeaders]
				) {
					Section {
						ForEach(viewModels, id: \.self) { viewModel in
							ContentView(text: viewModel)
								.aspectRatio(contentViewRatio, contentMode: .fill)
						}
					} header: {
						HeaderView()
					}
				}
				.background(backgroundColor)
				.padding()
				
				Text("Vertical - Content Width")
				LazyXGrid(
					columns: 4,
					spacing: spacing,
					pinnedViews: [.sectionHeaders]
				) {
					Section {
						ForEach(viewModels, id: \.self) { viewModel in
							ContentView(text: viewModel)
								.aspectRatio(contentViewRatio, contentMode: .fill)
						}
					} header: {
						HeaderView()
					}
				}
				.background(backgroundColor)
				.padding()
			}
		}
	}
	
	struct ContentView: View {
		var text: String
		
		var body: some View {
			Text(text)
				.multilineTextAlignment(.center)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding(4)
				.frame(minWidth: 0, maxWidth: .infinity)
				.background(.yellow)
				.clipShape(RoundedRectangle(cornerRadius: 8))
		}
	}
	
	struct HeaderView: View {
		var body: some View {
			Image(systemName: "pin.square.fill")
				.padding()
				.foregroundStyle(.white)
				.background(.red)
				.clipShape(RoundedRectangle(cornerRadius: 8))
		}
	}
}
