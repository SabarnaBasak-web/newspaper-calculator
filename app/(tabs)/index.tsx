import DailyNotificationCard from "@/components/Notifications/DailyNotificationCard";
import MonthlyNotificationCard from "@/components/Notifications/MonthlyNotificationCard";
import StartBillingNotificationCard from "@/components/Notifications/StartBillingNotificationCard";
import NewspaperList from "@/components/ui/NewspaperList";
import OutstandingPaymentCard from "@/components/ui/OutstandingPayment";
import PaymentHistoryComponent from "@/components/ui/PaymentHistory";
import StyledText from "@/components/ui/StyledText";
import { getBillingCycle } from "@/helper/date.helper";
import useNewspaperStore from "@/store/useNewspaperStore";
import usePaymentStore from "@/store/usePaymentStore";
import { isToday } from "date-fns";
import React from "react";
import { StyleSheet, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

const HomeScreen = () => {
  const { outstandingAmount, lastUpdated, billingStartDate, paymentHistory } =
    usePaymentStore();

  const { selectedNewspaper } = useNewspaperStore();

  const showDailyNotification = !isToday(lastUpdated);
  const { remainingDays, currentCycleStart } = billingStartDate
    ? getBillingCycle(billingStartDate)
    : { remainingDays: null, currentCycleStart: null };

  return (
    <SafeAreaView>
      <View style={styles.container}>
        <OutstandingPaymentCard amount={outstandingAmount} />
        <PaymentHistoryComponent paymentList={paymentHistory} />
        <NewspaperList />
        {!billingStartDate && !selectedNewspaper && (
          <StyledText content="Choose Newspaper by clicking on the settings icon" />
        )}
        {!billingStartDate && selectedNewspaper && (
          <StartBillingNotificationCard />
        )}
        {showDailyNotification && billingStartDate && <DailyNotificationCard />}
        {remainingDays === 0 && (
          <MonthlyNotificationCard startDate={currentCycleStart} />
        )}

        {/* <AdBanner /> */}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    gap: 20,
  },
});
export default HomeScreen;
