# 1. Use a minimal base image to reduce attack surface
# Using Alpine reduces image size and removes unnecessary tools
FROM node:26.5.0-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy package files first (for better caching)
COPY package*.json ./

# 4. Install production dependencies only
# Using 'npm ci' guarantees a clean install from package-lock.json
RUN npm ci --only=production

# 5. Copy the rest of the application code
COPY . .

# 6. SECURITY: Run as a non-root user (Best Practice)
# This prevents attackers from having root access if they break out of the app
USER node

# 7. Start the application
CMD ["node", "index.js"]