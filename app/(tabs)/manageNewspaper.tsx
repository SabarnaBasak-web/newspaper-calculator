import NewspaperSelectionCard from "@/components/Notifications/NewspaperSelectionCard";
import Card from "@/components/ui/Cards/Card";
import IconButton from "@/components/ui/IconButton";
import NewspaperModal from "@/components/ui/NewspaperModal";
import StyledText from "@/components/ui/StyledText";
import { NewspaperListResponse } from "@/models/models";
import useNewspaperStore from "@/store/useNewspaperStore";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { useState } from "react";
import { FlatList, Pressable, StyleSheet, View } from "react-native";

interface NewspaperItemProps {
  id: string;
  name: string;
  weekdayPrice: string;
  saturdayPrice: string;
  sundayPrice: string;
}
const ManageNewspaper = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const [selectedNewspaper, setSelectedNewspaper] = useState<
    NewspaperListResponse | undefined
  >(undefined);
  const [isEditMode, setIsEditMode] = useState(false);

  const newspapers = useNewspaperStore((state) => state.newspapers);

  const addNewspaperHandler = () => {
    setSelectedNewspaper(undefined);
    setIsEditMode(false);
    setModalVisible(true);
  };

  const closeModal = () => {
    setModalVisible(false);
    setSelectedNewspaper(undefined);
    setIsEditMode(false);
  };

  const editHandler = (id: string) => {
    const foundNewspaper = newspapers.find((n) => n.id === id);
    setSelectedNewspaper(foundNewspaper);
    setIsEditMode(true);
    setModalVisible(true);
  };

  const NewspaperItem = ({
    name,
    id,
    weekdayPrice,
    saturdayPrice,
    sundayPrice,
  }: NewspaperItemProps) => {
    const PriceContainer = ({ price, day }: { price: string; day: string }) => {
      return (
        <View style={styles.priceContainer}>
          <StyledText content={`${day} price: `} />
          <FontAwesome name='rupee' size={18}>
            <StyledText content={price} />
          </FontAwesome>
        </View>
      );
    };
    return (
      <View style={styles.listItem} key={id}>
        <Card style={styles.cardContainer}>
          <View>
            <StyledText
              content={name}
              fontSize={22}
              style={{ fontWeight: "600" }}
            />
            <PriceContainer price={weekdayPrice} day='weekday' />
            <PriceContainer price={saturdayPrice} day='saturday' />
            <PriceContainer price={sundayPrice} day='sunday' />
          </View>
          <Pressable onPress={() => editHandler(id)}>
            <FontAwesome name='pencil' size={20} />
          </Pressable>
        </Card>
      </View>
    );
  };

  return (
    <>
      <View style={styles.container}>
        <NewspaperSelectionCard />
        <StyledText
          content='Newspaper List'
          fontSize={28}
          style={{ fontWeight: "800" }}
        />
        <FlatList
          data={newspapers}
          renderItem={({ item }) => (
            <NewspaperItem
              name={item.paperName}
              weekdayPrice={item.weekdayPrice}
              saturdayPrice={item.saturdayPrice}
              id={item.id}
              sundayPrice={item.sundayPrice}
            />
          )}
          keyExtractor={(item) => item.id}
        />
      </View>
      <View style={styles.floatingActionBtn}>
        <IconButton
          iconName='plus'
          iconSize={25}
          style={{
            width: 60,
            height: 60,
            borderRadius: 30,
          }}
          pressableHandler={addNewspaperHandler}
        />
        <NewspaperModal
          modalVisible={modalVisible}
          closeModal={closeModal}
          mode={isEditMode ? "edit" : "add"}
          selectedNewspaper={selectedNewspaper}
        />
      </View>
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,

    position: "relative",
    height: "100%",
    padding: 20,
  },

  listItem: {
    marginVertical: 10,
  },

  priceContainer: {
    flexDirection: "row",
    marginTop: 5,
    gap: 5,
  },
  floatingActionBtn: {
    position: "absolute",
    bottom: 100,
    right: 20,
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: "center",
    alignItems: "center",
    elevation: 5,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },

  floatingBtnText: {
    fontSize: 32,
    color: "#fff",
    fontWeight: "bold",
  },

  cardContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
});
export default ManageNewspaper;
