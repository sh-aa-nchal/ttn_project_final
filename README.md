# ttn_project_final
DevOps Bootcamp Workshop Project- Team 3
</br>
</br>

## 3 tier Application Architecture Set Up on AWS

![working-architecture](https://user-images.githubusercontent.com/99390379/160236508-2a712e62-cd4c-4b6c-a9ba-7f27e99b48ed.png)

Terraform to provison the complete Infrastructure

### Sample Java Application used in the Project
[Spring-boot Application](https://github.com/khoubyari/spring-boot-rest-example)


### Pre requisites
- Install aws-cli <br />
- Install terraform <br />
- aws configure

### Set Up

Follow the following to run the project on your local system or in order to start developing
the project further

```shell
git clone https://github.com/sh-aa-nchal/ttn_project_final.git
cd ttn_project_final/
```
### Infrastructure Modules
- [Application Load Balancer](test/modules/alb) </br>
- [Auto Scaling Group](test/modules/asg) </br>
- [Database](test/modules/database) </br>
- [Monitoring](test/modules/monitoring) </br>
- [Networking](test/modules/network)

### Initial Project Iteration
[Project Iteration 1 repository](https://github.com/sh-aa-nchal/ttn_project)

### Project Presentation
[Team 3 project PPT](https://docs.google.com/presentation/d/1YL8o-0TaSrZgJCfJQq-VAOTepqvNcdY7t0O-5J1wKO4/edit?usp=sharing)
