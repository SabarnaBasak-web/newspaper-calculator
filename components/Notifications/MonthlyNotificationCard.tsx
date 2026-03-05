import { getCurrentMonth } from "@/helper/date.helper";
import { PaymentHistoryPayload } from "@/models/models";
import useNewspaperStore from "@/store/useNewspaperStore";
import usePaymentStore from "@/store/usePaymentStore";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { ActivityIndicator, Pressable, StyleSheet, View } from "react-native";
import Card from "../ui/Cards/Card";
import StyledText from "../ui/StyledText";

const MonthlyNotificationCard = ({ startDate }: { startDate: Date }) => {
  const loading = false;
  const { setPaymentHistory, outstandingAmount, setBillingDate } =
    usePaymentStore();
  const { selectedNewspaper } = useNewspaperStore();

  const notificationHandler = (val: string) => {
    const paymentPayload: PaymentHistoryPayload = {
      monthName: getCurrentMonth(),
      amount: outstandingAmount,
      paymentStatus: val === "Yes" ? "completed" : "pending",
      newspaperName: selectedNewspaper?.paperName ?? "",
      year: startDate.getFullYear(),
    };

    setPaymentHistory(paymentPayload);
    setBillingDate(null);
  };

  const currentMonth = getCurrentMonth();

  return (
    <View style={styles.notificationContainer}>
      <Card>
        <StyledText content={`Mark ${currentMonth} payment as paid ?`} />
        <View style={styles.btnGroup}>
          {loading ? (
            <ActivityIndicator size="large" color="#212121" />
          ) : (
            <>
              <Pressable
                style={styles.button}
                onPress={() => notificationHandler("Yes")}
              >
                <FontAwesome name="check" size={15}>
                  <StyledText content="Yes" />
                </FontAwesome>
              </Pressable>
              <Pressable
                style={styles.button}
                onPress={() => notificationHandler("No")}
              >
                <FontAwesome name="close" size={15}>
                  <StyledText content="No" />
                </FontAwesome>
              </Pressable>
            </>
          )}
        </View>
      </Card>
    </View>
  );
};

const styles = StyleSheet.create({
  notificationContainer: {
    marginTop: 0,
  },
  btnGroup: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: 10,
    gap: 20,
  },
  button: {
    borderRadius: 10,
    width: 80,
    height: 40,
    alignItems: "center",
    justifyContent: "center",
    flexDirection: "row",
    borderColor: "#212121",
    borderWidth: 2,
  },
});

export default MonthlyNotificationCard;
