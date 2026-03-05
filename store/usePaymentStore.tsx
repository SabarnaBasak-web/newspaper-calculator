import { db } from "@/firebase/firebaseConfig";
import { firestoreDate } from "@/helper/date.helper";
import { getDeviceId } from "@/helper/device.helper";
import {
  PaymentDetailsResponse,
  PaymentHistory,
  PaymentHistoryPayload,
} from "@/models/models";
import { format } from "date-fns";
import * as Crypto from "expo-crypto";
import {
  arrayUnion,
  doc,
  getDocFromServer,
  serverTimestamp,
  Timestamp,
  updateDoc,
} from "firebase/firestore";
import { create } from "zustand";

interface PaymentStoreState {
  outstandingAmount: number;
  currentMonth: string;
  lastUpdated: Date;
  loading: boolean;
  paymentHistory: PaymentHistory[];
  billingStartDate: Date | null;
  createdAt: Date | null;
  updateOutstandingAmount: (amount: number) => Promise<void>;
  getAllDetails: () => Promise<void>;
  setPaymentHistory: (payload: PaymentHistoryPayload) => Promise<void>;
  setBillingDate: (startDate: Date | null) => Promise<void>;
}
const usePaymentStore = create<PaymentStoreState>()((set, get) => ({
  outstandingAmount: 0,
  currentMonth: "",
  loading: false,
  billingStartDate: null,
  createdAt: null,
  paymentHistory: [],
  updateOutstandingAmount: async (amount: number) => {
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);
    const currentMonth = format(new Date(), "MMMM");
    set({ loading: true });

    try {
      // Get current outstanding amount
      const previousAmount = get().outstandingAmount;
      const totalAmount = previousAmount + amount;
      const localTime = Timestamp.now();
      await updateDoc(deviceRef, {
        outstandingAmount: totalAmount,
        currentMonth: currentMonth,
        lastUpdated: serverTimestamp(),
      });

      set({
        outstandingAmount: totalAmount,
        currentMonth: currentMonth,
        loading: false,
        lastUpdated: firestoreDate(localTime),
      });
    } catch (error) {
      console.error("Error updating outstanding amount:", error);
      set({ loading: false });
    }
  },
  getAllDetails: async () => {
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);

    try {
      set({ loading: true });
      const querySnapshot = await getDocFromServer(deviceRef);
      if (querySnapshot.exists()) {
        const data = querySnapshot.data() as PaymentDetailsResponse;

        set({
          outstandingAmount: data.outstandingAmount || 0,
          currentMonth: data.currentMonth || "",
          lastUpdated: data.lastUpdated && firestoreDate(data.lastUpdated),
          billingStartDate:
            data.billingStartDate && firestoreDate(data.billingStartDate),
          paymentHistory: data.paymentHistory ?? [],
          loading: false,
          createdAt: data.createdAt && firestoreDate(data.createdAt),
        });
      }
    } catch (error) {
      console.error("Error fetching outstanding amount:", error);
      set({ loading: false });
    }
  },
  lastUpdated: new Date(),
  setPaymentHistory: async (payload: PaymentHistoryPayload) => {
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);
    const uniqId = Crypto.randomUUID();
    const modifiedPayload = { id: uniqId, ...payload };
    try {
      await updateDoc(deviceRef, {
        paymentHistory: arrayUnion(modifiedPayload),
      });

      set((s) => ({
        paymentHistory: [...s.paymentHistory, modifiedPayload],
      }));
    } catch (error) {
      console.error("Error fetching outstanding amount:", error);
    }
  },
  setBillingDate: async (startDate: Date | null) => {
    if (startDate === null) return;
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);

    await updateDoc(deviceRef, {
      billingStartDate: startDate,
    });
    set({
      billingStartDate: startDate,
    });
  },
}));
export default usePaymentStore;
