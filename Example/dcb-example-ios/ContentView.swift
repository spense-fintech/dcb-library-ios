//
//  ContentView.swift
//  dcb-example-ios
//
//  Created by Rohit on 26/06/26.
//

import SwiftUI
import dcb_library_ios

struct ContentView: View {
    @State private var prospectId: String = ""
    @State private var showToast: Bool = false
    @State private var toastMessage: String = "Device details copied successfully"
    @State private var isLoading: Bool = false
    @State private var currentVC: UIViewController? = nil
    @State private var loginStatus: String? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("DCB Library Example")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 48)

                TextField("Enter Prospect ID", text: $prospectId)
                    .font(.system(size: 16, weight: .medium))
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .frame(height: 56)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)

                Button(action: {
                    openLibrary()
                }) {
                    Text("Open DCB Library")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(prospectId.isEmpty ? Color.blue.opacity(0.4) : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(prospectId.isEmpty || isLoading)
                .padding(.horizontal, 16)

                Button(action: {
                    checkLoginStatus()
                }) {
                    Text("Check isLoggedIn")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .disabled(isLoading)
                .padding(.horizontal, 16)

                if let status = loginStatus {
                    Text(status)
                        .font(.subheadline)
                        .foregroundColor(status.contains("YES") ? .green : .red)
                        .padding(.horizontal, 16)
                }

                Button(action: {
                    copyDeviceDetails()
                }) {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text("Copy Device Details")
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 16)

                Spacer()
            }

            // Toast
            if showToast {
                VStack {
                    Spacer()
                    Text(toastMessage)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.bottom, 40)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: showToast)
            }

            // Loading overlay
            if isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView("Loading...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .background(
            ViewControllerAccessor { vc in
                self.currentVC = vc
            }
        )
    }

    private func openLibrary() {
        guard let vc = currentVC else { return }
        isLoading = true

        Task {
            do {
                // Generate JWT token locally (same as Flutter logic)
                let token = JWTHelper.generateToken(prospectId: prospectId.trimmingCharacters(in: .whitespaces))
                print("Generated token: \(token)")

                let library = PartnerLibrarySingleton.shared.instance

                try await library.open(
                    on: vc,
                    token: token,
                    module: EnvManager.module,
                    callback: { action in
                        switch action {
                        case .logout:
                            print("User logged out")
                        case .redirect(let status):
                            print("Redirected with status: \(status)")
                        }
                    }
                )
            } catch {
                print("Error opening library: \(error)")
            }

            await MainActor.run {
                isLoading = false
            }
        }
    }

    private func checkLoginStatus() {
        isLoading = true
        Task {
            let library = PartnerLibrarySingleton.shared.instance
            let loggedIn = await library.isLoggedIn()

            await MainActor.run {
                loginStatus = loggedIn ? "Session: YES ✓" : "Session: NO ✗"
                isLoading = false
            }
        }
    }

    private func copyDeviceDetails() {
        let deviceInfo = """
        Device: \(UIDevice.current.name)
        Model: \(UIDevice.current.model)
        System: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)
        UUID: \(UIDevice.current.identifierForVendor?.uuidString ?? "N/A")
        """

        UIPasteboard.general.string = deviceInfo
        showToast = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showToast = false
        }
    }
}
