import SwiftUI


// MARK: - Styling Extensions

extension View {
    func primaryButtonStyle() -> some View {
        self
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.primary)
            .cornerRadius(10)
    }
    
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.3), radius: 5)
    }
}

// MARK: - Layout Extensions

extension View {
    func fillScreen() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func fillWidth() -> some View {
        self.frame(maxWidth: .infinity)
    }
    
    func centerInScreen() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
    }
}

// MARK: - Conditional Extensions

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func ifLet<T, Content: View>(_ optional: T?, transform: (Self, T) -> Content) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

// MARK: - Responsive Design Extensions

extension View {
    func responsiveFrame(idealWidth: CGFloat) -> some View {
        self.frame(minWidth: idealWidth * 0.7, idealWidth: idealWidth, maxWidth: idealWidth * 1.2)
    }
    
    func adaptiveStack(
        horizontal: Bool,
        spacing: CGFloat = 8,
        alignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center
    ) -> some View {
        Group {
            if horizontal {
                HStack(alignment: verticalAlignment, spacing: spacing) {
                    self
                }
            } else {
                VStack(alignment: alignment, spacing: spacing) {
                    self
                }
            }
        }
    }
    
    func adaptivePadding(_ horizontalPadding: CGFloat = 20, _ verticalPadding: CGFloat = 20) -> some View {
        self.padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
    }
}

// MARK: - Typography Extensions

extension View {
    func titleText() -> some View {
        self.font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
    func headlineText() -> some View {
        self.font(.headline)
            .foregroundColor(.primary)
    }
    
    func captionText() -> some View {
        self.font(.caption)
            .foregroundColor(.secondary)
    }
    
    func lineSpaced(_ spacing: CGFloat = 5) -> some View {
        self.lineSpacing(spacing)
    }
}

// MARK: - Debugging Extensions

extension View {
    func debugBorder(_ color: Color = .red) -> some View {
        self.border(color, width: 1)
    }
    
    func debugPrint(_ value: Any) -> some View {
        print(value)
        return self
    }
    
    func debugModifier<T>(_ value: T) -> some View {
        print("Value: \(value)")
        return self
    }
}
