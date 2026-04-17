# 🔐 PICA - Personal Insurance Claims Assistant - Personal Intelligent Claims Assistant

**AI-Powered Healthcare Claims Processing with Multi-Agent LLM Architecture**

A modern, full-stack application for intelligent healthcare insurance claims processing using LangGraph multi-agent orchestration, FastAPI backend, and React/Vite frontend.

## 🎯 Overview

PICA - Personal Insurance Claims Assistant is an intelligent claims processing system powered by advanced AI agents, featuring:

- **🤖 Multi-Agent Architecture**: Principal, Parent (5 specialized), and Child agents using LangGraph
- **🧠 LLM-Powered**: OpenAI GPT-4o models with intelligent decision-making
- **⚡ FastAPI Backend**: Modern async Python API framework
- **🎨 React/Vite Frontend**: Professional, responsive UI with real-time updates
- **🔐 Production-Ready**: JWT auth, rate limiting, comprehensive error handling
- **💬 Real-time Chat**: WebSocket support for live conversations

## ✨ Key Features

- **Intelligent Claims Processing**: 5-tier parent agent system (Intake, Eligibility, Everyday Medical, Maternity, Exceptions)
- **Multi-Model LLM**: Specialized agents with GPT-4o and GPT-4o-mini models
- **Professional UI**: Modern dark-themed interface with Tailwind CSS
- **Real-time Streaming**: WebSocket chat with live response streaming
- **Member Management**: Comprehensive member database and profiles
- **Claims Tracking**: Full claim lifecycle management with status updates
- **Authentication**: JWT-based user authentication and authorization
- **API Documentation**: Auto-generated Swagger/OpenAPI docs

## 🏗️ Modern Architecture

```
da-claim-assistant/
├── backend/                        # FastAPI backend
│   ├── app/
│   │   ├── main.py                # FastAPI app entry
│   │   ├── config.py              # Configuration management
│   │   ├── auth/                  # Authentication module
│   │   │   ├── __init__.py
│   │   │   └── users.py
│   │   ├── routers/               # API routes
│   │   │   ├── auth.py            # Auth endpoints
│   │   │   ├── chat.py            # Chat endpoints
│   │   │   ├── claims.py          # Claims management
│   │   │   ├── members.py         # Member management
│   │   │   └── queue.py           # Processing queue
│   │   ├── agents/                # LangGraph agents
│   │   │   ├── conversation.py    # Conversation manager
│   │   │   ├── graph.py           # Agent graph compilation
│   │   │   ├── state.py           # Shared state
│   │   │   ├── principal.py       # Principal agent
│   │   │   ├── parent_1_intake.py # Intake agent
│   │   │   ├── parent_2_eligibility.py
│   │   │   ├── parent_3_outpatient.py
│   │   │   ├── parent_4_maternity.py
│   │   │   ├── parent_5_exceptions.py
│   │   │   └── child_agents.py    # Child agents
│   │   ├── models/                # Data models
│   │   │   ├── database.py        # JSON data loader
│   │   │   └── schemas.py         # Pydantic schemas
│   │   ├── prompts/               # LLM system prompts
│   │   │   ├── principal.py
│   │   │   ├── intake.py
│   │   │   ├── eligibility.py
│   │   │   ├── outpatient.py
│   │   │   ├── maternity.py
│   │   │   └── exceptions.py
│   │   └── tools/                 # LLM tools
│   │       ├── member_tools.py
│   │       ├── claim_tools.py
│   │       └── policy_tools.py
│   ├── run.py                     # Uvicorn launcher
│   └── __init__.py
├── frontend/                       # React/Vite frontend
│   ├── src/
│   │   ├── main.jsx               # React entry
│   │   ├── App.jsx                # Main app component
│   │   ├── index.css              # Tailwind + theme
│   │   ├── pages/                 # Page components
│   │   │   ├── LoginPage.jsx
│   │   │   ├── DashboardPage.jsx
│   │   │   ├── ChatPage.jsx
│   │   │   └── ClaimsPage.jsx
│   │   ├── components/            # Reusable components
│   │   │   ├── Sidebar.jsx
│   │   │   ├── Header.jsx
│   │   │   └── ChatInput.jsx
│   │   ├── services/              # API services
│   │   │   ├── api.js
│   │   │   └── websocket.js
│   │   ├── hooks/                 # Custom hooks
│   │   └── utils/                 # Utilities
│   │       ├── constants.js
│   │       └── format.js
│   ├── package.json
│   ├── vite.config.js
│   ├── index.html
│   └── node_modules/
├── data/                           # Application data
│   ├── members.json
│   ├── claims.json
│   └── policies.json
├── backups/                        # Old files backup
├── lui-pica-ai/                   # Reference implementation
├── requirements.txt               # Python dependencies
├── .env.example                   # Environment template
├── run_integrated.sh              # Integrated launcher
└── README.md                      # This file
```

## 🚀 Quick Start

### Prerequisites

