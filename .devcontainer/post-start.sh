#!/usr/bin/env bash

# Install Go tools
RUN go install github.com/cweill/gotests/gotests@latest
RUN go install github.com/josharian/impl@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest
RUN go install golang.org/x/tools/gopls@latest

# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

clear
printf "\e[0;32mAWS Terraform Dev Container: $(basename $PWD)\e[0m\n"
devcontainer-info
