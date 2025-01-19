FROM node:18

WORKDIR /opt/node_app

COPY . .

# do not ignore optional dependencies:
# Error: Cannot find module @rollup/rollup-linux-x64-gnu
RUN yarn --network-timeout 600000

ARG NODE_ENV=production

RUN yarn build:app:docker

EXPOSE 10001

ENV PORT=10001
ENV VITE_PORT=10001
# Disable auto browser opening
ENV BROWSER=none

WORKDIR /opt/node_app/excalidraw-app

CMD ["yarn", "vite", "--port", "10001", "--host"]

HEALTHCHECK CMD wget -q -O /dev/null http://localhost:10001 || exit 1
