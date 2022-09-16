#!/bin/sh
set e

TERRAFORM_VERSION=1.2.0



tfenv install ${TERRAFORM_VERSION}
tfenv use ${TERRAFORM_VERSION}