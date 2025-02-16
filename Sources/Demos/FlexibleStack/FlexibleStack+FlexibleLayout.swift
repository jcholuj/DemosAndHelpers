import SwiftUI

extension FlexibleStack {
  struct FlexibleLayout {
    var bounds: CGSize = .zero
    var rows: [RowLayout] = []

    init(proposal: ProposedViewSize, subviews: Subviews, spacing: CGFloat?) {
      let maxWidth = proposal.replacingUnspecifiedDimensions().width
      var remainingWidth = maxWidth.isFinite ? maxWidth : .greatestFiniteMagnitude
      var rowYPosition: CGFloat = .zero
      var currentRowHeight: CGFloat = .zero
      var row: RowLayout = .empty

      for (index, subview) in subviews.enumerated() {
        let idealSize = subview.sizeThatFits(.unspecified)
        let potentialRowWidth = idealSize.width + horizontalSpacing(index)
        if index != .zero && potentialRowWidth > remainingWidth {
          addRow(index: max(index - 1, .zero), idealSize: idealSize)
        }
        addItem(index: index, idealSize: idealSize)

        if index == subviews.count - 1 {
          addRow(index: index, idealSize: idealSize)
        }
      }

      func horizontalSpacing(_ index: Int) -> Double {
        guard row.items.count > .zero else { return .zero }
        let previousSubview = subviews[index - 1]
        let subview = subviews[index]
        return spacing ?? previousSubview.spacing.distance(to: subview.spacing, along: .horizontal)
      }

      func addItem(index: Int, idealSize: CGSize) {
        let width = idealSize.width + horizontalSpacing(index)
        let xOffset = maxWidth - remainingWidth + horizontalSpacing(index)
        remainingWidth -= width
        currentRowHeight = max(currentRowHeight, idealSize.height)
        let rowWidth = maxWidth - remainingWidth
        row.items.append(.init(xOffset: xOffset, index: index))
        row.frame = CGRect(x: .zero, y: rowYPosition, width: rowWidth, height: currentRowHeight)
      }

      func addRow(index: Int, idealSize: CGSize) {
        let verticalSubviewsSpacing = spacing ?? ViewSpacing().distance(to: ViewSpacing(), along: .vertical)
        self.rows.append(row)

        rowYPosition += currentRowHeight + verticalSubviewsSpacing
        resetProperties()
      }

      func resetProperties() {
        currentRowHeight = 0
        remainingWidth = maxWidth
        row = .empty
      }
    }
  }
}

extension FlexibleStack.FlexibleLayout {
  struct RowLayout {
    var items: [ItemLayout]
    var frame: CGRect

    static let empty: Self = .init(items: [], frame: .zero)
  }
}

extension FlexibleStack.FlexibleLayout.RowLayout {
  struct ItemLayout {
    let xOffset: CGFloat
    let index: Int
  }
}
