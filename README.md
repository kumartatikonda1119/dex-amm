# Decentralized Exchange with AMM Protocol

## What is This Project?

This project implements a **Decentralized Exchange (DEX)** using an **Automated Market Maker (AMM)** system, similar to Uniswap V2. Unlike traditional exchanges that use order books, AMMs allow users to trade cryptocurrencies directly through smart contracts using mathematical formulas.

### Key Features for Users

- **Add Liquidity**: Provide tokens to the pool and earn trading fees
- **Remove Liquidity**: Withdraw your share of the pool anytime
- **Swap Tokens**: Exchange one token for another instantly
- **Earn Fees**: Liquidity providers get 0.3% of all trades in their pool

### Why AMM?

Traditional exchanges need buyers and sellers to match orders. AMMs use a "liquidity pool" where anyone can trade against the pool's reserves. The price is determined by a simple formula: `x * y = k`, where x and y are token amounts in the pool.

---

## Project Summary

This implementation provides a basic **Decentralized Exchange (DEX)** utilizing an **Automated Market Maker (AMM)** approach, modeled after Uniswap V2's core principles.

The exchange facilitates peer-to-peer token trading without traditional order matching or centralized authorities. Participants can contribute liquidity, withdraw their share, and perform token exchanges leveraging the constant product mathematical model.

The solution is thoroughly tested, containerized with Docker, and prioritizes security and mathematical accuracy.

---

## Key Capabilities

- Provision of initial and additional liquidity
- Proportional liquidity withdrawal
- Token exchanges via constant product formula (x \* y = k)
- 0.3% transaction fee benefiting liquidity contributors
- LP token creation and destruction
- Precise reserve management
- Comprehensive event logging
- Complete Docker containerization
- Extensive test suite with 25+ scenarios achieving high coverage

---

## System Design

### Contract Components

#### DEX.sol - Main Exchange Contract

**Core Functions:**

- `addLiquidity(uint256 amountA, uint256 amountB)` - Add tokens to the liquidity pool
- `removeLiquidity(uint256 liquidityAmount)` - Remove your liquidity and get tokens back
- `swapAForB(uint256 amountAIn)` - Swap Token A for Token B
- `swapBForA(uint256 amountBIn)` - Swap Token B for Token A
- `getPrice()` - Get current exchange rate
- `getReserves()` - Check pool's token balances

**Key Features:**

- Primary AMM functionality
- Liquidity operations
- Exchange mechanics including fees
- Reserve management
- Built-in LP token handling

#### MockERC20.sol - Test Token Contract

- ERC-20 standard token for development
- Flexible minting for test environments
- Used for testing the DEX functionality

### Implementation Choices

- **Consolidated LP token management** for streamlined design
- **Direct reserve tracking** (not relying on contract balances)
- **Open access** without administrative controls
- **Fee accumulation** directly in the pool for LP incentives
- **Reentrancy safeguards** on all state-modifying operations

---

## How the AMM Works (Mathematics)

### The Constant Product Formula

The core of any AMM is the invariant: **`x * y = k`**

- `x` = amount of Token A in the pool
- `y` = amount of Token B in the pool
- `k` = constant (stays the same or increases with fees)

**Example:** If the pool has 100 Token A and 200 Token B, then k = 100 × 200 = 20,000.

When someone trades, the ratio changes but k remains constant (ignoring fees).

### Trading with Fees

Every swap includes a **0.3% fee** that goes to liquidity providers.

**Fee Calculation:**

```
amountInWithFee = amountIn × 997
numerator = amountInWithFee × reserveOut
denominator = (reserveIn × 1000) + amountInWithFee
amountOut = numerator / denominator
```

**What this means:**

- 99.7% of your input determines the price
- 0.3% stays in the pool as a reward for LPs
- The pool slowly grows with each trade

### Liquidity Provider Rewards

#### Adding Liquidity

**First LP:** Gets `sqrt(amountA × amountB)` LP tokens (sets initial price)

**Additional LPs:** Must match current ratio, get tokens proportional to their share

#### Removing Liquidity

Get back tokens proportional to LP tokens burned:

- `amountA = (liquidityBurned × reserveA) / totalLiquidity`
- `amountB = (liquidityBurned × reserveB) / totalLiquidity`

**Profit from fees:** When you remove liquidity, you get more tokens than you added (due to accumulated fees)!

---

## Installation Guide

### System Requirements

