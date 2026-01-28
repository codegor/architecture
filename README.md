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
```

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
└── diagrams/              # Diagram source files
    ├── architecture.puml
    ├── erd.puml
    ├── include-erd.puml
    ├── system-overview.puml
    └── flow.dot

api-doc-gen/
└── sample.yaml            # OpenAPI schema files
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

Generates API documentation from OpenAPI schemas in `api-doc-gen/` directory.

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

## License

See LICENSE file for details.
