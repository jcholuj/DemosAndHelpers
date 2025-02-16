import SwiftUI

extension VerticalAlignment {
  var percentage: Double {
    switch self {
    case .top: 0
    case .bottom: 1
    default: 0.5
    }
  }
}
