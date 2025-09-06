# HolaPage-77 - Trading Journal & Psychology Tracker

## 🚀 Inicialización Rápida

Para inicializar el proyecto desde cero en cualquier entorno:

```bash
# 1. Ejecutar el script de setup automático
chmod +x setup.sh
./setup.sh

# 2. Configurar variables de entorno (ver abajo)
# 3. Iniciar la aplicación
npm run dev
```

## 📋 Requisitos del Sistema

- **Node.js** 18+ (requerido)
- **npm** (incluido con Node.js)
- **PostgreSQL** (base de datos)
- **OpenSSL** (para generar secretos)

## ⚙️ Configuración de Variables de Entorno

El script `setup.sh` crea automáticamente un archivo `.env` con secretos seguros generados. Necesitas configurar manualmente:

### Variables Requeridas:
```env
# Base de datos PostgreSQL (REQUERIDA)
DATABASE_URL=postgresql://username:password@host:port/database

# Claves de PayPal (REQUERIDAS para pagos)
PAYPAL_CLIENT_ID=tu-client-id-de-paypal
PAYPAL_CLIENT_SECRET=tu-client-secret-de-paypal
```

### Variables Auto-generadas:
```env
# Estas se generan automáticamente por setup.sh
JWT_SECRET=secreto-generado-automaticamente
SESSION_SECRET=secreto-generado-automaticamente
PORT=5000
NODE_ENV=development
```

## 🛠️ Comandos Disponibles

```bash
# Desarrollo
npm run dev          # Inicia servidor de desarrollo
npm run build        # Construye para producción
npm run start        # Inicia servidor de producción
npm run check        # Verifica tipos TypeScript

# Base de datos
npm run db:push      # Aplica migraciones a la BD

# Setup completo
./setup.sh           # Inicializa proyecto desde cero
```

## 🌐 Para Replit

### Build Command:
```bash
sh ./setup.sh
```

### Publish Directory:
```
dist/public
```

### Run Command:
```bash
python main.py
```

## 🔧 Arquitectura

- **Frontend**: React + TypeScript + Vite
- **Backend**: Node.js + Express + TypeScript  
- **Database**: PostgreSQL + Drizzle ORM
- **Proxy**: Python (main.py) → Node.js server
- **Payments**: PayPal SDK integration
- **Auth**: JWT + bcrypt

## 📁 Estructura del Proyecto

```
.
├── client/          # Frontend React
├── server/          # Backend Node.js
├── shared/          # Tipos compartidos
├── migrations/      # Migraciones de BD
├── main.py         # Proxy Python
├── setup.sh        # Script de inicialización
└── .env.example    # Template de variables
```

## 🚀 Despliegue

### En Replit:
1. Configura las variables de entorno en Secrets
2. Build Command: `sh ./setup.sh`
3. Run Command: `python main.py`

### En otros proveedores:
1. Ejecuta `./setup.sh`
2. Configura variables de entorno
3. Ejecuta `npm run build && npm run start`

## 🔒 Seguridad

- JWT_SECRET es requerido (no tiene fallback inseguro)
- Secretos generados automáticamente con OpenSSL
- Variables sensibles deben configurarse por separado
- PayPal configurado para producción

## 📞 Soporte

- Email: metrics@gprojects.com
- WhatsApp: +1 809 486 6678