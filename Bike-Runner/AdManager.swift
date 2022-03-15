//
//  AdManager.swift
//  Bike-Runner
//
//  Created by André Schueda on 14/03/22.
//

import Foundation
import GoogleMobileAds

class AdManager: NSObject, GADFullScreenContentDelegate {
    private var interstitialAd: GADInterstitialAd?
    private var rewardedAd: GADRewardedAd?
    
    
    func requestInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Constants.testInterstitialAdUnitID, request: request, completionHandler: { [self] ad, error in
            if let error = error {
              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
              return
            }
            interstitialAd = ad
            interstitialAd?.fullScreenContentDelegate = self
          }
        )
    }
    
    func requestRewarded() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: Constants.testRewardedAdUnitID, request: request, completionHandler: { [self] ad, error in
            if let error = error {
              print("Failed to load rewarded ad with error: \(error.localizedDescription)")
              return
            }
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
          }
        )
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
        requestInterstitial()
        requestRewarded()
    }
    
    func showInterstitialAd(_ sender: UIViewController) {
        guard let interstitialAd = interstitialAd else {
            print("Ad wasn't ready")
            return
        }
        interstitialAd.present(fromRootViewController: sender)
    }
    
    func showRewardedAd(_ sender: AdShower) {
        guard let rewardedAd = rewardedAd else {
            sender.rewardedWasNotShowed()
            print("Ad wasn't ready")
            return
        }
        rewardedAd.present(fromRootViewController: sender, userDidEarnRewardHandler: {
            sender.rewardedWasShowed()
        })
    }
}