- **Node.js**: Version 18 or higher (download from [nodejs.org](https://nodejs.org/))
- **Docker & Docker Compose**: For containerized development (download from [docker.com](https://www.docker.com/))
- **Git**: For version control (usually pre-installed on most systems)

### Quick Start with Docker (Optional)

If you prefer Docker:

```bash
docker-compose run --rm verify
```

### Local Development (Windows)

For Windows users:

### Project Structure

```
dex-amm/
├── contracts/           # Smart contracts
│   ├── DEX.sol         # Main AMM contract
│   └── MockERC20.sol   # Test ERC-20 token
├── test/               # Test files
│   └── DEX.test.js     # Complete test suite
├── scripts/            # Deployment scripts
│   └── deploy.js       # Contract deployment
├── Dockerfile          # Docker container config
├── docker-compose.yml  # Multi-container setup
├── hardhat.config.js   # Hardhat configuration
├── package.json        # Node.js dependencies
└── README.md           # This file
```

### Available NPM Scripts

- `npm run compile` - Compile Solidity contracts
- `npm run test` - Run the full test suite
- `npm run coverage` - Generate coverage report
- `npm run deploy` - Deploy contracts to local network

---

## Testing & Verification

### Test Suite Overview

The project includes a comprehensive test suite with **27 automated test cases** built using **Hardhat** and **Chai**. The tests cover:

- **Liquidity Management**: Adding/removing liquidity, LP token calculations
- **Token Swaps**: Trading between tokens with correct fee calculations
- **Price Calculations**: Exchange rate updates after trades
- **Fee Distribution**: Ensuring LPs receive their share of trading fees
- **Edge Cases**: Very small/large amounts, unauthorized access
- **Events**: Proper event emission for all state changes

### Running Tests

```bash
# With Docker
docker-compose exec app npm test

# Locally
npm test
```

### Code Coverage

The test suite achieves **97%+ code coverage**, ensuring high reliability.

```bash
# With Docker
docker-compose exec app npm run coverage

# Locally
npm run coverage
```

### Verification Checklist

**Run this single command to verify everything:**

```batch
verify.bat
```

This will automatically:

- ✅ Install dependencies
- ✅ Compile contracts
- ✅ Run all 27 tests
- ✅ Generate coverage report (97%+)
- ✅ Confirm submission readiness

## How to Use the DEX

### Basic Workflow

1. **Deploy Contracts**: Deploy DEX and token contracts to blockchain
2. **Add Liquidity**: First user creates the trading pool
3. **Trade Tokens**: Users can swap between tokens instantly
4. **Earn Fees**: Liquidity providers collect 0.3% of all trades
5. **Remove Liquidity**: LPs can withdraw their share anytime

### Code Example

```javascript
// 1. Deploy tokens and DEX
const tokenA = await MockERC20.deploy("Token A", "TKA");
const tokenB = await MockERC20.deploy("Token B", "TKB");
const dex = await DEX.deploy(tokenA.address, tokenB.address);

// 2. Add initial liquidity (100 A + 200 B)
await tokenA.approve(dex.address, 100);
await tokenB.approve(dex.address, 200);
await dex.addLiquidity(100, 200);

// 3. Check price (2 B per A)
const price = await dex.getPrice();

// 4. Swap 10 A for B (gets ~18.18 B after fee)
await dex.swapAForB(10);

// 5. Price increases due to trade
const newPrice = await dex.getPrice();
```

### Available Functions

- `addLiquidity(amountA, amountB)` - Add tokens to pool
- `removeLiquidity(amount)` - Remove liquidity tokens
- `swapAForB(amountAIn)` - Swap A for B
- `swapBForA(amountBIn)` - Swap B for A
- `getPrice()` - Get current A/B price
- `getReserves()` - Check pool balances

## Deployment Information

Contracts are not deployed to public testnets.
Evaluation occurs locally via Hardhat network and Docker environment.

---

## Current Constraints

- Single trading pair support only
- Absence of slippage control parameters
- No time-limited transaction features
- Lack of price feed integration
- No support for multiple liquidity pools

These restrictions are deliberate to emphasize fundamental AMM operations.

---

## Security Measures

- Reentrancy prevention with `ReentrancyGuard`
- Comprehensive input validation across public methods
- Solidity 0.8+ automatic overflow/underflow checks
- Manual reserve tracking
- No administrative privileges
- Fully decentralized and trustless architecture

---

## Potential Improvements

- Minimum output amount for slippage control
- Time-sensitive exchange operations
- Support for multiple token pairs
- Standardized ERC-20 LP tokens
- Instantaneous loan exchanges
- Price estimation utility functions

---

## Developer

Kumar Tatikonda
