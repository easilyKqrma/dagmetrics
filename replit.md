# HolaPage-77 - Trading Journal & Psychology Tracker

## Overview

HolaPage-77 is a comprehensive trading journal and psychology tracking application that helps traders analyze their performance and emotional patterns. The application allows users to log trades with detailed metrics, track their emotional states, and gain insights through advanced analytics. Built as a full-stack web application with modern technologies, it supports multiple trading accounts, custom instruments, and professional-grade performance analysis.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React with TypeScript, built using Vite for fast development and optimized production builds
- **Routing**: Wouter for lightweight client-side routing with protected routes for authenticated users
- **State Management**: TanStack Query (React Query) for server state management, caching, and data synchronization
- **UI Framework**: Radix UI components with Tailwind CSS for styling and shadcn/ui component library for consistent design system
- **Form Handling**: React Hook Form with Zod validation for type-safe form management and input validation
- **Charts & Visualization**: Recharts for data visualization and lightweight-charts for professional trading charts
- **Animations**: Framer Motion for smooth page transitions and component animations
- **Theme Management**: Custom theme provider with support for light, dark, and system themes

### Backend Architecture
- **Runtime**: Node.js with Express.js framework running on TypeScript for type safety
- **Database ORM**: Drizzle ORM with PostgreSQL for type-safe database operations and schema management
- **Authentication**: Independent JWT-based authentication system with bcrypt password hashing
- **API Design**: RESTful API architecture with standardized error handling and middleware-based route protection
- **File Structure**: Monorepo structure with shared types between client and server via shared schema
- **Proxy Setup**: Python Flask proxy server for development environment routing

### Database Design
PostgreSQL database with comprehensive schema including:
- **Users**: Independent authentication system with user profiles, preferences, and onboarding status
- **Trading Accounts**: Multiple account support per user (forex, crypto, futures, stocks, commodities)
- **Instruments**: Default and custom tradeable assets with tick values, sizes, and multipliers for P&L calculations
- **Trades**: Comprehensive trade logging with automatic P&L calculations, status tracking, and image uploads
- **Emotions**: Default emotion library plus custom user emotions for psychological analysis
- **Emotion Logs**: Linking emotions to specific trades with intensity ratings and notes
- **Notifications**: System-wide announcement and notification system
- **Sessions**: PostgreSQL-backed session storage for authentication persistence

### Authentication & Authorization
- **Independent Auth System**: Custom JWT-based authentication not relying on external auth providers
- **Password Security**: bcrypt hashing with proper salt rounds for secure password storage
- **Token Management**: JWT tokens stored in localStorage with server-side validation
- **Route Protection**: Middleware-based authentication for protected endpoints with role-based access
- **Admin System**: Admin user roles with access to dashboard, user management, and system analytics

## External Dependencies

### Payment Integration
- **PayPal Integration**: Full PayPal SDK integration for subscription payments with sandbox and production environments
- **PayPal Server SDK**: Server-side PayPal integration for order creation and payment capture

### Database & Hosting
- **Neon Database**: PostgreSQL hosting service via @neondatabase/serverless
- **Connection Pooling**: Built-in connection pooling for database efficiency

### UI & Styling
- **Radix UI**: Complete set of accessible UI primitives including dialogs, dropdowns, tooltips, and form controls
- **Tailwind CSS**: Utility-first CSS framework for rapid UI development
- **Flaticon Icons**: Professional icon library via @flaticon/flaticon-uicons
- **Lucide React**: Additional icon set for UI elements

### Development Tools
- **TypeScript**: Full type safety across frontend, backend, and shared schemas
- **Vite**: Fast build tool with hot module replacement for development
- **ESBuild**: Fast bundling for production builds
- **Drizzle Kit**: Database migration and schema management tools