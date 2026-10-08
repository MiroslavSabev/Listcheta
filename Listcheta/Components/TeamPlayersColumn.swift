import SwiftUI

// MARK: - Model

struct TeamPlayer: Identifiable, Equatable {
    let id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Team Players Column
//
// Mirrors "Фаза 1А · Играчите на отборите" from the HTML design file:
// .col → this view · .minirow → playerRow · .minirow.add → addRow ·
// .minirow.editing → editingRow.
//
// Behavior (per the design discussion):
// - Tapping "+ Играч" morphs that row into an editable field in place
//   (no new screen/sheet).
// - The field auto-focuses the keyboard; Return/Done commits the name.
// - On commit, the row freezes into a normal player row (initial in
//   the avatar), and a fresh editing row immediately reopens below it,
//   so the person can type several names back-to-back.
// - Submitting an empty field just closes the row back to "+ Играч" —
//   no confirm button inside the row.
//
// Swap the Color/Font tokens below for your real ones if the names
// differ from the design-system tokens (color.ink, color.paper, ...).

struct TeamPlayersColumn: View {
    let teamName: String
    let teamColor: Color
    let headerTextColor: Color
    @Binding var players: [TeamPlayer]

    @State private var draftName: String = ""
    @State private var isAddingPlayer: Bool = false
    @FocusState private var isDraftFocused: Bool

    private let rowHeight: CGFloat = 40 // approx. minirow height incl. spacing

    var body: some View {
        VStack(spacing: 12) {
            Text(teamName.uppercased())
                .font(.custom("Unbounded-Bold", size: 11.5)) // exact PostScript name may differ
                .foregroundStyle(headerTextColor)
                .padding(.top, 8)

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 7) {
                        ForEach(players) { player in
                            playerRow(player)
                        }

                        if isAddingPlayer {
                            editingRow
                                .id("editingRow")
                        } else {
                            addRow
                        }
                    }
                    .padding(.trailing, 2)
                }
                .frame(
                    maxHeight: CGFloat(players.count + 4) * rowHeight
                )
                .onChange(of: isAddingPlayer) { _, adding in
                    guard adding else { return }
                    withAnimation {
                        proxy.scrollTo("editingRow", anchor: .bottom)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(12)
        .background(teamColor.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    // MARK: Rows

    private func playerRow(_ player: TeamPlayer) -> some View {
        HStack(spacing: 7) {
            avatar(initial: player.name.prefix(1).uppercased(), background: teamColor)

            Text(player.name)
                .font(.custom("Manrope-ExtraBold", size: 12.5))
                .foregroundStyle(Color.listchetaInk)
                .lineLimit(1)

            Spacer(minLength: 0)

            Button {
                withAnimation(.easeOut(duration: 0.15)) {
                    players.removeAll { $0.id == player.id }
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.listchetaMuted)
            }
            .buttonStyle(.plain)
        }
        .padding(9)
        .background(Color.listchetaPaper)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color.listchetaInk.opacity(0.07), radius: 3, x: 0, y: 2)
    }

    private var editingRow: some View {
        HStack(spacing: 7) {
            Circle()
                .fill(Color.clear)
                .frame(width: 22, height: 22)
                .overlay(
                    Circle().strokeBorder(
                        Color.listchetaInk.opacity(0.3),
                        style: StrokeStyle(lineWidth: 2, dash: [3, 3])
                    )
                )

            TextField("Име", text: $draftName)
                .font(.custom("Manrope-SemiBold", size: 12.5))
                .foregroundStyle(Color.listchetaInk)
                .focused($isDraftFocused)
                .submitLabel(.next) // reads as "Next" on the keyboard's Return key
                .onSubmit(commitDraft)

            Spacer(minLength: 0)
        }
        .padding(9)
        .background(Color.listchetaPaper)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color.listchetaInk.opacity(0.18), lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color.listchetaInk.opacity(0.07), radius: 3, x: 0, y: 2)
        .task {
            // auto-focus the keyboard the instant the row appears
            isDraftFocused = true
        }
    }

    private var addRow: some View {
        Button {
            draftName = ""
            withAnimation(.easeOut(duration: 0.15)) {
                isAddingPlayer = true
            }
        } label: {
            Text("+ Играч")
                .font(.custom("Manrope-Bold", size: 12))
                .foregroundStyle(Color.listchetaMuted)
                .frame(maxWidth: .infinity)
                .padding(9)
        }
        .buttonStyle(.plain)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(
                    Color.listchetaInk.opacity(0.2),
                    style: StrokeStyle(lineWidth: 2, dash: [4, 4])
                )
        )
    }

    private func avatar(initial: String, background: Color) -> some View {
        Circle()
            .fill(background)
            .frame(width: 22, height: 22)
            .overlay(
                Text(initial)
                    .font(.custom("Manrope-ExtraBold", size: 9.5))
                    .foregroundStyle(.white)
            )
    }

    // MARK: Commit logic

    private func commitDraft() {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            // empty submit: just close the row, nothing added
            withAnimation(.easeOut(duration: 0.15)) {
                isAddingPlayer = false
            }
            return
        }
        players.append(TeamPlayer(name: trimmed))
        draftName = ""
        // back to "+ Играч" — the person taps again to add the next one
        withAnimation(.easeOut(duration: 0.15)) {
            isAddingPlayer = false
        }
    }
}

// MARK: - Design tokens (swap for your real ones if named differently)

private extension Color {
    static let listchetaInk = Color(hex: "#26224A")
    static let listchetaPaper = Color(hex: "#FFFDF6")
    static let listchetaMuted = Color(hex: "#8B87A8")
}

private extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}

// MARK: - Preview (mirrors the А2 mockup: two columns side by side)

#Preview {
    struct PreviewHost: View {
        @State private var teamA = [
            TeamPlayer(name: "Мария"),
            TeamPlayer(name: "Иво")
        ]
        @State private var teamB = [
            TeamPlayer(name: "Георги"),
            TeamPlayer(name: "Ани"),
            TeamPlayer(name: "Петър")
        ]

        var body: some View {
            HStack(spacing: 9) {
                TeamPlayersColumn(
                    teamName: "🩷 Розовите",
                    teamColor: Color(hex: "#FF5C8A"),
                    headerTextColor: Color(hex: "#C2185B"),
                    players: $teamA
                )
                TeamPlayersColumn(
                    teamName: "🌊 Тюркоазите",
                    teamColor: Color(hex: "#00B8A9"),
                    headerTextColor: Color(hex: "#00877A"),
                    players: $teamB
                )
            }
            .padding(14)
            .background(Color(hex: "#EDEBFA"))
        }
    }

    return PreviewHost()
}
