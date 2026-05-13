# Use a slim Nginx image
FROM nginx:alpine

# Copy the build output from the local build/web directory
# This assumes you have already run 'flutter build web'
COPY build/web /usr/share/nginx/html

# Copy the custom nginx configuration
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Railway provides the PORT environment variable
EXPOSE 80
