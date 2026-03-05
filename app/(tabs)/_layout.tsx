import { Stack } from "expo-router";

export default function TabLayout() {
  return (
    <Stack>
      <Stack.Screen
        name='index'
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name='explore'
        options={{
          title: "Explore",
          headerTitle: "Explore",
        }}
      />
      <Stack.Screen
        name='manageNewspaper'
        options={{
          title: "Manage Newspapers",
          headerTitle: "Manage Newspaper",
          headerStyle: {
            backgroundColor: "#b5a9a0",
          },
        }}
      />
    </Stack>
  );
}
