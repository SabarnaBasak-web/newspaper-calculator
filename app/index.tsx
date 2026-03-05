import NewspaperCalculatorImage from "@/components/ui/NewspaperCalculator";
import StyledButton from "@/components/ui/StyledButton";
import StyledText from "@/components/ui/StyledText";
import { db } from "@/firebase/firebaseConfig";
import { registerDevice } from "@/firebase/firestore.service";
import { getDeviceId } from "@/helper/device.helper";
import useNewspaperStore from "@/store/useNewspaperStore";
import usePaymentStore from "@/store/usePaymentStore";
import { useRouter } from "expo-router";
import { doc, getDoc } from "firebase/firestore";
import React, { useState } from "react";
import { StyleSheet, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

const HomeScreen = () => {
  const router = useRouter();
  const { getAllDetails } = usePaymentStore();
  const { fetchSelectedNewspaper } = useNewspaperStore();

  const [isLoading, setIsLoading] = useState(false);

  const continueBtnHandler = async () => {
    setIsLoading(true);
    const deviceId = await getDeviceId();
    const deviceRef = doc(db, "devices", deviceId);
    const querySnapshot = await getDoc(deviceRef);
    if (!querySnapshot.exists()) {
      await registerDevice(deviceId);
    } else {
      await fetchSelectedNewspaper();
      await getAllDetails();
    }

    setIsLoading(false);
    router.push("/(tabs)");
  };

  return (
    <SafeAreaView>
      <View style={styles.container}>
        <NewspaperCalculatorImage width={600} height={600} />
        <StyledText
          content={"Newspaper Calculator"}
          fontFamily="NunitoSans_600Regular"
          fontSize={30}
        />
        <StyledButton
          buttonLabel={"Continue"}
          onPressHandler={continueBtnHandler}
          isLoading={isLoading}
        />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    marginTop: 20,
    gap: 5,
  },
});

export default HomeScreen;
