#!/bin/bash

# Создаем каталог для сохранения всех логов
mkdir -p pod_logs

# Получаем список всех подов
pods=$(kubectl get pods -o=name)

# Итерируемся по списку подов
for pod in $pods; do
  # Извлекаем имя пода из вывода kubectl
  pod_name=$(echo $pod | cut -d/ -f2)

  # Создаем файл для сохранения логов в общей директории
  log_file="/home/logs/${pod_name}_logs.txt"

  # Используем kubectl logs для получения логов и сохранения их в файл
  kubectl logs $pod > $log_file

  # Опционально: Выводим сообщение о завершении операции для каждого пода
  echo "Логи пода $pod_name сохранены в файл $log_file"
done
