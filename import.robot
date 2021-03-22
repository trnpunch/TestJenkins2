*** Settings ***
Library  OperatingSystem
Library  RequestsLibrary
Resource  keywords/common_keywords.robot
Variables  resources/configs/common_config.yaml
Variables  resources/configs/${ENV}/config.yaml
Variables  resources/error_msg.yaml


