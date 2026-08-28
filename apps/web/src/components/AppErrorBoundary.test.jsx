import { afterEach, describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { AppErrorBoundary } from "./AppErrorBoundary";

afterEach(() => {
  vi.restoreAllMocks();
});

describe("AppErrorBoundary", () => {
  it("renders children when no render error occurs", () => {
    render(
      <AppErrorBoundary>
        <div>Healthy screen</div>
      </AppErrorBoundary>,
    );

    expect(screen.getByText("Healthy screen")).toBeInTheDocument();
  });

  it("shows a safe fallback without exposing the thrown error", () => {
    vi.spyOn(console, "error").mockImplementation(() => {});

    function ThrowingScreen() {
      throw new Error("sensitive internal failure detail");
    }

    render(
      <AppErrorBoundary>
        <ThrowingScreen />
      </AppErrorBoundary>,
    );

    expect(screen.getByRole("heading", { name: "Something went wrong" })).toBeInTheDocument();
    expect(screen.queryByText(/sensitive internal failure detail/i)).not.toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Try again" })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Return home" })).toBeInTheDocument();
  });
});
