import * as Crypto from "expo-crypto";
import * as Device from "expo-device";
import * as SecureStore from "expo-secure-store";

const KEY = "DEVICE_ID";

const generateDeviceFingerprint = async (): Promise<string> => {
  const components = [
    Device.modelId,
    Device.osVersion,
    Device.osBuildId,
    Device.totalMemory,
    Device.deviceName,
  ]
    .filter(Boolean)
    .join("|");

  if (!components) return Crypto.randomUUID();

  const hashed = await Crypto.digestStringAsync(
    Crypto.CryptoDigestAlgorithm.SHA256,
    components,
  );

  return hashed;
};
export async function getDeviceId() {
  let cached = await SecureStore.getItemAsync(KEY);
  if (cached) return cached;

  const id = await generateDeviceFingerprint();
  await SecureStore.setItemAsync(KEY, id);
  return id;
}
