import SwiftUI

public struct FlexibleStack: Layout {
  private let alignment: Alignment
  private let spacing: CGFloat?

  public init(
    alignment: Alignment = .center,
    spacing: CGFloat? = nil
  ) {
    self.alignment = alignment
    self.spacing = spacing
  }

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
    let layout = FlexibleLayout(
      proposal: proposal,
      subviews: subviews,
      spacing: spacing
    )
    return .init(
      width: self.makeWidth(proposal: proposal, layout: layout),
      height: self.makeHeight(proposal: proposal, layout: layout)
    )
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
    let layout = FlexibleLayout(
      proposal: proposal,
      subviews: subviews,
      spacing: self.spacing
    )
    self.placeSubviews(in: bounds, using: layout, subviews: subviews)

  }

  private func placeSubviews(in bounds: CGRect, using layout: FlexibleLayout, subviews: Subviews) {
    for row in layout.rows {
      let rowXOffset = (bounds.width - row.frame.width) * self.alignment.horizontal.percentage
      for item in row.items {
        let xPosition = rowXOffset + row.frame.minX + item.xOffset + bounds.minX
        let rowYAlignment = (row.frame.height - subviews[item.index].sizeThatFits(.unspecified).height) *
        self.alignment.vertical.percentage
        let yPosition = row.frame.minY + rowYAlignment + bounds.minY
        subviews[item.index].place(at: CGPoint(x: xPosition, y: yPosition), anchor: .topLeading, proposal: .unspecified)
      }
    }
  }

  private func makeWidth(proposal: ProposedViewSize, layout: FlexibleLayout) -> CGFloat {
    let maxWidth = proposal.replacingUnspecifiedDimensions().width
    let maxRowWidth = layout.rows.map(\.frame.width).max() ?? maxWidth
    return maxRowWidth > maxWidth ? maxWidth : maxRowWidth
  }

  private func makeHeight(proposal: ProposedViewSize, layout: FlexibleLayout) -> CGFloat {
    let verticalSubviewsSpacing = self.spacing ?? ViewSpacing().distance(to: ViewSpacing(), along: .vertical)
    let rowsHeight = layout.rows.map(\.frame.height).reduce(0, +)
    return CGFloat(max(layout.rows.count, 1) - 1) * verticalSubviewsSpacing + rowsHeight
  }
}
