-- Users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  profession VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Income table
CREATE TABLE income (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  source VARCHAR(255) NOT NULL,
  amount DECIMAL(12, 2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'TRY',
  month DATE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, source, month)
);

-- Expenses table
CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  category VARCHAR(255) NOT NULL,
  amount DECIMAL(12, 2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'TRY',
  expense_date DATE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Investment Portfolio table
CREATE TABLE portfolio (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  symbol VARCHAR(20) NOT NULL,
  type VARCHAR(50) NOT NULL, -- 'BIST', 'CRYPTO', 'FUND', 'BOND'
  quantity DECIMAL(20, 8) NOT NULL,
  purchase_price DECIMAL(15, 6) NOT NULL,
  purchase_date DATE NOT NULL,
  current_price DECIMAL(15, 6),
  currency VARCHAR(3) DEFAULT 'TRY',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transaction History table
CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  portfolio_id INTEGER NOT NULL REFERENCES portfolio(id),
  transaction_type VARCHAR(50) NOT NULL, -- 'BUY', 'SELL', 'DIVIDEND'
  quantity DECIMAL(20, 8) NOT NULL,
  price DECIMAL(15, 6) NOT NULL,
  total_amount DECIMAL(15, 2) NOT NULL,
  transaction_date DATE NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Currency Rates table
CREATE TABLE currency_rates (
  id SERIAL PRIMARY KEY,
  base_currency VARCHAR(3) DEFAULT 'TRY',
  target_currency VARCHAR(3) NOT NULL,
  rate DECIMAL(12, 6) NOT NULL,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AI Agent Queries table
CREATE TABLE agent_queries (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  query TEXT NOT NULL,
  response TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for better performance
CREATE INDEX idx_income_user_id ON income(user_id);
CREATE INDEX idx_expenses_user_id ON expenses(user_id);
CREATE INDEX idx_portfolio_user_id ON portfolio(user_id);
CREATE INDEX idx_transactions_portfolio_id ON transactions(portfolio_id);
CREATE INDEX idx_agent_queries_user_id ON agent_queries(user_id);

-- Create extension for UUID if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
