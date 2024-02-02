FROM node:20-alpine3.17 AS build

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build

FROM nginx:1.25.1 AS nginx

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]