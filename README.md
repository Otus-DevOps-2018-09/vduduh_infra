# vduduh_infra
vduduh Infra repository

### Понадобятся в работе
* Чтобы не ставить ruby на хост (нужен для ***travis***), запускаю в докере:
    ```powershell
    docker run  -w /code -v C:\Users\user\.ssh\:/ssh -v C:\Users\user\Coding\go\s*rc\github.com\Otus-DevOps-2018-09\vduduh_infra\:/code --rm -it ruby bash
    ```
* выполнить после запуска
    ```bash
    cp /ssh/appuser /root/appuser
    chmod 600 /root/appuser
    ```

### Для подключения к экземплярам через бастион хост
* копировать содержимое файла ***ssh_config*** в конец одного из файлов: ```/etc/ssh/ssh_config``` или ```~/.ssh/config```
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

### VPN доступ к сервера

Доменное имя - ```vpn.duduh.ru```
Сертификат от *Let's Encrypt*

bastion_IP = 35.240.95.152

someinternalhost_IP = 10.132.0.3

### Деплой тестового приложения (ДЗ №4 к занятию №6)

#### Что сделано:
* перенёс файлы старых ДЗ в папки **VPN** и **SSH**
* установил утилиту gcloud и выбрал проект и регион
* создал инстанс **reddit-app**
* установил на целевую ВМ ruby, mongo (с автозапуском)
* скопировал код приложения в ```/home/appuser/reddit``` и установил зависимости
* запустил приложение и дабавил порт в фаервол через веб-интерфейс
* создал скрипты по установке ПО и деплоя приложения
* для запуска **startup** скрипта через **gcloud** выполнить:
    ```powershell
    gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file startup-script=./reddit-startup.sh

    ```
* создание правила в межсетевом экране:
    ```powershell
    gcloud compute firewall-rules create "default-puma-server" --allow tcp:9292 --source-ranges="0.0.0.0/0" --description="ДЗ №4 к занятию №6" --target-tags=puma-server --priority=1000

    ```
* установление флага исполняемого файла:
    ```powershell
    git update-index --chmod=+x ./deploy.sh
    
    ```

### Сборка образов VM при помощи Packer (ДЗ №5 к занятию №7)
------
#### Что сделано: 
* перенёс файлы старых ДЗ в папкe `config-scripts` командой `git mv ...`
* установил `packer` командой `choco install packer`
* создал конфиг `ubuntu16.json`
* создал скрипты и удалил из них `sudo`
* развернул приложение 
* создал `variables.json`
* для запуска команда `packer.exe build -var-file variables.json ubuntu16.json`
* удалил SSH-ключи из метаданных
