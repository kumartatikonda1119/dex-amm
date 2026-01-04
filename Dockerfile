FROM node:18-alpine

# Install system dependencies for Hardhat
RUN apk add --no-cache git python3 make g++

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the project
COPY . .

# Make verification script executable
RUN chmod +x verify.sh

# Default command - run verification
CMD ["./verify.sh"]
