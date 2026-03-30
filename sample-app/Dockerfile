# Multi-stage build for OpenClaw Demo
# Optimized for Depot CI fast builds

FROM node:18-alpine AS base
WORKDIR /app

# Install dependencies layer (cached by Depot)
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && \
    npm cache clean --force

# Build stage
FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Production stage
FROM base AS production
ENV NODE_ENV=production

# Copy built files and production dependencies
COPY --from=build /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
COPY package.json ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S openclaw -u 1001
USER openclaw

EXPOSE 3000

CMD ["node", "dist/index.js"]
