//
//  MainTabBarView.swift
//  Totality
//
//  Created by Kent Wilson on 11/28/25.
//


// MainTabBarView.swift

import SwiftUI

struct MainTabBarView: View {
    @Binding var selectedTab: MainTab
    var onAction: (MainTab) -> Void

    @Namespace private var highlightNamespace

    var body: some View {
        HStack(spacing: 12) {
            tabCapsule

            if selectedTab.actionIcon != nil {
                actionButton
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
        .padding(.top, 8)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.05),
                                            Color.black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .bottom)
        )
        .animation(.easeInOut(duration: 0.25), value: selectedTab)
    }

    // MARK: - Main pill with three segments

    private var tabCapsule: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let segmentWidth = width / 3

            ZStack {
                // background capsule (outer)
                RoundedRectangle(cornerRadius: segmentWidth / 2)
                    .fill(Color.black.opacity(0.75))

                // sliding highlight
                if selectedTab != .forYou {
                    RoundedRectangle(cornerRadius: segmentWidth / 2)
                        .fill(Color.white.opacity(0.10))
                        .frame(width: segmentWidth + 8) // a bit wider than each label
                        .offset(x: highlightOffset(width: width))
                        .matchedGeometryEffect(id: "highlight", in: highlightNamespace)
                } else {
                    // For You = full width highlight
                    RoundedRectangle(cornerRadius: segmentWidth / 2)
                        .fill(Color.white.opacity(0.10))
                        .padding(2)
                        .matchedGeometryEffect(id: "highlight", in: highlightNamespace)
                }

                HStack(spacing: 0) {
                    tabButton(.forYou, segmentWidth: segmentWidth)
                    tabButton(.workout, segmentWidth: segmentWidth)
                    tabButton(.nutrition, segmentWidth: segmentWidth)
                }
            }
        }
        .frame(height: 56)
    }

    private func tabButton(_ tab: MainTab, segmentWidth: CGFloat) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 16, weight: .medium))

                Text(tab.title)
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(width: segmentWidth, height: 56)
            .foregroundStyle(
                selectedTab == tab ? Color.white : Color.white.opacity(0.6)
            )
        }
        .buttonStyle(.plain)
    }

    private func highlightOffset(width: CGFloat) -> CGFloat {
        let segmentWidth = width / 3
        switch selectedTab {
        case .forYou:
            return 0
        case .workout:
            return 0              // middle segment
        case .nutrition:
            return segmentWidth   // right segment
        }
    }

    // MARK: - Floating action button

    private var actionButton: some View {
        Button {
            onAction(selectedTab)
        } label: {
            Image(systemName: selectedTab.actionIcon ?? "plus")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color.white)
                .frame(width: 56, height: 56)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.9))
                )
                .shadow(radius: 6, y: 4)
        }
        .buttonStyle(.plain)
    }
}