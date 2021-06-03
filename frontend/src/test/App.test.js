import { render, screen } from '@testing-library/react';
import App from '../App';

test('renders welcome text', () => {
  render(<App />);
  const linkElement = screen.getByText(/welcome to tic-tac-toe game/i);
  expect(linkElement).toBeInTheDocument();
});
