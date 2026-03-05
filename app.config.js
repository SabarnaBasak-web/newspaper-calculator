export default {
  expo: {
    name: "newspaper-calculator",
    slug: "newspaper-calculator-app",
    owner: "sabarnabasak",
    android: {
      package: "com.sabarna.newspaperCalculatorApp",
    },
    extra: {
      apiKey: process.env.FIREBASE_API_KEY,
      authDomain: process.env.FIREBASE_AUTH_DOMAIN,
      projectId: process.env.FIREBASE_PROJECT_ID,
      storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
      messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
      appId: process.env.FIREBASE_APP_ID,
      eas: {
        projectId: "95be90c0-ad9e-4215-acbd-63b3644b6b4f",
      },
    },
    // plugins: [
    //   [
    //     "react-native-google-mobile-ads",
    //     {
    //       androidAppId: process.env.ADMOB_ANDROID_APP_ID,
    //     },
    //   ],
    // ],
  },
};
