import {
  addMonths,
  differenceInDays,
  differenceInMonths,
  format,
  fromUnixTime,
  isWeekend,
  startOfDay,
  subDays,
} from "date-fns";

export const getCurrentDate = () => {
  const curDate = new Date();
  return format(curDate, "dd-MM-yyyy");
};

export const isWeekDay = () => {
  return !isWeekend(getCurrentDate());
};

export const isSaturday = () => {
  const curDate = new Date();
  return curDate.getDay() === 6;
};

export const isSunday = () => {
  const curDate = new Date();
  return curDate.getDay() === 0;
};

export const getCurrentMonth = () => {
  const curDate = new Date();
  return format(curDate, "LLLL");
};

export const getBillingCycle = (startDate: Date) => {
  const today = startOfDay(new Date());
  const cycleStart = startOfDay(startDate);
  const monthsElapsed = differenceInMonths(today, cycleStart);
  const currentCycleStart = startOfDay(addMonths(cycleStart, monthsElapsed));
  const currentCycleEnd = startOfDay(
    subDays(addMonths(currentCycleStart, 1), 1),
  );

  return {
    currentCycleStart,
    currentCycleEnd,
    totalDays: differenceInDays(currentCycleEnd, currentCycleStart) + 1,
    elapsedDays: differenceInDays(today, currentCycleStart) + 1,
    remainingDays: differenceInDays(currentCycleEnd, today),
  };
};

export const firestoreDate = (timestamp: {
  seconds: number;
  nanoseconds: number;
}) => {
  return fromUnixTime(timestamp.seconds);
};
