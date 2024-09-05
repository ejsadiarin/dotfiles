# Configuration Guide

to see an example project repo: [see https://github.com/ejsadiarin/lscs-backend-questions-api](https://github.com/ejsadiarin/lscs-backend-questions-api)

- copy and paste to root of project
- make sure that a `.env` file is configured also at the root of project like:

```env
MONGO_URI=mongodb://localhost:27017/exampledb
MONGO_USER=admin
MONGO_PASSWORD=pass
MONGO_DB=example
API_PORT=6969
```

- configure mongoose to connect to the URI above
- install and start container with:

```bash
docker compose up --build -d
```

That's it! now you can request from any http client

- ex. `curl`, postman, or any http client to request to `http://localhost/6969/`

---

- after testing the API, you can stop and remove the container

```bash
docker compose down
```

- you can also check running containers

```bash
docker container ls
```
