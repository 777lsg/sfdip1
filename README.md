# sfdip1
# 1
    - 1.1 Разварачиваем VM с помощью terraform
    - 1.2 Подготавливаем VM с помощю ansible
    - 1.3 Настраиваем ansible и запускаем kubespray ansible-playbook -i inventory/k8s/inventory.ini cluster.yml

# 2

2.1 Настраиваем два piplan worker(один для сборки dockerfile второй для kubernetes), с помощью tags указываем на каком сервере запускать скрипт. 
    - stage: build1 - Cобираем Dockerfile и отправляем в dockerhub
    - stage: clean1 - чисти docker rmi

2.2 Настраиваем helm
  Подготавливаем все для helm https://gitlab.com/sf4634325/dv2.git - файлы (Deployment, PersistentVolumeClaim, PersistentVolume, Service)
  и добовляем переменную tagapp: latest(файл values.yaml), будем ее менять в stage: kuber1 - sudo helm install app . --set tagapp=$latest_tag
  $latest_tag - создаем переменную с указанием tag из https://gitlab.com/sf4634325/dv2.git(последную), для версии dockerhub и helm
(gitlab .gitlab-ci.yml)- stage: kuber1 - Закачивает все необходимые файлы из git clone https://gitlab.com/sf4634325/dv2.git и запускаем helm на piplan kubernetes

# 3

Установил zabbix сервер собираю логи с помощью скрипта он в 3.1
Настроен из шаблона zabbix - linux server. Также мониторится сайт и настроен триггер на кода сайта если он не равняется 200. При срабатывании триггера отправляется сообщение на телеграмм. Добавлены фото 3.2.


