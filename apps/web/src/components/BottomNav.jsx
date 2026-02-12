import { useNavigate, useLocation } from "react-router-dom";
import "./BottomNav.css";

/**
 * Standard Bottom Navigation component for Aevum.
 * Features glassmorphism and active state indicators.
 */
function BottomNav() {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { id: "home", label: "Home", icon: "home", path: "/dashboard" },
    { id: "tree", label: "Tree", icon: "account_tree", path: "/family-tree" },
    { id: "map", label: "Map", icon: "map", path: "/heritage-map" },
    { id: "vault", label: "Vault", icon: "photo_library", path: "/memories" },
    { id: "profile", label: "Profile", icon: "person", path: "/settings" },
  ];

  const isActive = (path) => location.pathname === path;

  return (
    <nav className="bottom-nav-fixed">
      <div className="bottom-nav-glass">
        {navItems.map((item) => (
          <button
            key={item.id}
            onClick={() => navigate(item.path)}
            className={`nav-item ${isActive(item.path) ? "active" : ""}`}
          >
            <span
              className={`material-symbols-outlined ${isActive(item.path) ? "filled" : ""}`}
            >
              {item.icon}
            </span>
            <span className="nav-label">{item.label}</span>
          </button>
        ))}
      </div>
    </nav>
  );
}

export default BottomNav;
