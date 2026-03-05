import Svg, { Circle, Ellipse, Rect } from "react-native-svg";

interface INewspaperCalculatorProps {
  height: number;
  width: number;
}
const NewspaperCalculatorImage = (props: INewspaperCalculatorProps) => {
  const { height, width } = props;
  return (
    <Svg height={height} width={width} viewBox='0 0 360 640'>
      <Rect width='360' height='640' fill='#e5d8c4' />

      <Ellipse cx='180' cy='430' rx='120' ry='20' fill='#cfc1aa' />

      <Rect
        x='70'
        y='170'
        width='160'
        height='220'
        rx='12'
        fill='#ffffff'
        stroke='#d4c7b2'
        strokeWidth='2'
      />
      <Rect x='70' y='170' width='160' height='45' rx='12' fill='#dfe6ef' />

      <Rect x='90' y='235' width='120' height='10' fill='#e6e6e6' />
      <Rect x='90' y='255' width='100' height='10' fill='#e6e6e6' />
      <Rect x='90' y='275' width='120' height='10' fill='#e6e6e6' />
      <Rect x='90' y='295' width='80' height='10' fill='#e6e6e6' />

      <Rect
        x='55'
        y='360'
        width='90'
        height='90'
        rx='10'
        fill='#ffffff'
        stroke='#d4c7b2'
        strokeWidth='2'
      />
      <Rect x='55' y='360' width='90' height='22' rx='10' fill='#4a90e2' />

      <Circle cx='70' cy='400' r='4' fill='#b0b0b0' />
      <Circle cx='90' cy='400' r='4' fill='#b0b0b0' />
      <Circle cx='110' cy='400' r='4' fill='#b0b0b0' />

      <Rect x='190' y='260' width='120' height='160' rx='14' fill='#2f3a4f' />
      <Rect x='205' y='275' width='90' height='22' rx='6' fill='#6bb1ff' />

      <Circle cx='215' cy='320' r='7' fill='#9aa4b2' />
      <Circle cx='240' cy='320' r='7' fill='#9aa4b2' />
      <Circle cx='265' cy='320' r='7' fill='#9aa4b2' />

      <Circle cx='215' cy='350' r='7' fill='#9aa4b2' />
      <Circle cx='240' cy='350' r='7' fill='#9aa4b2' />
      <Circle cx='265' cy='350' r='7' fill='#9aa4b2' />

      <Circle cx='215' cy='380' r='7' fill='#9aa4b2' />
      <Circle cx='240' cy='380' r='7' fill='#9aa4b2' />
      <Circle cx='265' cy='380' r='7' fill='#f5a623' />

      <Ellipse cx='155' cy='420' rx='16' ry='6' fill='#f5c76a' />
      <Ellipse cx='170' cy='410' rx='16' ry='6' fill='#f1b94f' />
      <Ellipse cx='185' cy='400' rx='16' ry='6' fill='#e9ac3f' />
    </Svg>
  );
};

export default NewspaperCalculatorImage;
