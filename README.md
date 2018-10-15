# vduduh_infra
vduduh Infra repository

## Понадобятся в работе
* Чтобы не ставить ruby на хост (нужен для ***travis***), запускаю в докере:
```powershell
docker run  -w /code -v C:\Users\user\Documents\Coding\go\src\vduduh_infra:/code --rm -it ruby bash
```
