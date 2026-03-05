import { StyleSheet, View } from "react-native";
import StyledText from "./StyledText";

interface INewspaperDetails {
  title: string;
  id: string;
}
const NewspaperDetails = ({ title, id }: INewspaperDetails) => {
  return (
    <View style={styles.title} key={id}>
      <StyledText content={title} />
    </View>
  );
};

const styles = StyleSheet.create({
  title: {
    maxWidth: "100%",
    marginVertical: 2,
  },
});
export default NewspaperDetails;
