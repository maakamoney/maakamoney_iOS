//
//  OnBoarding.swift
//  MaakanMoney
//
//  Created by Anand Mani R on 25/12/21.
//

import SwiftUI

struct OnBoarding: View {
    
    // MARK: - Properties
    var onBoardingViewModel = OnBoardingViewModel()
    var authenticationNavigation: AuthenticationNavigation
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    // MARK: - Observable Properties
    @State private var currentPage = 0
    @State private var pushAuthentication = false
    
    // MARK: - Computed View Properties
    var pager: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15).fill(AppTheme.primaryOverlayColor.opacity(0.5)).frame(height: 20)
            HStack(spacing: 12) {
                Circle().fill(Color(hex: currentPage == 0 ? ColorCode.primary.getColorCode() : ColorCode.secondary.getColorCode())).frame(width: 10, height: 10)
                Circle().fill(Color(hex: currentPage == 1 ? ColorCode.primary.getColorCode() : ColorCode.secondary.getColorCode())).frame(width: 10, height: 10)
                Circle().fill(Color(hex: currentPage == 2 ? ColorCode.primary.getColorCode() : ColorCode.secondary.getColorCode())).frame(width: 10, height: 10)
            }.padding(.horizontal,10)
        }.fixedSize(horizontal: true, vertical: false)
    }
    var buttonGetStarted: some View {
        Button(action: {
                        authenticationNavigation.pushLoginView?($appCoordinator.navigationPath)
                        Utilities.authenticationStage = 1
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(AppTheme.primaryColor)
                HStack {
                    Text(MMConstants.TitleText.getStarted).foregroundColor(AppTheme.secondaryOverlayColor)
                    Circle().fill(AppTheme.primaryColor).frame(width: 20,height: 20).overlay(Image(systemName: MMConstants.ImagePaths.rightArrow).resizable().renderingMode(.template).foregroundColor(AppTheme.primaryOverlayColor).frame(width: 12,height: 10))
                }.padding(10)
            }.fixedSize()
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AppTheme.primaryColor.ignoresSafeArea(.all)
                VStack(spacing: -20) {
                    VStack {
                        Spacer()
                        Text(MMConstants.TitleText.maakaMoney).font(.title).fontWeight(.bold).foregroundColor(.white)
                        Text(MMConstants.TitleText.trustablePiggyBank).font(.caption).foregroundColor(.white)
                        HStack {
                            Image(MMConstants.ImagePaths.ecllipse).resizable().frame(width: 100, height: 100).opacity(0.25)
                            Spacer()
                        }
                    }
                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack {
                            Spacer()
                            Image(MMConstants.ImagePaths.ecllipse).resizable().frame(width: 200, height: 200)
                        }
                        Image(MMConstants.ImagePaths.mobileSkeleton).resizable().frame(width: geometry.size.width/1.2, height: geometry.size.height/1.8)
                            .aspectRatio(contentMode: .fill).allowsHitTesting(false)
                            .padding(.leading, 8)
                        TabView(selection: $currentPage) {
                            Image(MMConstants.ImagePaths.onboardingOne).resizable().tag(0)
                            Image(MMConstants.ImagePaths.onboardingTwo).resizable().tag(1)
                            Image(MMConstants.ImagePaths.onboardingThree).resizable().tag(2)
                        }.tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(width: geometry.size.width/1.5, height: geometry.size.height/2.4)
                        VStack {
                            HStack {
                                Button {
                                    withAnimation {
                                        currentPage = currentPage == 2 ? 1 : currentPage == 1 ? 0 : 0
                                    }
                                } label: {
                                    Text(MMConstants.TitleText.onboardingPrevious).font(.caption).foregroundColor(.white).opacity(currentPage == 0 ? 0.5 : 1)
                                }.disabled(currentPage == 0)
                                Spacer()
                                Text(onBoardingViewModel.onBoardingDetails[currentPage].title).font(.caption).fontWeight(.semibold).foregroundColor(.white)
                                Spacer()
                                Button {
                                    withAnimation {
                                        currentPage = currentPage == 0 ? 1 : currentPage == 1 ? 2 : 0
                                    }
                                } label: {
                                    Text(MMConstants.TitleText.onboardingNext).font(.caption).foregroundColor(.white).opacity(currentPage == 2 ? 0.5 : 1)
                                }.disabled(currentPage == 2)
                            }.padding(.horizontal, 10)
                            Spacer()
                        }.frame(width: geometry.size.width/1.5, height: geometry.size.height/2.2)
                    }
                    ZStack(alignment: .bottom) {
                        AppTheme.secondaryColor.edgesIgnoringSafeArea(.bottom).frame(height:  geometry.size.height/4.5)
                        VStack {
                            Text(onBoardingViewModel.onBoardingDetails[currentPage].subtitle).foregroundColor(.white).padding([.top, .leading, .trailing]).font(.system(size: 16)).fontWeight(.semibold).multilineTextAlignment(.center)
                            HStack {
                                pager
                                Spacer()
                                buttonGetStarted
                            }.padding()
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding(authenticationNavigation: AuthenticationNavigation(pushDashboardView: {}))
    }
}
