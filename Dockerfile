# BUILD IMAGE
FROM node:8.11.4
WORKDIR /opt/spreadsheet-gateway
COPY . .
RUN yarn install --check-files --frozen-lockfile
RUN yarn build:main

# DEPLOY IMAGE
FROM node:8.11.4-alpine
RUN apk add --no-cache tzdata
COPY --from=0 /opt/spreadsheet-gateway /opt/spreadsheet-gateway
WORKDIR /opt/spreadsheet-gateway
CMD ["yarn", "start"]
