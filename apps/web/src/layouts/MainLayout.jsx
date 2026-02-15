import BottomNav from "@/components/BottomNav";

/**
 * Main Layout for authenticated users.
 * Includes common navigation like the BottomNav.
 */
function MainLayout({ children }) {
  return (
    <div
      className="main-layout"
      style={{
        minHeight: "100vh",
        paddingBottom: "80px", // Spacing for BottomNav
        backgroundColor: "var(--bg-dark)",
        position: "relative",
        overflowX: "hidden",
      }}
    >
      <main className="content-container">{children}</main>
      <BottomNav />
    </div>
  );
}

export default MainLayout;
