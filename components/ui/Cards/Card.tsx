import { ReactNode } from "react";
import { StyleProp, StyleSheet, View, ViewStyle } from "react-native";

interface CardProps {
  children: ReactNode;
  style?: StyleProp<ViewStyle>;
}
const Card = ({ children, style }: CardProps) => {
  return <View style={[styles.container, style]}>{children}</View>;
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    alignItems: "flex-start",
    justifyContent: "space-between",
    backgroundColor: "#b5a9a0",
    width: "100%",
    borderRadius: 20,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
    borderColor: "#403432",
    borderWidth: 1.5,
    maxHeight: 180,
  },
});
export default Card;
