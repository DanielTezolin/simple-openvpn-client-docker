FROM alpine:latest

# Install openvpn
RUN apk add --no-cache openvpn

# Copy the scripts
ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Expose the openvpn port
EXPOSE 1194/udp

CMD ["ovpn_run"]
