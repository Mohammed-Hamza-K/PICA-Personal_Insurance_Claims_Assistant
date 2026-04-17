#!/bin/bash

# PICA - Personal Insurance Claims Assistant AI Claims Chatbot — Integrated Launcher
# This script runs both the React/Vite frontend and FastAPI backend

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$PROJECT_DIR/backend"
FRONTEND_DIR="$PROJECT_DIR/frontend"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        PICA - Personal Insurance Claims Assistant AI Claims Chatbot                   ║"
echo "║            Integrated Application Launcher                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Function to cleanup on exit
cleanup() {
    echo -e "\n${YELLOW}🛑 Shutting down services...${NC}"
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    echo -e "${GREEN}✅ Cleanup complete${NC}"
}

# Set up trap to clean up on exit
trap cleanup EXIT INT TERM

# Function to check and free ports
free_ports() {
    echo -e "${BLUE}🔌 Checking for ports in use...${NC}"
    
    # Check if port 8000 is in use
    if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Port 8000 is already in use${NC}"
        PIDS=$(lsof -t -i :8000)
        if [ ! -z "$PIDS" ]; then
            echo -e "${YELLOW}🛑 Killing process(es) using port 8000: $PIDS${NC}"
            kill -9 $PIDS 2>/dev/null || true
            sleep 1
        fi
        echo -e "${GREEN}✅ Port 8000 is now free${NC}"
    fi
    
    # Check if port 5173 is in use
    if lsof -Pi :5173 -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Port 5173 is already in use${NC}"
        PIDS=$(lsof -t -i :5173)
        if [ ! -z "$PIDS" ]; then
            echo -e "${YELLOW}🛑 Killing process(es) using port 5173: $PIDS${NC}"
            kill -9 $PIDS 2>/dev/null || true
            sleep 1
        fi
        echo -e "${GREEN}✅ Port 5173 is now free${NC}"
    fi
}

# Check Python environment
echo -e "${BLUE}📋 Checking Python environment...${NC}"
if [ ! -d "$PROJECT_DIR/.venv" ]; then
    echo -e "${YELLOW}⚠️  Virtual environment not found, creating...${NC}"
    cd "$PROJECT_DIR"
    python3 -m venv .venv
    echo -e "${GREEN}✅ Virtual environment created${NC}"
fi

# Activate virtual environment
source "$PROJECT_DIR/.venv/bin/activate"

# Install backend dependencies if needed
echo -e "${BLUE}📦 Checking backend dependencies...${NC}"
pip install -q -r "$PROJECT_DIR/requirements.txt"
echo -e "${GREEN}✅ Backend dependencies installed${NC}"

# Check frontend dependencies
echo -e "${BLUE}📦 Checking frontend dependencies...${NC}"
if [ ! -d "$FRONTEND_DIR/node_modules" ]; then
    echo -e "${YELLOW}⚠️  Installing frontend dependencies...${NC}"
    cd "$FRONTEND_DIR"
    npm install
    echo -e "${GREEN}✅ Frontend dependencies installed${NC}"
else
    echo -e "${GREEN}✅ Frontend dependencies ready${NC}"
fi

# Check .env file
echo -e "${BLUE}🔐 Checking environment configuration...${NC}"
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo -e "${YELLOW}⚠️  .env file not found${NC}"
    echo "Creating .env from .env.example..."
    cp "$PROJECT_DIR/.env.example" "$PROJECT_DIR/.env"
    echo -e "${YELLOW}⚠️  Please update .env with your OpenAI API key:${NC}"
    echo -e "${YELLOW}   OPENAI_API_KEY=your_api_key_here${NC}"
    echo ""
    read -p "Press Enter to continue with existing .env or Ctrl+C to edit..."
fi

# Free up ports before starting services
free_ports

# Start backend
echo -e "\n${BLUE}🚀 Starting FastAPI Backend...${NC}"
cd "$BACKEND_DIR"
python run.py &
BACKEND_PID=$!
echo -e "${GREEN}✅ Backend PID: $BACKEND_PID${NC}"

# Wait for backend to start
sleep 3

# Check if backend is running
if ! kill -0 $BACKEND_PID 2>/dev/null; then
    echo -e "${RED}❌ Backend failed to start${NC}"
    exit 1
fi

# Check backend health
echo -e "${BLUE}🏥 Checking backend health...${NC}"
for i in {1..10}; do
    if curl -s http://localhost:8000/health > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Backend is healthy${NC}"
        break
    fi
    if [ $i -eq 10 ]; then
        echo -e "${RED}❌ Backend health check failed${NC}"
        exit 1
    fi
    echo "  Attempt $i/10..."
    sleep 1
done

# Start frontend
echo -e "\n${BLUE}🚀 Starting React/Vite Frontend...${NC}"
cd "$FRONTEND_DIR"
npm run dev &
FRONTEND_PID=$!
echo -e "${GREEN}✅ Frontend PID: $FRONTEND_PID${NC}"

# Wait for frontend to start
sleep 3

# Display running information
echo -e "\n${GREEN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║             🎉 Application is Running! 🎉                 ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║  Backend API:        http://localhost:8000                 ║"
echo "║  API Docs (Swagger): http://localhost:8000/docs           ║"
echo "║  Frontend:           http://localhost:5173                ║"
echo "║                                                            ║"
echo "║  Press Ctrl+C to stop all services                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Open browser if possible
sleep 2
if command -v open &> /dev/null; then
    open "http://localhost:5173"
    echo -e "${BLUE}📱 Opening frontend in browser...${NC}"
fi

# Keep script running
wait
