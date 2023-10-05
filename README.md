# sfdip1
# 1
    - 1.1 Разварачиваем VM с помощью terraform
    - 1.2 Ansible находится на отдельной машине. В этой папке редактирум файл hosts.txt под наши сервера. 
    befkuber.yml - подготовка дял установки kubernetes. dockerinst.yaml - установка docker. glrunner.yaml установка gitlab runners.
    - 1.3 Установка kubernetes. Настраиваем ansible. В файле (inventory/k8s/inventory.ini) меняем наши сервера и запускаем kubespray ansible-playbook -i inventory/k8s/inventory.ini cluster.yml

# 2

2.1 Настраиваем два piplan worker(один для сборки dockerfile(work1) второй для kubernetes(kub1)), с помощью tags указываем на каком сервере запускать скрипт. 
    - stage: build1 - Cобираем Dockerfile и отправляем в dockerhub
    - stage: clean1 - Чисти docker rmi
    - stage: kuber1 - Запуск deploy helm на kubernetes
    $latest_tag - Эта переменная берет данные из gitlab tags для dockerfile и kubernetes tag. 


2.2 Настраиваем helm
  Подготавливаем все для helm https://gitlab.com/sf4634325/dv2.git - файлы helm/(Deployment, PersistentVolumeClaim, PersistentVolume, Service)
  В папке helm все необходимые файлы для сборки.
  Все, приложение должно запуститься в kubernetes.

2.3 Все файлы helm из https://gitlab.com/sf4634325/dv2.git

# 3

    - 3.1 Сборка лого Loki. Фото
    - 3.2 Настроен из шаблона zabbix - linux server. Также мониторится сайт и настроен триггер, если код сайта не равняется 200 то срабатывает триггер. При срабатывании триггера отправляется сообщение на телеграмм. Добавлены фото.




