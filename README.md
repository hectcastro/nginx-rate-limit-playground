# nginx-rate-limit-playground

A Docker Compose project to learn about Nginx rate-limiting.

## Table of Contents

- [Usage](#usage)
  - [Requirements](#requirements)
  - [Quick Setup](#quick-setup)

## Usage

### Requirements

- Docker 18.03+
- Docker Compose 1.21+
- cURL 7.54+

### Quick Setup

From within the project root, execute the command below to run the tests.

```bash
$ ./test.sh
Creating nginx-rate-limit_nginx_1 ... done

Starting rate limit tests:

  Successfully ALLOWED first request
  Successfully ALLOWED second request
  Successfully LIMITED third request

All tests succeeded!

Stopping nginx-rate-limit_nginx_1 ... done
Going to remove nginx-rate-limit_nginx_1
Removing nginx-rate-limit_nginx_1 ... done
```
