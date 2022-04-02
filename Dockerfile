FROM node as build 
#ARG ARG_BACKEND_URL 
WORKDIR /app 
COPY ./package.json . 
RUN npm install
COPY ./public ./public/ 
COPY ./src ./src/

#RUN BACKEND_URL=${ARG_BACKEND_URL} \ 
RUN npm run build
FROM nginx:1.17-alpine 
COPY --from=build /app/build /usr/share/nginx/html 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
