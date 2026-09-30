FROM alpine:3.22 AS build
WORKDIR /site
COPY index.html favicon.ico ./
COPY js/ js/
COPY style/ style/
COPY meta/ meta/
RUN rm -f style/*.scss


FROM nginxinc/nginx-unprivileged:1.29-alpine
COPY --from=build /site /usr/share/nginx/html
USER 101
EXPOSE 8080
