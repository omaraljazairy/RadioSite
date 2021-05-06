# build environment
FROM node:14 as build
WORKDIR /app
COPY . .
# RUN npm install
RUN npm run build

# production environment
FROM nginx
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

