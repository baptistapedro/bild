FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /bild
WORKDIR /bild
RUN go build
RUN wget https://download.samplelib.com/jpeg/sample-clouds-400x300.jpg
RUN wget https://download.samplelib.com/jpeg/sample-red-400x300.jpg
RUN wget https://download.samplelib.com/jpeg/sample-green-200x200.jpg
RUN wget https://download.samplelib.com/jpeg/sample-green-100x75.jpg

FROM golang:1.19.1-buster
COPY --from=go-target /bild/bild /
COPY --from=go-target /bild/*.jpg /testsuite/

ENTRYPOINT []
CMD ["/bild", "effect", "median", "--radius", "1.5", "@@", "/dev/null/"]
