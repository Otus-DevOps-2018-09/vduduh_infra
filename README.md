# vduduh_infra
vduduh Infra repository

### Понадобятся в работе
* Чтобы не ставить ruby на хост (нужен для ***travis***), запускаю в докере:
    ```powershell
    docker run  -w /code -v C:\Users\user\.ssh\:/ssh -v C:\Users\user\Coding\go\src\github.com\Otus-DevOps-2018-09\vduduh_infra\:/code --rm -it ruby bash
    ```
* выполнить после запуска
    ```bash
    cp /ssh/appuser /root/appuser
    chmod 600 /root/appuser
    ```

### Для подключения к экземплярам 
* копировать содержимое файла ***ssh_config** в конец одного из файлов: ```/etc/ssh/ssh_config``` или ```~/.ssh/config```
    ```bash
    cat ssh_config >> /etc/ssh/ssh_config
    ```
* подключение к ```bastion``` хосту:
    ```bash
    ssh bastion
    ```
* подключение к ```someinternalhost``` хосту:
    ```bash
    ssh someinternalhost
    ```
* создать алиасы для подключения:
    ```bash
    cat <<EOF > /etc/profile.d/gce.sh
    alias bastion="ssh bastion"
    alias someinternalhost="ssh someinternalhost"
    source /etc/profile
    EOF
    ```