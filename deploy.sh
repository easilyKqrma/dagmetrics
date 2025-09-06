#!/bin/bash

# =============================================================================
# DEPLOYMENT SETUP SCRIPT
# =============================================================================
# Script para deployment en plataformas externas (Render, Vercel, etc.)

set -e

echo "🚀 Iniciando deployment setup..."
echo "=================================================="

# 1. Install Python dependencies
echo "📦 Instalando dependencias Python..."
if [ -f "python_requirements.txt" ]; then
    pip install -r python_requirements.txt
    echo "✅ Dependencias Python instaladas"
else
    echo "⚠️  python_requirements.txt no encontrado, instalando dependencias básicas..."
    pip install flask requests gunicorn
fi

# 2. Install Node.js dependencies
echo "📦 Instalando dependencias Node.js..."
npm install
echo "✅ Dependencias Node.js instaladas"

# 3. Create .env if it doesn't exist
echo "🔧 Configurando variables de entorno..."
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "✅ Archivo .env creado desde .env.example"
    else
        echo "⚠️  .env.example no encontrado, creando .env básico..."
        cat > .env << EOF
JWT_SECRET=deployment-jwt-secret-change-this
SESSION_SECRET=deployment-session-secret-change-this
DATABASE_URL=postgresql://user:pass@host:port/database
PAYPAL_CLIENT_ID=your-paypal-client-id
PAYPAL_CLIENT_SECRET=your-paypal-client-secret
PORT=5000
NODE_ENV=production
EOF
    fi
fi

# 4. Build the project
echo "🏗️  Construyendo proyecto..."
npm run build
echo "✅ Proyecto construido"

echo ""
echo "🎉 ¡Deployment setup completado!"
echo "=================================================="
echo "📋 Configurar en tu plataforma de deployment:"
echo "   Build Command: sh ./deploy.sh"
echo "   Start Command: python main.py"
echo "   Root Directory: ."
echo ""
echo "⚠️  IMPORTANTE: Configura estas variables de entorno:"
echo "   - DATABASE_URL"
echo "   - JWT_SECRET"
echo "   - SESSION_SECRET"
echo "   - PAYPAL_CLIENT_ID"
echo "   - PAYPAL_CLIENT_SECRET"
echo "=================================================="