import { PaymentHistory, PaymentStatus } from "@/models/models";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { FlatList, StyleSheet, View } from "react-native";
import Card from "./Cards/Card";
import StyledText from "./StyledText";

interface IPaymentHistoryProps {
  paymentList: PaymentHistory[];
}

interface PaymentListItem {
  id: string;
  month: string;
  paperName: string;
  amount: number;
  year: number;
  status: PaymentStatus;
}

const PaymentHistoryComponent = (props: IPaymentHistoryProps) => {
  const { paymentList } = props;

  const PaymentListRow = ({
    id,
    month,
    paperName,
    amount,
    year,
    status,
  }: PaymentListItem) => {
    const formattedDate = `${month.substring(0, 3)}'${year
      .toString()
      .substring(2)}`;
    return (
      <View key={id} style={styles.listContainer}>
        <View style={styles.monthContent}>
          <StyledText content={formattedDate} />
        </View>
        <View style={styles.titleContent}>
          <StyledText content={paperName} numberOfLines={1} />
        </View>
        <View style={styles.amountContent}>
          <FontAwesome name="rupee" size={15}>
            <StyledText content={amount.toString()} />
          </FontAwesome>
          <FontAwesome
            name={status === "completed" ? "check" : "exclamation"}
            size={15}
            color={status === "completed" ? "#388e3c" : "#bf360c"}
          />
        </View>
      </View>
    );
  };

  return (
    <View style={styles.container}>
      <StyledText content="Payment History" fontSize={22} />
      <Card>
        {paymentList.length === 0 ? (
          <StyledText content="No payment history available." />
        ) : (
          <FlatList
            data={paymentList}
            renderItem={({ item }) => (
              <PaymentListRow
                paperName={item.newspaperName}
                month={item.monthName}
                amount={item.amount}
                id={item.id}
                year={item.year}
                status={item.paymentStatus}
              />
            )}
            keyExtractor={(item) => item.id}
          />
        )}
      </Card>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: "flex-start",
    gap: 10,
  },
  cardContent: {
    flexDirection: "column",
    width: "100%",
  },
  listContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: "#766a62",
    gap: 15,
    width: "100%",
  },
  monthContent: {
    width: "20%",
  },
  titleContent: {
    flex: 1,
    maxWidth: "70%",
    justifyContent: "flex-start",
  },
  amountContent: {
    width: "15%",
    justifyContent: "flex-end",
    flexDirection: "row",
    alignItems: "baseline",
    gap: 5,
  },
});
export default PaymentHistoryComponent;
