import useNewspaperStore from "@/store/useNewspaperStore";
import { Picker } from "@react-native-picker/picker";
import { StyleSheet, View } from "react-native";
import Card from "../ui/Cards/Card";
import StyledText from "../ui/StyledText";
const NewspaperSelectionCard = () => {
  const { newspapers, selectedNewspaper, setSelectedNewspaper } =
    useNewspaperStore();

  return (
    <View style={styles.notificationContainer}>
      <Card>
        <StyledText
          content="Selected Newspaper"
          fontSize={20}
          style={{ fontWeight: "600", marginBottom: 15 }}
        />
        <View style={styles.pickerWrapper}>
          <Picker
            selectedValue={selectedNewspaper?.id}
            onValueChange={(itemValue) => {
              setSelectedNewspaper(itemValue);
            }}
            style={styles.picker}
            prompt="Select Newspaper"
            selectionColor={"#e8d7d1"}
            itemStyle={styles.itemStyle}
          >
            {newspapers.map((item) => {
              return (
                <Picker.Item
                  key={item.id}
                  label={item.paperName}
                  value={item.id}
                />
              );
            })}
          </Picker>
        </View>
      </Card>
    </View>
  );
};

const styles = StyleSheet.create({
  notificationContainer: {
    marginTop: 5,
  },
  newspaperItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-around",
    paddingHorizontal: 10,
    marginVertical: 4,
    width: "100%",
  },
  newspaperItemSelected: {
    backgroundColor: "#e8d7d1",
  },
  checkIcon: {
    marginRight: 12,
    color: "#212121",
  },
  pickerWrapper: {
    borderRadius: 10,
    borderColor: "#403432",
    borderWidth: 1.5,
    overflow: "hidden",
    width: "100%",
  },
  picker: {
    backgroundColor: "#e8d7d1",
  },

  itemStyle: {
    marginLeft: 5,
    fontSize: 18,
  },
});

export default NewspaperSelectionCard;
