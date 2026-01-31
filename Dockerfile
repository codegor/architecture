FROM node:22-alpine

WORKDIR /app

RUN addgroup --system --gid 1000 user && \
    adduser --system --uid 1000 user

USER user

RUN corepack enable && corepack prepare pnpm@latest --activate
RUN corepack install -g pnpm@latest

# Download and extract repository from GitHub
RUN apk add --no-cache curl unzip && \
    curl -L -H "Cache-Control: no-cache" -H "Pragma: no-cache" https://github.com/codegor/hyperion-docs/archive/refs/heads/main.zip?t=$(date +%s) -o repo.zip && \
    unzip -q repo.zip && \
    cp pnpm-workspace.yaml pnpm-lock.yaml .npmrc package.json turbo.json /tmp/backup/ 2>/dev/null || true && \
    cp -r hyperion-docs-main/* . && \
    rm -rf repo.zip hyperion-docs-main

# Ensure required directories exist for mounted volumes
RUN mkdir -p /app/apps/docs/content/docs /app/apps/docs/diagrams /app/apps/docs/openapi && \
    chmod -R 755 /app/apps/docs

RUN pnpm install --frozen-lockfile

EXPOSE 3000
ENV PORT=3000

RUN pnpm build:api-doc

# Start dev server
# pnpm turbo dev --filter=docs
CMD ["pnpm", "turbo", "dev", "--filter=docs"]
