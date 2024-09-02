# mikmic_system

## connect to eks

- aws eks update-kubeconfig --region us-east-1 --name mikmic-cluster

## login AWS

- aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 941167916414.dkr.ecr.us-east-1.amazonaws.com

## compilar imagenes de docker para deployar PROD

- docker build -t mikmic_back_build .\back\api\
- docker build -t mikmic_front_build .\front\ --build-arg PROD=true

## Crear tags PROD

Back:

- docker tag mikmic_back_build:latest 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_back:latest
- docker push 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_back:latest

Front:

- docker tag mikmic_front_build:latest 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_front:latest
- docker push 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_front:latest

## para aplicar cambios en el server ejecutar

- kubectl rollout restart -f .\manifests\deployment.yml

## compilar imagenes de docker para deployar dev

- docker build -t mikmic_back_build:beta .\back\api\
- docker build -t mikmic_front_build:beta .\front\ --build-arg PROD=true

## Crear tags dev

Back:

- docker tag mikmic_back_build:beta 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_back:beta
- docker push 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_back:beta

Front:

- docker tag mikmic_front_build:beta 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_front:beta
- docker push 941167916414.dkr.ecr.us-east-1.amazonaws.com/mikmic_front:beta

## IMPORTANTES DE KUBERNETES

Para crear el secret que permite la conexion al registro privado de aws

- kubectl create secret docker-registry regcred --docker-server=xxx.amazonaws.com --docker-username=AWS --docker-password=GENERATE_TOKEN --docker-email=mikmic491@gmail.com

Para crear el secret con las variables de entorno de prod

- kubectl create secret generic gas-test-env --from-env-file=.\gas-test.env

Para eliminar el secret con las variables de entorno de prod

- kubectl delete secret generic gas-test-env
