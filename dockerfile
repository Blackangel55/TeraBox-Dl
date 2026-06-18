# ---- Build stage ----
FROM oven/bun:1 AS builder

WORKDIR /app
COPY package.json bun.lockb* ./
RUN bun install --frozen-lockfile || bun install

COPY . .

# ---- Runtime stage ----
FROM oven/bun:1-slim

WORKDIR /app
COPY --from=builder /app /app

# Render injects PORT at runtime; default to 10000 (Render's standard)
ENV PORT=10000

EXPOSE 10000

CMD ["bun", "src/index.ts"]
