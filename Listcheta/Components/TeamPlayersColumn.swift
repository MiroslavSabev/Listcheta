import SwiftUI
import UIKit

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
// Поведение:
// - Тап на "+ Играч" отваря поле за име (с клавиатура).
// - Щом започнеш да пишеш, под полето се появява нов ред "+ Играч".
// - Return или тап на "+ Играч": името се записва и полето се изчиства,
//   без клавиатурата да мърда (фокусът никога не се губи).
// - Тап извън полето (полето приключва редакция): написаното име се записва.
// - Празно поле при Return или загуба на фокус: редът просто се затваря.
// - Максимум 10 играча в отбор: при 10-ия редът за добавяне изчезва.
// - Колоната няма собствен скрол — расте, а екранът се превърта до реда за писане.
// - onScrollNeeded(rowID, keyboardAppearing): казва на екрана до кой ред да превърти.
//   keyboardAppearing = true → клавиатурата тепърва се показва (по-дълго изчакване).

struct TeamPlayersColumn: View {
    let teamName: String
    let teamColor: Color
    let headerTextColor: Color
    @Binding var players: [TeamPlayer]
    var maxPlayers: Int = 10
    var onScrollNeeded: (_ rowID: String, _ keyboardAppearing: Bool) -> Void = { _, _ in }

    @State private var draftName: String = ""
    @State private var isAddingPlayer: Bool = false

    // уникално id на реда за писане — по него екранът го намира
    private var editingRowID: String { "editingRow-\(teamName)" }

    private var hasDraftText: Bool {
        !draftName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var isFull: Bool {
        players.count >= maxPlayers
    }

    // "+ Играч" се вижда:
    // - когато не пишем и има място, или
    // - докато пишем име и след него ще остане място за още един
    private var showsAddRow: Bool {
        if isAddingPlayer {
            return hasDraftText && players.count + 1 < maxPlayers
        }
        return !isFull
    }

    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 2) {
                Text(teamName.uppercased())
                    .font(.custom("Unbounded-Bold", size: 11.5))
                    .foregroundStyle(headerTextColor)

                Text("\(players.count)/\(maxPlayers)")
                    .font(.custom("Manrope-Bold", size: 11))
                    .foregroundStyle(Color.listchetaMuted)
            }
            .padding(.top, 8)

            VStack(spacing: 7) {
                ForEach(players) { player in
                    playerRow(player)
                }

                if isAddingPlayer && !isFull {
                    editingRow
                        .id(editingRowID)
                }

                if showsAddRow {
                    addRow
                }
            }
            .padding(.trailing, 2)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(12)
        .background(teamColor.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .onChange(of: isAddingPlayer) { _, adding in
            // отваряне на поле → екранът чака клавиатурата и скролва до реда
            if adding { onScrollNeeded(editingRowID, true) }
        }
        .onChange(of: players.count) { _, _ in
            // нов играч добавен, докато пишем → клавиатурата вече е горе
            guard isAddingPlayer else { return }
            onScrollNeeded(editingRowID, false)
        }
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

            NameTextField(
                text: $draftName,
                placeholder: "Име",
                onSubmit: { commitDraft(keepAdding: true) },
                onEndEditing: {
                    // тап извън полето / скрита клавиатура → запази написаното
                    guard isAddingPlayer else { return }
                    commitDraft(keepAdding: false)
                }
            )
            .frame(height: 20)

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
    }

    private var addRow: some View {
        Button {
            if isAddingPlayer {
                // пишем в момента → запиши и изчисти полето (клавиатурата остава)
                commitDraft(keepAdding: true)
            } else {
                draftName = ""
                withAnimation(.easeOut(duration: 0.15)) {
                    isAddingPlayer = true
                }
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

    private func commitDraft(keepAdding: Bool) {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        let canAppend = !trimmed.isEmpty && !isFull
        draftName = ""

        if canAppend {
            players.append(TeamPlayer(name: trimmed))
        }

        if keepAdding && canAppend && players.count < maxPlayers {
            // оставаме в режим на добавяне: същото поле, клавиатурата не се пипа
            return
        }

        // празно поле или достигнат лимит → затваряме реда
        // (махането на полето само сваля клавиатурата)
        withAnimation(.easeOut(duration: 0.15)) {
            isAddingPlayer = false
        }
    }
}

// MARK: - NameTextField
//
// UITextField, който не затваря клавиатурата при Return
// (textFieldShouldReturn връща false), така че няма "потъване" на клавиатурата.

private struct NameTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var onSubmit: () -> Void
    var onEndEditing: () -> Void

    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.delegate = context.coordinator
        field.font = UIFont(name: "Manrope-SemiBold", size: 12.5)
            ?? .systemFont(ofSize: 12.5, weight: .semibold)
        field.textColor = UIColor(red: 0x26 / 255, green: 0x22 / 255, blue: 0x4A / 255, alpha: 1)
        field.tintColor = UIColor(red: 0x26 / 255, green: 0x22 / 255, blue: 0x4A / 255, alpha: 1)
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(red: 0x26 / 255, green: 0x22 / 255, blue: 0x4A / 255, alpha: 0.28),
                .font: field.font as Any
            ]
        )
        field.returnKeyType = .next
        field.autocapitalizationType = .words
        field.addTarget(context.coordinator,
                        action: #selector(Coordinator.textChanged(_:)),
                        for: .editingChanged)
        field.setContentHuggingPriority(.defaultLow, for: .horizontal)
        field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // авто-фокус веднага щом полето се появи
        DispatchQueue.main.async {
            field.becomeFirstResponder()
        }
        return field
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        context.coordinator.parent = self
        if uiView.text != text {
            uiView.text = text
        }
    }

    func sizeThatFits(_ proposal: ProposedViewSize,
                      uiView: UITextField,
                      context: Context) -> CGSize? {
        CGSize(width: proposal.width ?? 100,
               height: uiView.intrinsicContentSize.height)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NameTextField

        init(_ parent: NameTextField) {
            self.parent = parent
        }

        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onSubmit()
            return false // клавиатурата остава отворена
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEndEditing()
        }
    }
}

// MARK: - Design tokens

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

// MARK: - Preview

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
