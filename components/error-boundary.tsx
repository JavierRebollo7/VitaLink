import React from 'react';

interface Props {
  children: React.ReactNode;
}

interface State {
  hasError: boolean;
}

class ErrorBoundary extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };

    // Override console.warn to filter out preload warnings
    const originalWarn = console.warn;
    console.warn = (...args) => {
      const warningMessage = args[0]?.toString() || '';
      if (
        !warningMessage.includes('was preloaded using link preload') &&
        !warningMessage.includes('cdn.office.net') &&
        !warningMessage.includes('officeonline')
      ) {
        originalWarn.apply(console, args);
      }
    };
  }

  static getDerivedStateFromError(_: Error): State {
    return { hasError: false }; // Return false to suppress the error UI
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    // Optionally log the error to a service
    if (
      !error.message.includes('navigation') && 
      !error.message.includes('DOMNodeInserted') &&
      !error.message.includes('Some icons were re-registered') &&
      !error.message.includes('was preloaded using link preload') &&
      !error.message.includes('cdn.office.net') &&
      !error.message.includes('officeonline')
    ) {
      console.error('Error:', error);
      console.error('Error Info:', errorInfo);
    }
  }

  render() {
    return this.props.children;
  }
}

export default ErrorBoundary; 