FROM node:20

WORKDIR /usr/src/app

#package*.json => package.json & package-lock.json
COPY package*.json .
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]



