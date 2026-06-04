# ✅ Stage 1: Build React App
FROM node:18-alpine AS build

WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build React app
RUN npm run build


# ✅ Stage 2: Serve using NGINX
FROM nginx:alpine

# Remove default nginx static files (optional but clean)
RUN rm -rf /usr/share/nginx/html/*

# Copy React build files from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# ✅ Expose port (IMPORTANT)
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
