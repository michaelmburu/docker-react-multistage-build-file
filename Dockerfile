#Multistage build for a React front end application
#Stage 1: as build informs docker not to dump the first build

FROM node:14-alpine as build 

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


#Stage 2
# grab the build folder adnd 
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]



