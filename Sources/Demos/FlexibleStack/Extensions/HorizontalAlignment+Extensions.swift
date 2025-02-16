import SwiftUI

extension HorizontalAlignment {
  var percentage: Double {
    switch self {
    case .leading: 0
    case .trailing: 1
    default: 0.5
    }
  }
}
