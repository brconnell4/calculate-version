FROM gittools/gitversion:5.12.0

RUN apt-get update
RUN apt-get install jq -y

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
#COPY .git/ .git/

ENTRYPOINT ["./entrypoint.sh"]
