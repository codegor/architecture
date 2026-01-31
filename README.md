# Architecture Documentation

Documentation and diagrams-as-code for the Hyperion project, built with Fumadocs v15, Next.js, and Kroki for rendering diagrams from code.

## Quick Start

### Prerequisites

- Node.js 22+
- pnpm 10+
- Docker & Docker Compose v2

### Running with Make

```bash
# Start services
make run

# Build API documentation
make build-api

# Stop services
make stop

# Build production image
make prod-build

# Run production container
make prod-run
```

### Environment Variables

Create a `.env` file for default settings:

**`.env`** (default, safe to commit)
```
prod_port=3000
```

The Makefile will automatically use `.env.local` if it exists, otherwise fallback to `.env`.

### Docker Setup

```bash
# Start services
docker compose up -d

# Build API documentation
docker compose exec docs bash -c "pnpm build:api-doc"

# Stop services
docker compose down
```

## Project Structure

```
arch/
├── content/docs/          # MDX documentation files
│   ├── index.mdx
│   ├── quick-start.mdx
│   ├── diagramming.mdx
│   ├── meta.json
│   └── api/
│       ├── index.mdx
│       └── meta.json
├── diagrams/              # Diagram source files
│   ├── architecture.puml
│   ├── erd.puml
│   ├── include-erd.puml
│   ├── system-overview.puml
│   └── flow.dot
└── api/                   # OpenAPI schema files
    └── sample.yaml
```

## Building Documentation

### Start Development Server

```bash
make run
```

This starts the documentation server at **http://localhost:3000** with hot reload enabled.

### Build API Documentation

```bash
make build-api
```

Generates API documentation from OpenAPI schemas in `arch/api/` directory.

### Stop Services

```bash
make stop
```

## Working with Diagrams

### Supported Diagram Types

- **PlantUML** - `puml` files for UML, ERD, and sequence diagrams
- **Graphviz** - `dot` files for flowcharts and graphs
- **Mermaid** - Inline diagrams in MDX files

### Creating Diagrams

1. Add diagram files to `arch/diagrams/` (e.g., `architecture.puml`, `flow.dot`)
2. Reference in MDX files:

```mdx
<Diagram lang="plantuml" path="architecture.puml" alt="System Architecture" />
<Diagram lang="graphviz" path="flow.dot" alt="Processing Flow" />
```

### Diagram Features

- 🎨 **Dark/Light Theme Support** - All diagrams adapt automatically
- 🔍 **Zoomable Diagrams** - Click any diagram to open in fullscreen with pan/zoom
- 🚀 **Hot Reload** - Edit diagram files and see changes instantly

### Troubleshooting Diagrams

If diagrams aren't rendering:

1. Verify the Kroki service is running: `docker compose ps`
2. Check diagram file path is relative to `arch/diagrams/`
3. Verify the file format matches the `lang` parameter
4. Check browser console for API errors

## Project Features

- **Hot Reload** - Edit MDX or diagram files, see changes instantly
- **Type-Safe** - TypeScript strict mode throughout
- **Dark/Light Theme** - All content adapts automatically
- **Secure** - Path traversal protection, size limits, language validation
- **One Command Setup** - Single `make run` to start everything

## Tech Stack

- **Next.js 15** with Turbopack and App Router
- **Fumadocs v15** for documentation UI
- **Kroki** for diagram rendering
- **Mermaid** for inline diagrams
- **TailwindCSS 4** for styling
- **TypeScript 5.9** in strict mode
- **Docker & Docker Compose** for containerization

## Common Tasks

| Task | Command |
|------|---------|
| Start development | `make run` |
| Build API docs | `make build-api` |
| Stop services | `make stop` |
| Build production | `make prod-build` |
| Run production | `make prod-run` |
| View docs | http://localhost:3000 |

## Development

### Local without Docker

```bash
pnpm install
pnpm dev
```

> **Note**: Kroki must be running separately or accessible via `KROKI_BASE_URL`.

### Adding Content

1. Create MDX files in `arch/content/docs/`
2. Add diagrams to `arch/diagrams/`
3. Update navigation in `arch/content/docs/meta.json`
4. Changes hot-reload automatically

## Run in production

### Build production image
```bash
make prod-build
# OR
docker build . -f Dockerfile.prod -t architecture
```
It will build production-optimized image with all dependencies installed.

### Run docker container
```bash
make prod-run
# OR
docker run --env KROKI_BASE_URL=https://kroki.io -p 3000:3000 architecture
```

The `make prod-run` command automatically uses the port defined in your `.env` or `.env.local` file (default 3000 or 3050).

You can also override the port:
```bash
make prod-run prod_port=9000
```

Now you can see docs on **http://localhost:<port>** (e.g., **http://localhost:3000** or **http://localhost:3050**).

Please note that you need to set `KROKI_BASE_URL` to your Kroki instance. Here we set it to `https://kroki.io`,
what is public instance of Kroki but it could be insecure or unavailable to use in your production.

## License

See LICENSE file for details.
