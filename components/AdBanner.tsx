import Constants from "expo-constants";
import { BannerAd, BannerAdSize } from "react-native-google-mobile-ads";

const BANNER_ID = Constants.expoConfig?.extra?.androidAppId;

console.log("@ Banner ID:", BANNER_ID);
export const AdBanner = () => (
  <BannerAd
    unitId={BANNER_ID}
    size={BannerAdSize.ANCHORED_ADAPTIVE_BANNER}
    onAdFailedToLoad={(err) => console.error("Ad failed:", err)}
  />
);
