import { getCurrentDate } from "@/helper/date.helper";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { StyleSheet, View } from "react-native";
import Card from "./Cards/Card";
import IconButton from "./IconButton";
import StyledText from "./StyledText";

interface OutstandingPaymentCardProps {
  amount: number;
}

const OutstandingPaymentCard = (props: OutstandingPaymentCardProps) => {
  const { amount } = props;
  const currentDate = getCurrentDate();

  return (
    <View>
      <View style={styles.header}>
        <StyledText content={`Outstanding amount`} fontSize={22} />
        <IconButton iconName='calendar' />
      </View>

      <Card>
        <View style={styles.textContainer}>
          <StyledText content={currentDate} />
          <View>
            <FontAwesome name='rupee' size={17}>
              <StyledText content={amount.toString()} />
            </FontAwesome>
          </View>
        </View>
      </Card>
    </View>
  );
};

const styles = StyleSheet.create({
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: 20,
    marginBottom: 10,
  },
  textContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
    width: "100%",
  },
});
export default OutstandingPaymentCard;
