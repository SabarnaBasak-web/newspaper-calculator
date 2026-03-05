import { db } from "@/firebase/firebaseConfig";
import { getDeviceId } from "@/helper/device.helper";
import { NewspaperListResponse } from "@/models/models";
import {
  collection,
  doc,
  getDoc,
  getDocs,
  query,
  updateDoc,
} from "firebase/firestore";
import { create } from "zustand";
interface NewspaperState {
  newspapers: NewspaperListResponse[];
  selectedNewspaper: NewspaperListResponse | null;
  addNewspaper: (payload: NewspaperListResponse) => void;
  updateNewspaper: (payload: NewspaperListResponse) => void;
  fetchAllNewspapers: () => Promise<void>;
  setSelectedNewspaper: (id: string) => Promise<void>;
  fetchSelectedNewspaper: () => Promise<void>;
}
const useNewspaperStore = create<NewspaperState>()((set) => ({
  newspapers: [],
  addNewspaper: (payload) =>
    set((s) => ({ newspapers: [...s.newspapers, payload] })),
  updateNewspaper: (payload) =>
    set((s) => ({
      newspapers: s.newspapers.map((n) => (n.id === payload.id ? payload : n)),
    })),
  fetchAllNewspapers: async () => {
    const q = query(collection(db, "newspapers"));
    const querySnapshot = await getDocs(q);

    const list: NewspaperListResponse[] = [];
    querySnapshot.forEach((snap) => {
      const details = snap.data() as NewspaperListResponse;
      list.push(details);
    });

    set((s) => ({ newspapers: list }));
  },
  selectedNewspaper: null,
  setSelectedNewspaper: async (payload: string) => {
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);
    try {
      await updateDoc(deviceRef, {
        selectedNewspaper: payload,
      });
    } catch (error) {
      console.error("Error updating outstanding amount:", error);
    }
    set((s) => ({
      selectedNewspaper: s.newspapers.find((n) => n.id === payload),
    }));
  },
  fetchSelectedNewspaper: async () => {
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);
    try {
      const querySnapshot = await getDoc(deviceRef);
      if (querySnapshot.exists()) {
        const data = querySnapshot.data();
        const selected = data.selectedNewspaper;

        set((s) => ({
          selectedNewspaper:
            s.newspapers.find((n) => n.id === selected) ?? null,
        }));
      }
    } catch (error) {
      console.error("Error updating outstanding amount:", error);
    }
  },
}));

export default useNewspaperStore;
