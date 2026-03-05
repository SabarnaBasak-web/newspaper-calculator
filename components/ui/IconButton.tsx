import FontAwesome from "@expo/vector-icons/FontAwesome";
import { Pressable, StyleProp, StyleSheet, ViewStyle } from "react-native";

type FontAwesomeIconName = React.ComponentProps<typeof FontAwesome>["name"];

interface IconButtonProps {
  iconName: FontAwesomeIconName;
  iconSize?: number;
  pressableHandler?: () => void;
  style?: StyleProp<ViewStyle>;
  iconColor?: string;
}
const IconButton = (props: IconButtonProps) => {
  const { iconName, iconSize, pressableHandler, style, iconColor } = props;

  const pressHandler = () => {
    pressableHandler?.();
  };
  return (
    <Pressable style={[styles.moreBtn, style]} onPress={pressHandler}>
      <FontAwesome
        name={iconName}
        size={iconSize ?? 22}
        color={iconColor ?? "#212121"}
      ></FontAwesome>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  moreBtn: {
    backgroundColor: "#b5a9a0",
    width: 40,
    height: 40,
    alignItems: "center",
    justifyContent: "center",
    borderRadius: 20,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 4,
  },
});
export default IconButton;
