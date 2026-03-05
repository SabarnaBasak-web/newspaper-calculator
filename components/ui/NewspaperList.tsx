import { useRouter } from "expo-router";
import { StyleSheet, View } from "react-native";
import IconButton from "./IconButton";
import StyledText from "./StyledText";

const NewspaperList = () => {
  const router = useRouter();

  const onPressHandler = () => {
    router.push("/(tabs)/manageNewspaper");
  };

  return (
    <View>
      <View style={styles.headerContainer}>
        <View>
          <StyledText content="Manage Newspapers" fontSize={22} />
        </View>

        <IconButton iconName="cog" pressableHandler={onPressHandler} />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  headerContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 10,
  },
});
export default NewspaperList;
