import { getCurrentDate, isWeekDay } from "@/helper/date.helper";
import useNewspaperStore from "@/store/useNewspaperStore";
import usePaymentStore from "@/store/usePaymentStore";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { isSaturday, isSunday } from "date-fns";
import { ActivityIndicator, Pressable, StyleSheet, View } from "react-native";
import Card from "../ui/Cards/Card";
import StyledText from "../ui/StyledText";

type ResponseType = "Yes" | "No";
const DailyNotificationCard = () => {
  const { loading, updateOutstandingAmount } = usePaymentStore();
  const { selectedNewspaper } = useNewspaperStore();
  const notificationHandler = (response: ResponseType) => {
    let price = "";

    if (selectedNewspaper) {
      if (isSaturday(getCurrentDate())) {
        price = selectedNewspaper.saturdayPrice;
      }
      if (isSunday(getCurrentDate())) price = selectedNewspaper.sundayPrice;
      if (isWeekDay()) price = selectedNewspaper.weekdayPrice;
      if (response === "Yes") {
        updateOutstandingAmount(+price);
      }
    }
  };

  return (
    <View style={styles.notificationContainer}>
      <Card>
        <StyledText content="Did you receive today's newspaper?" />
        <View style={styles.btnGroup}>
          {loading ? (
            <ActivityIndicator size='large' color='#212121' />
          ) : (
            <>
              <Pressable
                style={styles.button}
                onPress={() => notificationHandler("Yes")}
              >
                <FontAwesome name='check' size={15}>
                  <StyledText content='Yes' />
                </FontAwesome>
              </Pressable>
              <Pressable
                style={styles.button}
                onPress={() => notificationHandler("No")}
              >
                <FontAwesome name='close' size={15}>
                  <StyledText content='No' />
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
export default DailyNotificationCard;
