# Домашнее задание к занятию `8.3. Gitlab` - `Алаев Марат`

### Задание 1


[Cкриншот к заданию 1](https://github.com/MaratAlaev/gitlab-hw/blob/main/img/1.png)


### Задание 2


```yaml
stages:
  - test
  - build

test:
  stage: test
  script: 
  - /usr/local/go/bin/go test .

build:
  stage: build
  image: docker:latest
  when: manual
  except:
    - master
  script:
   - docker build .
```


[Скриншот к заданию 2](https://github.com/MaratAlaev/gitlab-hw/blob/main/img/2.png)