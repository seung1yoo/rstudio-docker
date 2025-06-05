

```
# 캐시 무시하고 새로 빌드
docker compose build --no-cache
docker compose up -d
docker compose logs -f
```

`http://<host>:8787 접속` -> users.csv에 적힌 50명 ID/PW로 로그인