- **Python 3.10+** (for FastAPI and LangGraph)
- **Node.js 16+** (for React/Vite frontend)
- **OpenAI API Key** (get one at https://platform.openai.com/api-keys)

### Installation & Running

#### Option 1: Automated Integration (Recommended)

```bash
cd /Users/soudi/Documents/GitHub/da-claim-assistant
chmod +x run_integrated.sh
./run_integrated.sh
```

This will:
- Set up Python virtual environment
- Install backend dependencies (FastAPI, LangChain, LangGraph, OpenAI)
- Install frontend dependencies (React, Vite, Tailwind)
- Start FastAPI backend on port 8000
- Start React dev server on port 5173
- Open frontend in your default browser

#### Option 2: Manual Backend Start

```bash
# Activate virtual environment
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Start FastAPI backend
cd backend
python run.py
```

Backend will be available at: `http://localhost:8000`

#### Option 3: Manual Frontend Start

```bash
# Install dependencies (first time only)
cd frontend
npm install

# Start Vite dev server
npm run dev
```

Frontend will be available at: `http://localhost:5173`

## 📈 Insurance CSV Modeling (2 ML + 1 DL)

This project now includes a dedicated training pipeline for your insurance dataset:

- **Dataset**: `backend/fraud_ml/datasets/insurance.csv`
- **Target hint supported**: `InsuranceClaimed?` (auto-resolved to `insuranceclaim`)
- **Models**:
  - Logistic Regression (ML)
  - Random Forest (ML)
  - Deep Neural Network (PyTorch when available, safe fallback to MLP)

Run:

```bash
python backend/fraud_ml/train_insurance_claim_models.py --dataset backend/fraud_ml/datasets/insurance.csv --target "InsuranceClaimed?" --output-dir backend/fraud_ml/results/insurance_claim
```

Outputs:

- `backend/fraud_ml/results/insurance_claim/model_summary.json`
- `backend/fraud_ml/results/insurance_claim/model_ranking.csv`
- Serialized preprocessor/models in the same folder

## 🌐 Access Points

After running the application:

| Component | URL | Purpose |
|-----------|-----|---------|
| **Frontend** | http://localhost:5173 | React UI |
| **API** | http://localhost:8000/api | REST API |
| **Swagger UI** | http://localhost:8000/docs | Interactive API docs |
| **ReDoc** | http://localhost:8000/redoc | Alternative API docs |
| **Health Check** | http://localhost:8000/health | Server status |

## 🤖 Multi-Agent System Architecture

### Agent Hierarchy

```
                          Principal Agent
                         (Orchestrator)
                                |
              ________________________________________
             |        |        |        |            |
        Parent 1   Parent 2  Parent 3  Parent 4  Parent 5
        (Intake) (Eligibility)(OutPat)(Maternity)(Exceptions)
             |        |        |        |            |
             └─────────────────┴────────┴────────────┘
                         |
                    Child Agents
                (Simple Processing)
```

### Agent Descriptions

| Agent | Model | Purpose |
|-------|-------|---------|
| **Principal** | GPT-4o | Routes claims to appropriate parent agents |
| **Parent 1: Intake** | GPT-4o | Document intelligence, initial validation |
| **Parent 2: Eligibility** | GPT-4o | Member eligibility, policy checks |
| **Parent 3: Everyday Medical** | GPT-4o | Out-patient, routine treatments |
| **Parent 4: Maternity** | GPT-4o | Maternity claims, special care |
| **Parent 5: Exceptions** | GPT-4o | Complex cases, legal issues, recoveries |
| **Child Agents** | GPT-4o-mini | Simple tasks, form filling |

## 🔌 API Endpoints

### Authentication

```
POST   /api/auth/register      # Register new user
POST   /api/auth/login         # Login user
POST   /api/auth/refresh       # Refresh JWT token
POST   /api/auth/logout        # Logout user
```

### Chat & Conversation

```
POST   /api/chat/send          # Send message to claim assistant
GET    /api/chat/history/{id}  # Get conversation history
WebSocket /ws/chat/{session}   # Real-time chat streaming
```

### Claims Management

```
GET    /api/claims             # List all claims
GET    /api/claims/{id}        # Get claim details
POST   /api/claims             # Submit new claim
PUT    /api/claims/{id}        # Update claim
DELETE /api/claims/{id}        # Delete claim
WebSocket /ws/claim-status/{id} # Real-time status updates
```

### Members

```
GET    /api/members            # List all members
GET    /api/members/{id}       # Get member details
POST   /api/members            # Create new member
PUT    /api/members/{id}       # Update member
```

### Queue & Processing

```
GET    /api/queue              # View processing queue
POST   /api/queue/process      # Process pending claims
GET    /api/queue/status/{id}  # Get processing status
```

### Health & Status

```
GET    /health                 # Health check
GET    /docs                   # Swagger UI
GET    /redoc                  # ReDoc UI
```

## 🔐 Configuration

### Environment Variables

Create `.env` file from `.env.example`:

```bash
# OpenAI Configuration
OPENAI_API_KEY=sk-your-api-key-here
OPENAI_MODEL_PRINCIPAL=gpt-4o
OPENAI_MODEL_PARENT=gpt-4o
OPENAI_MODEL_CHILD=gpt-4o-mini

# Server Configuration
APP_HOST=0.0.0.0
APP_PORT=8000
DEBUG=true

# Security
JWT_SECRET=your-secret-key-change-in-production
JWT_ALGORITHM=HS256
JWT_EXPIRATION_HOURS=24

# Rate Limiting
RATE_LIMIT_CHAT=30/minute
MAX_MESSAGE_LENGTH=2000
MAX_BATCH_SIZE=100

# Features
USE_REAL_OCR=false
USE_LLM_CHILDREN=true
ENABLE_WEBSOCKETS=true
```

## 📚 Documentation Files

- **README.md** - This file (project overview)
- **START_HERE.md** - Quick start guide
- **INTEGRATION_GUIDE.md** - Architecture and integration details
- **ARCHITECTURE_NARRATIVE.md** - Detailed system design
- **API.md** - Complete API reference

## 🛠️ Development Guide

### Backend Development

```bash
# Activate virtual environment
source .venv/bin/activate

# Install dev dependencies
pip install -r requirements.txt
pip install pytest pytest-asyncio black pylint

# Run backend with auto-reload
cd backend
python run.py

# Run tests
pytest tests/

# Format code
black app/

# Lint code
pylint app/
```

### Frontend Development

```bash
cd frontend

# Start dev server with hot reload
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Format code
npm run format

# Lint code
npm run lint
```

## 🧪 Testing the Application

### Test API Endpoints

```bash
# Health check
curl http://localhost:8000/health

# Get API docs
curl http://localhost:8000/docs

# Send a test message
curl -X POST http://localhost:8000/api/chat/send \
  -H "Content-Type: application/json" \
  -d '{"session_id":"test","message":"Hello, I need help with my claim"}'
```

### Test WebSocket Chat

```bash
# Using websocat (install: brew install websocat)
websocat ws://localhost:8000/ws/chat/test-session

# Then type messages and see real-time responses
```

## 🚢 Deployment

### Production Build

```bash
# Build frontend
cd frontend
npm run build
# Output: frontend/dist/

# Backend is ready for deployment with:
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 4
```

### Docker Deployment

```bash
# Build image
docker build -t pica-healthcare .

# Run container
docker run -p 8000:8000 -p 5173:5173 \
  -e OPENAI_API_KEY=your_key \
  pica-healthcare
```

### Deployment Checklist

- [ ] Set `DEBUG=false` in production
- [ ] Use strong `JWT_SECRET`
- [ ] Configure proper `CORS_ORIGINS`
- [ ] Set up SSL/HTTPS
- [ ] Configure logging and monitoring
- [ ] Use production OpenAI API keys
- [ ] Set up database (if not using JSON)
- [ ] Configure rate limiting appropriately
- [ ] Enable authentication for all endpoints
- [ ] Set up backup and recovery procedures

## 🐛 Troubleshooting

### Backend won't start

```bash
# Check Python version
python --version  # Must be 3.10+

# Verify virtual environment
source .venv/bin/activate

# Check dependencies
pip list | grep fastapi

# Check OpenAI API key
echo $OPENAI_API_KEY

# Check port availability
lsof -i :8000
```

### Frontend won't build

```bash
cd frontend

# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install

# Build again
npm run build

# Check for errors
npm run lint
```

### API connection issues

```bash
# Verify backend is running
curl http://localhost:8000/health

# Check CORS configuration
# Check network tab in browser DevTools
# Check backend logs for errors
```

### WebSocket connection fails

```bash
# Verify WebSocket support is enabled
grep -i "websocket" .env

# Check browser console for connection errors
# Verify backend is running
# Check firewall settings
```

## 📊 Performance & Scalability

- **Async Operations**: All I/O is non-blocking with FastAPI
- **Connection Pooling**: Efficient database connections
- **Rate Limiting**: SlowAPI prevents abuse
- **Caching**: In-memory caching for frequently accessed data
- **Load Balancing**: Run multiple backend instances with Gunicorn/Uvicorn

## 🤝 Contributing

To improve PICA - Personal Insurance Claims Assistant:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.

## 🎓 References & Resources

- **FastAPI**: https://fastapi.tiangolo.com/
- **LangChain**: https://python.langchain.com/
- **LangGraph**: https://github.com/langchain-ai/langgraph
- **OpenAI API**: https://platform.openai.com/docs/
- **React**: https://react.dev/
- **Vite**: https://vitejs.dev/
- **Tailwind CSS**: https://tailwindcss.com/

## 🎉 Getting Started

**Ready to process claims intelligently?**

```bash
cd /Users/soudi/Documents/GitHub/da-claim-assistant
chmod +x run_integrated.sh
./run_integrated.sh
```

The integrated launcher will set up everything and open the frontend automatically!

---

**Built with ❤️ using FastAPI, LangGraph, OpenAI, React, and Vite**

*Last Updated: April 12, 2026*
