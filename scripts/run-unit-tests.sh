#!/bin/bash

cd sample-webapp && python -m pytest ./tests/test_app.py --junitxml=${SHORT_SHA}_test_log.xml && cd ..
