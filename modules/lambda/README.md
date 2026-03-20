# Lambda Module

## Overview

This Terraform module is designed **exclusively for local development** using LocalStack. It provisions Lambda functions in a simulated AWS environment for testing and development purposes.

## Important: Production AWS Deployments

⚠️ **This module should NOT be used for deploying Lambda functions to production AWS environments.**

For actual AWS deployments, Lambda functions are deployed directly from their respective repositories:

- **User Authorizer**: https://github.com/13SOAT-andromeda/tech-challenge-user-authorizer
- **User Authentication**: https://github.com/13SOAT-andromeda/tech-challenge-user-authentication
- **Notification Service**: https://github.com/13SOAT-andromeda/tech-challenge-notification-service

Each repository contains its own deployment pipeline and infrastructure configuration for AWS environments.

## Usage

This module is intended for use with LocalStack to simulate Lambda functions during local development and testing workflows.
