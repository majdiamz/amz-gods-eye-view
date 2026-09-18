FROM node:24-bookworm-slim
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build
ENV HOST=0.0.0.0
ENV PORT=4173
EXPOSE 4173
CMD ["npm","run","dev","--","--host","0.0.0.0","--port","4173"]
