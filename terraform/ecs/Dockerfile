FROM public.ecr.aws/debian/debian:stable-20240130-slim

COPY bootstrap /app/
RUN chmod +x /app/bootstrap

CMD ["/app/bootstrap"]
