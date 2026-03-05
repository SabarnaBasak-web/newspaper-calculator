import { StyleProp, Text, TextStyle } from "react-native";

interface IStyledText {
  content: string;
  fontFamily?: string;
  fontSize?: number;
  numberOfLines?: number;
  style?: StyleProp<TextStyle>;
}
const StyledText = ({
  content,
  fontFamily,
  fontSize,
  numberOfLines,
  style,
}: IStyledText) => {
  return (
    <Text
      style={[
        style,
        {
          fontFamily: fontFamily ?? "NunitoSans_400Regular",
          fontSize: fontSize ?? 18,
        },
      ]}
      numberOfLines={numberOfLines}
    >
      {content}
    </Text>
  );
};

export default StyledText;
