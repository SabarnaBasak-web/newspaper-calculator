import {
  addNewspaperService,
  updateNewspaperService,
} from "@/firebase/firestore.service";
import { AddNewspaperFormInput, NewspaperListResponse } from "@/models/models";
import useNewspaperStore from "@/store/useNewspaperStore";
import FontAwesome from "@expo/vector-icons/FontAwesome";
import { useCallback, useEffect, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Modal,
  Pressable,
  StyleSheet,
  TextInput,
  View,
} from "react-native";
import StyledButton from "./StyledButton";
import StyledText from "./StyledText";

type Mode = "edit" | "add";

interface INewspaperModalProps {
  modalVisible: boolean;
  closeModal: () => void;
  mode: Mode;
  selectedNewspaper?: NewspaperListResponse;
}

function NewspaperModal(props: INewspaperModalProps) {
  const { modalVisible, closeModal, mode, selectedNewspaper } = props;
  const [isLoading, setIsLoading] = useState(false);
  const { addNewspaper, updateNewspaper } = useNewspaperStore();

  const getDefaultValues = useCallback(() => {
    if (mode === "edit" && selectedNewspaper) {
      return {
        paperName: selectedNewspaper.paperName,
        weekdayPrice: selectedNewspaper.weekdayPrice,
        saturdayPrice: selectedNewspaper.saturdayPrice,
        sundayPrice: selectedNewspaper.sundayPrice,
      };
    }
    return {
      paperName: "",
      weekdayPrice: "",
      saturdayPrice: "",
      sundayPrice: "",
    };
  }, [mode, selectedNewspaper]);

  const { control, handleSubmit, reset } = useForm<AddNewspaperFormInput>({
    defaultValues: getDefaultValues(),
  });

  useEffect(() => {
    reset(getDefaultValues());
  }, [mode, selectedNewspaper, reset, getDefaultValues]);

  const handleSubmitEntry = async (data: AddNewspaperFormInput) => {
    try {
      setIsLoading(true);
      if (mode === "edit" && selectedNewspaper) {
        const updatedNewspaper = await updateNewspaperService(
          selectedNewspaper.id,
          data
        );
        updateNewspaper(updatedNewspaper as NewspaperListResponse);
      } else {
        const newNewspaper = await addNewspaperService(data);
        addNewspaper(newNewspaper as NewspaperListResponse);
      }

      reset();
      closeModal();
    } catch (error) {
      console.error(
        `Error ${mode === "edit" ? "updating" : "adding"} newspaper:`,
        error
      );
    } finally {
      setIsLoading(false);
    }
  };

  const closeModalHandler = () => {
    reset();
    closeModal();
  };
  return (
    /* Modal Component */
    <Modal
      animationType='slide'
      transparent={true}
      visible={modalVisible}
      onRequestClose={closeModal}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <StyledText
              content={mode === "edit" ? "Edit Newspaper" : "Add Newspaper"}
              fontSize={22}
              style={{ fontWeight: "bold" }}
            />

            <Pressable style={styles.closeBtn} onPress={closeModalHandler}>
              <FontAwesome name='close' size={22} />
            </Pressable>
          </View>

          <View style={styles.modalBody}>
            <View style={styles.fieldGroup}>
              <StyledText content='Newspaper Name' style={styles.fieldLabel} />
              <Controller
                control={control}
                render={({ field: { onChange, onBlur, value } }) => (
                  <KeyboardAvoidingView>
                    <TextInput
                      placeholder='The Statesman'
                      onBlur={onBlur}
                      value={value}
                      onChangeText={onChange}
                      style={styles.inputField}
                    />
                  </KeyboardAvoidingView>
                )}
                name='paperName'
              />
            </View>

            <View style={styles.fieldGroup}>
              <StyledText content='Weekday Price' style={styles.fieldLabel} />
              <Controller
                control={control}
                render={({ field: { onChange, onBlur, value } }) => (
                  <KeyboardAvoidingView>
                    <TextInput
                      keyboardType='numeric'
                      placeholder='0'
                      onBlur={onBlur}
                      value={value}
                      onChangeText={onChange}
                      style={styles.inputField}
                    />
                  </KeyboardAvoidingView>
                )}
                name='weekdayPrice'
              />
            </View>

            <View style={styles.fieldGroup}>
              <StyledText content='Saturday Price' style={styles.fieldLabel} />
              <Controller
                control={control}
                render={({ field: { onChange, onBlur, value } }) => (
                  <KeyboardAvoidingView>
                    <TextInput
                      keyboardType='numeric'
                      placeholder='0'
                      onBlur={onBlur}
                      value={value}
                      onChangeText={onChange}
                      style={styles.inputField}
                    />
                  </KeyboardAvoidingView>
                )}
                name='saturdayPrice'
              />
            </View>

            <View style={styles.fieldGroup}>
              <StyledText content='Sunday Price' style={styles.fieldLabel} />
              <Controller
                control={control}
                render={({ field: { onChange, onBlur, value } }) => (
                  <KeyboardAvoidingView>
                    <TextInput
                      keyboardType='numeric'
                      placeholder='0'
                      onBlur={onBlur}
                      value={value}
                      onChangeText={onChange}
                      style={styles.inputField}
                    />
                  </KeyboardAvoidingView>
                )}
                name='sundayPrice'
              />
            </View>

            <View style={styles.submitButtonContainer}>
              {isLoading ? (
                <ActivityIndicator size='large' color='#212121' />
              ) : (
                <StyledButton
                  buttonLabel={mode === "edit" ? "Update" : "Submit"}
                  onPressHandler={handleSubmit(handleSubmitEntry)}
                />
              )}
            </View>
          </View>
        </View>
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },

  modalContent: {
    backgroundColor: "#f1f0ec",
    paddingBottom: 40,
    height: "100%",
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
  },

  closeBtn: {
    alignSelf: "flex-end",
    padding: 8,
  },

  closeBtnText: {
    fontSize: 24,
    color: "#333",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    backgroundColor: "#b5a9a0",
    width: "100%",
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
  },
  modalBody: {
    padding: 20,
  },

  fieldGroup: {
    marginVertical: 6,
  },

  fieldLabel: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: 8,
    color: "#212121",
  },
  submitButtonContainer: {
    justifyContent: "center",
    alignItems: "center",
    minHeight: 50,
  },
  inputField: {
    borderWidth: 2,
    borderColor: "#212121",
    padding: 10,
    borderRadius: 10,
    marginBottom: 10,
  },
});

export default NewspaperModal;
