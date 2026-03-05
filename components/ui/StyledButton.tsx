import FontAwesome from "@expo/vector-icons/FontAwesome";
import { Pressable, StyleSheet, View } from "react-native";
import StyledText from "./StyledText";

interface IStyledButton {
  buttonLabel: string;
  onPressHandler: () => void;
  isLoading?: boolean;
}

const StyledButton = (props: IStyledButton) => {
  const { buttonLabel, onPressHandler, isLoading = false } = props;
  return (
    <View style={styles.container}>
      <Pressable style={styles.button} onPress={onPressHandler}>
        <StyledText content={buttonLabel} />
        {isLoading && (
          <FontAwesome
            name="spinner"
            size={15}
            style={styles.spinnerStyle}
            animated
          />
        )}
      </Pressable>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    width: 320,
    height: 68,
    marginHorizontal: 20,
    alignItems: "center",
    justifyContent: "center",
    padding: 3,
    marginTop: 20,
  },
  button: {
    borderRadius: 10,
    width: "100%",
    height: "100%",
    alignItems: "center",
    justifyContent: "center",
    flexDirection: "row",
    borderColor: "#212121",
    borderWidth: 2,
  },
  spinnerStyle: {
    marginLeft: 5,
  },
});
export default StyledButton;
