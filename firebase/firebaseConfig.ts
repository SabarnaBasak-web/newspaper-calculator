import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyAnzsXVQQqbq4KnLARMrZ-AS6Y_5sT0kww",
  authDomain: "newspaper-calc-app.firebaseapp.com",
  projectId: "newspaper-calc-app",
  storageBucket: "newspaper-calc-app.firebasestorage.app",
  messagingSenderId: "51400017770",
  appId: "1:51400017770:web:02227680a9f1e8136c4713",
};

const app = initializeApp(firebaseConfig);
export const db = getFirestore(app);
