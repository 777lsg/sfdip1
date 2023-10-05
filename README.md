# sfdip1
# 1
    - 1.1 Разварачиваем VM с помощью terraform
    - 1.2 Ansible находится на отдельной машине. В этой папке редактирум файл hosts.txt под наши сервера. befkuber.yml - подготовка дял установки kubernetes. dockerinst.yaml - установка docker. glrunner.yaml установка gitlab runners.
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

    - 3.1 Сборка лого Loki. Фото
    - 3.2 Настроен из шаблона zabbix - linux server. Также мониторится сайт и настроен триггер, если код сайта не равняется 200 то срабатывает триггер. При срабатывании триггера отправляется сообщение на телеграмм. Добавлены фото.




