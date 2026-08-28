import { Component } from "react";
import { ROUTES } from "@/lib/routes";

export class AppErrorBoundary extends Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  componentDidCatch(error, info) {
    console.error("Aevum web render failure", { error, componentStack: info.componentStack });
  }

  handleRetry = () => {
    this.setState({ hasError: false });
  };

  handleHome = () => {
    window.location.assign(ROUTES.HOME);
  };

  render() {
    if (!this.state.hasError) {
      return this.props.children;
    }

    return (
      <main className="min-h-screen bg-background-dark flex items-center justify-center px-6 py-12">
        <section className="w-full max-w-xl rounded-3xl border border-white/10 bg-white/5 p-8 text-center shadow-2xl">
          <p className="text-sm font-semibold uppercase tracking-[0.25em] text-primary">Aevum</p>
          <h1 className="mt-4 text-3xl font-bold text-white">Something went wrong</h1>
          <p className="mt-4 text-sm leading-6 text-gray-400">
            This screen could not be displayed. Try the screen again or return home and continue from a known route.
          </p>
          <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:justify-center">
            <button
              type="button"
              onClick={this.handleRetry}
              className="rounded-full bg-primary px-6 py-3 text-sm font-semibold text-white"
            >
              Try again
            </button>
            <button
              type="button"
              onClick={this.handleHome}
              className="rounded-full border border-white/15 px-6 py-3 text-sm font-semibold text-gray-200"
            >
              Return home
            </button>
          </div>
        </section>
      </main>
    );
  }
}

export default AppErrorBoundary;
