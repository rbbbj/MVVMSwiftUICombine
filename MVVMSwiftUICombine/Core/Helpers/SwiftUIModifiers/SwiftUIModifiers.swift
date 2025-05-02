import SwiftUI


// MARK: - Card Styling Modifier

struct CardModifier: ViewModifier {
    var backgroundColor: Color
    var cornerRadius: CGFloat
    var shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
            .padding(.horizontal)
    }
}

extension View {
    func cardStyle(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 10,
        shadowRadius: CGFloat = 3
    ) -> some View {
        self.modifier(CardModifier(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius
        ))
    }
}

// MARK: - Button Style Modifiers

struct PrimaryButtonModifier: ViewModifier {
    var backgroundColor: Color
    var foregroundColor: Color
    var cornerRadius: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: backgroundColor.opacity(0.3), radius: 3, y: 2)
    }
}

extension View {
    func primaryButtonStyle(
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 10,
        height: CGFloat = 50
    ) -> some View {
        self.modifier(PrimaryButtonModifier(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            cornerRadius: cornerRadius,
            height: height
        ))
    }
}

// MARK: - Text Style Modifiers

struct TextStyleModifier: ViewModifier {
    var font: Font
    var color: Color
    var alignment: TextAlignment
    var lineSpacing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .lineSpacing(lineSpacing)
    }
}

extension View {
    func textStyle(
        font: Font = .body,
        color: Color = .primary,
        alignment: TextAlignment = .leading,
        lineSpacing: CGFloat = 4
    ) -> some View {
        self.modifier(TextStyleModifier(
            font: font,
            color: color,
            alignment: alignment,
            lineSpacing: lineSpacing
        ))
    }
    
    // Convenience methods
    func titleStyle() -> some View {
        textStyle(font: .largeTitle.bold(), lineSpacing: 5)
    }
    
    func headlineStyle() -> some View {
        textStyle(font: .headline, lineSpacing: 4)
    }
    
    func captionStyle() -> some View {
        textStyle(font: .caption, color: .secondary)
    }
}

// MARK: - Input Field Modifier

struct InputFieldModifier: ViewModifier {
    var cornerRadius: CGFloat
    var borderColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

extension View {
    func inputFieldStyle(
        cornerRadius: CGFloat = 8,
        borderColor: Color = Color.gray.opacity(0.3),
        backgroundColor: Color = Color(.systemBackground)
    ) -> some View {
        self.modifier(InputFieldModifier(
            cornerRadius: cornerRadius,
            borderColor: borderColor,
            backgroundColor: backgroundColor
        ))
    }
}

// MARK: - Responsive Padding Modifier

struct ResponsivePaddingModifier: ViewModifier {
    var horizontal: CGFloat
    var vertical: CGFloat
    var edgeInsets: EdgeInsets?
    
    func body(content: Content) -> some View {
        if let insets = edgeInsets {
            content.padding(insets)
        } else {
            content
                .padding(.horizontal, horizontal)
                .padding(.vertical, vertical)
        }
    }
}

extension View {
    func responsivePadding(
        horizontal: CGFloat = 16,
        vertical: CGFloat = 8
    ) -> some View {
        self.modifier(ResponsivePaddingModifier(
            horizontal: horizontal,
            vertical: vertical,
            edgeInsets: nil
        ))
    }
    
    func responsivePadding(_ insets: EdgeInsets) -> some View {
        self.modifier(ResponsivePaddingModifier(
            horizontal: 0,
            vertical: 0,
            edgeInsets: insets
        ))
    }
}

// MARK: - Loading State Modifier

struct LoadingStateModifier: ViewModifier {
    var isLoading: Bool
    var color: Color
    var scale: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .opacity(isLoading ? 0.6 : 1)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(scale)
                    .progressViewStyle(CircularProgressViewStyle(tint: color))
            }
        }
    }
}

extension View {
    func loadingState(
        isLoading: Bool,
        color: Color = .blue,
        scale: CGFloat = 1.5
    ) -> some View {
        self.modifier(LoadingStateModifier(
            isLoading: isLoading,
            color: color,
            scale: scale
        ))
    }
}

// MARK: - First Appear Modifier

struct FirstAppearModifier: ViewModifier {
    @State private var hasAppeared = false
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                action()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        self.modifier(FirstAppearModifier(action: action))
    }
}

// MARK: - Shake Effect Modifier

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct ShakeModifier: ViewModifier {
    var animatableData: CGFloat
    
    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(animatableData: animatableData))
    }
}

extension View {
    func shake(animatableData: CGFloat) -> some View {
        self.modifier(ShakeModifier(animatableData: animatableData))
    }
}

// MARK: - Adaptive Navigation Title Modifier

struct AdaptiveNavigationTitleModifier: ViewModifier {
    var title: String
    @Environment(\.horizontalSizeClass) var sizeClass
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(sizeClass == .compact ? .inline : .large)
    }
}

extension View {
    func adaptiveNavigationTitle(_ title: String) -> some View {
        self.modifier(AdaptiveNavigationTitleModifier(title: title))
    }
}

// Badge Modifier

struct BadgeModifier: ViewModifier {
    var count: Int
    var backgroundColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            
            if count > 0 {
                Text("\(count)")
                    .font(.caption2.bold())
                    .foregroundColor(textColor)
                    .padding(5)
                    .background(backgroundColor)
                    .clipShape(Circle())
                    .offset(x: 3, y: -3)
            }
        }
    }
}

extension View {
    func badge(
        count: Int,
        backgroundColor: Color = .red,
        textColor: Color = .white
    ) -> some View {
        self.modifier(BadgeModifier(
            count: count,
            backgroundColor: backgroundColor,
            textColor: textColor
        ))
    }
}

// MARK: - Screen Reader Focus Modifier

struct AccessibilityFocusModifier: ViewModifier {
    var isAccessible: Bool
    var label: String
    var hint: String?
    
    func body(content: Content) -> some View {
        if isAccessible {
            content
                .accessibilityLabel(label)
                .accessibilityHint(hint ?? "")
                .accessibilityAddTraits(.isButton)
        } else {
            content
        }
    }
}

extension View {
    func accessibilityFocus(
        isAccessible: Bool = true,
        label: String,
        hint: String? = nil
    ) -> some View {
        self.modifier(AccessibilityFocusModifier(
            isAccessible: isAccessible,
            label: label,
            hint: hint
        ))
    }
}
