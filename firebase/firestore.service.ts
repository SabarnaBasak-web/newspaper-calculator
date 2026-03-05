import { AddNewspaperFormInput } from "@/models/models";
import * as Crypto from "expo-crypto";
import {
  doc,
  getDoc,
  serverTimestamp,
  setDoc,
  updateDoc,
} from "firebase/firestore";
import { Platform } from "react-native";
import { db } from "./firebaseConfig";

export const registerDevice = async (deviceId: string) => {
  await setDoc(doc(db, "devices", deviceId), {
    deviceInfo: {
      platform: Platform.OS,
    },
    createdAt: serverTimestamp(),
  });
};

export const addNewspaperService = async (payload: AddNewspaperFormInput) => {
  const id = Crypto.randomUUID();
  const newspaperRef = doc(db, "newspapers", id);

  await setDoc(newspaperRef, {
    ...payload,
    id: id,
    createdAt: serverTimestamp(),
  });

  const docSnapshot = await getDoc(newspaperRef);
  return docSnapshot.data();
};

export const updateNewspaperService = async (
  id: string,
  payload: AddNewspaperFormInput
) => {
  const newspaperRef = doc(db, "newspapers", id);

  await updateDoc(newspaperRef, {
    ...payload,
    updatedAt: serverTimestamp(),
  });

  const docSnapshot = await getDoc(newspaperRef);
  return docSnapshot.data();
};
