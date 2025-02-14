FROM node:20-bookworm

RUN apt-get update && apt-get install -y libnss3 libatk1.0-0 libx11-xcb1 libxcb1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npx playwright install --with-deps

RUN npm install -g allure-commandline

CMD ["npx", "playwright", "test", "--reporter=line,allure-playwright"]
