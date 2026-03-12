import {
  createContext,
  useContext,
  useState,
  useEffect,
  useMemo,
  useCallback,
} from "react";

const InfrastructureContext = createContext();

export const useInfrastructure = () => useContext(InfrastructureContext);

export const InfrastructureProvider = ({ children }) => {
  // Vault Health Settings
  const [offlineMode, setOfflineMode] = useState(true);
  const [highSpeedSync, setHighSpeedSync] = useState(false);
  const [vaultUsage, setVaultUsage] = useState(12.4); // GB
  const [vaultCapacity] = useState(2000); // 2TB in GB
  const [photosSynced, setPhotosSynced] = useState(1204);
  const [totalPhotos] = useState(1450);

  // Redundancy Settings
  const [zeroKnowledge, setZeroKnowledge] = useState(true);
  const [recoveryKey, setRecoveryKey] = useState("8X92-ZK4M-P92L-XXXX");
  const [redundancyVerified] = useState(true);

  // Catalog Engine
  const [indexingStatus] = useState("Active");
  const [itemsIndexed, setItemsIndexed] = useState(14203);
  const [throughput] = useState(45); // MB/s

  // Simulate sync progress
  useEffect(() => {
    const interval = setInterval(() => {
      if (!offlineMode || (offlineMode && Math.random() > 0.5)) {
        // Simulate connectivity
        setPhotosSynced((prev) => {
          if (prev < totalPhotos) return prev + 1;
          return prev;
        });
        setVaultUsage((prev) => prev + 0.005);
        setItemsIndexed((prev) => prev + 1);
      }
    }, 3000);

    return () => clearInterval(interval);
  }, [offlineMode, totalPhotos]);

  const regenerateKey = useCallback(() => {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let newKey = "";
    for (let i = 0; i < 16; i++) {
      if (i > 0 && i % 4 === 0) newKey += "-";
      newKey += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    setRecoveryKey(newKey);
  }, []);

  const forceBackup = useCallback(() => {
    // Logic to force backup would go here
  }, []);

  // ⚡ Bolt Optimization: Memoize the context value to prevent unnecessary re-renders
  // of all consuming components every time any state in this context changes (like the 3s interval).
  const value = useMemo(
    () => ({
      offlineMode,
      setOfflineMode,
      highSpeedSync,
      setHighSpeedSync,
      vaultUsage,
      vaultCapacity,
      photosSynced,
      totalPhotos,
      zeroKnowledge,
      setZeroKnowledge,
      recoveryKey,
      regenerateKey,
      redundancyVerified,
      indexingStatus,
      itemsIndexed,
      throughput,
      forceBackup,
    }),
    [
      offlineMode,
      highSpeedSync,
      vaultUsage,
      vaultCapacity,
      photosSynced,
      totalPhotos,
      zeroKnowledge,
      recoveryKey,
      redundancyVerified,
      indexingStatus,
      itemsIndexed,
      throughput,
    ],
  );

  return (
    <InfrastructureContext.Provider value={value}>
      {children}
    </InfrastructureContext.Provider>
  );
};
