#!/bin/bash
# entrypoint.sh
 
# 注册Runner
gitlab-runner register \
  --non-interactive \
  --url "$CI_SERVER_URL" \
  --registration-token "<your-registration-token>" \
  --executor "docker" \
  --docker-image "docker:latest" \
  --description "docker-runner" \
  --tag-list "docker,shared" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
 
# 启动GitLab Runner服务
exec gitlab-runner run