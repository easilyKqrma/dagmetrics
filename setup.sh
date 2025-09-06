#!/bin/bash

# =============================================================================
# HOLAPAGE-77 PROJECT SETUP SCRIPT
# =============================================================================
# Este script inicializa completamente el proyecto HolaPage-77
# Funciona desde cero en cualquier entorno nuevo
# Instala dependencias, configura la base de datos e inicializa la aplicación

set -e  # Exit on any error

echo "🚀 Iniciando setup completo de HolaPage-77..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to generate random secret
generate_secret() {
    openssl rand -base64 32 2>/dev/null || node -e "console.log(require('crypto').randomBytes(32).toString('base64'))" 2>/dev/null || echo "RANDOM_SECRET_$(date +%s)_$(shuf -i 1000-9999 -n 1)"
}

# 1. Check and install Node.js if needed
echo ""
print_info "Verificando Node.js..."
if ! command_exists node; then
    print_error "Node.js no está instalado. Por favor instala Node.js 18+ primero:"
    echo "  • Descarga desde: https://nodejs.org/"
    echo "  • O usa un gestor de versiones como nvm"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js versión 18+ es requerida. Versión actual: $(node --version)"
    echo "Por favor actualiza Node.js"
    exit 1
fi

print_status "Node.js $(node --version) encontrado"

# 2. Check npm
if ! command_exists npm; then
    print_error "npm no está instalado. Por favor instala npm primero."
    exit 1
fi

# 3. Create .env file if it doesn't exist
echo ""
print_info "Configurando variables de entorno..."
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        print_status "Archivo .env creado desde .env.example"
        
        # Generate secrets automatically
        JWT_SECRET=$(generate_secret)
        SESSION_SECRET=$(generate_secret)
        
        # Replace placeholder values
        sed -i.bak "s/your-super-secret-jwt-key-change-this-to-something-random/$JWT_SECRET/" .env
        sed -i.bak "s/your-session-secret-key-change-this-too/$SESSION_SECRET/" .env
        rm -f .env.bak
        
        print_status "Secretos JWT y Session generados automáticamente"
        print_warning "IMPORTANTE: Configura las siguientes variables en el archivo .env:"
        echo "  • DATABASE_URL - URL de tu base de datos PostgreSQL"
        echo "  • PAYPAL_CLIENT_ID - Tu Client ID de PayPal"
        echo "  • PAYPAL_CLIENT_SECRET - Tu Client Secret de PayPal"
    else
        print_error "No se encontró .env.example. Creando .env básico..."
        cat > .env << EOF
# Database
DATABASE_URL=postgresql://username:password@localhost:5432/holapage77

# Security
JWT_SECRET=$(generate_secret)
SESSION_SECRET=$(generate_secret)

# PayPal
PAYPAL_CLIENT_ID=your-paypal-client-id
PAYPAL_CLIENT_SECRET=your-paypal-client-secret

# Application
PORT=5000
NODE_ENV=development
EOF
        print_status "Archivo .env básico creado"
    fi
else
    print_status "Archivo .env ya existe"
fi

# 4. Install dependencies
echo ""
print_info "Instalando dependencias de Node.js..."
if [ -f "package-lock.json" ]; then
    npm ci
else
    npm install
fi
print_status "Dependencias instaladas correctamente"

# 5. Check if DATABASE_URL is configured
echo ""
print_info "Verificando configuración de base de datos..."
source .env
if [ -z "$DATABASE_URL" ] || [ "$DATABASE_URL" = "postgresql://username:password@localhost:5432/holapage77" ]; then
    print_warning "DATABASE_URL no está configurada correctamente"
    print_info "Por favor configura tu DATABASE_URL en el archivo .env antes de continuar"
    print_info "Ejemplo: DATABASE_URL=postgresql://user:pass@host:port/database"
    echo ""
    print_info "El setup continuará, pero las migraciones de base de datos fallarán hasta que configures DATABASE_URL"
else
    # 6. Run database migrations
    echo ""
    print_info "Ejecutando migraciones de base de datos..."
    if npm run db:push; then
        print_status "Base de datos configurada correctamente"
    else
        print_warning "Error en migraciones de base de datos. Verifica tu DATABASE_URL"
        print_info "Puedes ejecutar 'npm run db:push' manualmente después de configurar la base de datos"
    fi
fi

# 7. Build the project
echo ""
print_info "Construyendo el proyecto..."
if npm run build; then
    print_status "Proyecto construido correctamente"
else
    print_warning "Error en el build del proyecto. Puedes intentar 'npm run build' manualmente"
fi

# 8. Final setup message
echo ""
echo "🎉 ¡Setup completado!"
echo "=================================================="
print_status "Proyecto HolaPage-77 configurado correctamente"
echo ""
print_info "Comandos disponibles:"
echo "  🔧 Desarrollo:     npm run dev"
echo "  🏗️  Build:          npm run build" 
echo "  🚀 Producción:     npm run start"
echo "  🗃️  DB Push:        npm run db:push"
echo "  ✅ Type Check:     npm run check"
echo ""
print_info "Configuración:"
echo "  📁 Puerto:         5000 (configurable en .env)"
echo "  🌐 URL Local:      http://localhost:5000"
echo "  📧 Proxy Python:   main.py redirige a servidor Node.js"
echo ""
if [ -z "$DATABASE_URL" ] || [ "$DATABASE_URL" = "postgresql://username:password@localhost:5432/holapage77" ]; then
    print_warning "Recuerda configurar las variables de entorno en .env:"
    echo "  • DATABASE_URL (requerida)"
    echo "  • PAYPAL_CLIENT_ID (para pagos)"
    echo "  • PAYPAL_CLIENT_SECRET (para pagos)"
    echo ""
fi
print_info "🚀 Para iniciar: npm run dev"
echo "=================================================="