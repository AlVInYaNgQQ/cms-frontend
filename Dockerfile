# 使用 Node.js 官方提供的 Node 映像檔作為基礎
FROM node:18 AS builder

# 設定工作目錄
WORKDIR /app

# 複製整個專案到容器內
COPY . .

# 安裝相依套件
RUN apt-get install \
    && npm install


# 執行 Vue.js build
RUN npm run build

# 使用 Nginx 官方提供的 Nginx 映像檔作為基礎
FROM nginx:latest

# 複製 Vue.js build 完成後的檔案到 Nginx 的靜態檔案目錄
COPY --from=builder /app/dist /usr/share/nginx/html
COPY ./conf/mime.types ./conf/nginx2.conf /etc/nginx/
# COPY ./conf/mime.types ./conf/nginx.conf /etc/nginx/
# COPY ./conf/variables.conf.template /etc/nginx/templates/
# COPY ./source/conf /config/

EXPOSE 80

# 啟動 Nginx 服務
# CMD ["nginx", "-g", "daemon off;"]
# CMD ["npm", "run", "serve"]
