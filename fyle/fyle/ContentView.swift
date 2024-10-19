//
//  ContentView.swift
//  fyle
//
//  Created by Sana Sreeraj on 18/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomePageView() // This is the home page that should now be in scope
    }
}

struct HomePageView: View {
    var body: some View {
        ZStack {
            // Linear Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color(hex: "417CC6"), Color(hex: "71C3F7"), Color(hex: "F6F6F6")]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                HeaderView()
                CardsSectionView()
                FavoritesSectionView()
                Spacer()
                AddButtonView()
            }
            .padding(.horizontal, 20) // 20 px margin from the sides
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Hi Sreeraj")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(Color(hex: "EEF9FF"))
            Spacer()
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "EEF9FF"))
        }
    }
}

struct CardsSectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                DashboardCard(title: "Files", count: "78", iconName: "folder.fill", iconBackground: Color.blue)
                DashboardCard(title: "Reminders", count: "04", iconName: "bell.fill", iconBackground: Color.red)
            }
            HStack(spacing: 20) {
                DashboardCard(title: "Categories", count: "13", iconName: "square.grid.2x2.fill", iconBackground: Color.green)
                DashboardCard(title: "Shared", count: "0", iconName: "person.2.fill", iconBackground: Color.orange)
            }
        }
    }
}

struct DashboardCard: View {
    let title: String
    let count: String
    let iconName: String
    let iconBackground: Color
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .fill(iconBackground)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: iconName)
                            .foregroundColor(.white)
                    )
            }
            Spacer()
            Text(count)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(hex: "EEF9FF"))
        .cornerRadius(12)
        .frame(width: 150, height: 120)
    }
}

struct FavoritesSectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favourites")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(Color(hex: "EEF9FF"))
            
            ForEach(favoriteFiles, id: \.self) { file in
                HStack {
                    Text(file)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
            }
        }
    }
}

let favoriteFiles = ["Driving Licence", "Land Tax", "Aadhar Card", "FSSAI License", "Life Insurance"]

struct AddButtonView: View {
    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            Button(action: {
                // Action to add a new file
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.blue)
                    .cornerRadius(30)
                    .shadow(radius: 10)
            }
        }
        .padding(.bottom, 20)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}

