import { isWeekDay } from "@/helper/date.helper";
import useNewspaperStore from "@/store/useNewspaperStore";
import usePaymentStore from "@/store/usePaymentStore";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { isSaturday } from "date-fns";
import { router } from "expo-router";
import { Pressable, StyleSheet, View } from "react-native";
import Card from "../ui/Cards/Card";
import StyledText from "../ui/StyledText";

type ResponseType = "Yes" | "No";
const StartBillingNotificationCard = () => {
  const { setBillingDate, updateOutstandingAmount } = usePaymentStore();
  const { selectedNewspaper } = useNewspaperStore();

  const confirmBillingDate = (confirm: ResponseType) => {
    if (confirm === "Yes") {
      const curDate = new Date();
      setBillingDate(curDate);

      let amount = 0;

      if (isWeekDay()) {
        amount = +selectedNewspaper?.weekdayPrice!;
      } else if (isSaturday(curDate)) {
        amount = +selectedNewspaper?.saturdayPrice!;
      } else {
        amount = +selectedNewspaper?.sundayPrice!;
      }

      updateOutstandingAmount(amount);
    }

    if (confirm === "No") {
      router.push("/(tabs)/manageNewspaper");
    }
  };

  return (
    <View style={styles.notificationContainer}>
      <Card>
        <StyledText content="Start billing" />
        <View style={styles.btnGroup}>
          <Pressable
            style={styles.button}
            onPress={() => confirmBillingDate("Yes")}
          >
            <FontAwesome name="check" size={15}>
              <StyledText content="Yes" />
            </FontAwesome>
          </Pressable>
          <Pressable
            style={styles.button}
            onPress={() => confirmBillingDate("No")}
          >
            <FontAwesome name="close" size={15}>
              <StyledText content="No" />
            </FontAwesome>
          </Pressable>
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
export default StartBillingNotificationCard;
