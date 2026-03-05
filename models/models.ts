export interface NewspaperPrice {
  id: string;
  name: string;
  weekdayPrice: number;
  saturdayPrice: number;
  sundayPrice: number;
}

export interface AddNewspaperFormInput {
  paperName: string;
  weekdayPrice: string;
  saturdayPrice: string;
  sundayPrice: string;
}

export interface NewspaperListResponse {
  paperName: string;
  weekdayPrice: string;
  saturdayPrice: string;
  sundayPrice: string;
  createdAt: {
    nanoseconds: number;
    seconds: number;
    type: string;
  };
  id: string;
}

export interface FireStoreTimeStamp {
  nanoseconds: number;
  seconds: number;
  type: string;
}

export interface PaymentDetailsResponse {
  billingStartDate: FireStoreTimeStamp;
  createdAt: FireStoreTimeStamp;
  currentMonth: string;
  deviceInfo: {
    platform: string;
  };
  lastUpdated: FireStoreTimeStamp;
  outstandingAmount: number;
  selectedNewspaper: string;
  paymentHistory: PaymentHistory[];
}
export type PaymentStatus = "pending" | "completed";

export interface PaymentHistory {
  id: string;
  monthName: string;
  amount: number;
  paymentStatus: PaymentStatus;
  newspaperName: string;
  year: number;
}

export type PaymentHistoryPayload = Omit<PaymentHistory, "id">;
