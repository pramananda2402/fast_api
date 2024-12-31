#!/bin/bash

# Define project structure
PROJECT_NAME="digital_marketing_app"

echo "Creating project: $PROJECT_NAME"

mkdir -p $PROJECT_NAME/app/{controllers,models,views,core,db,services,api/{v1,v2},tasks,utils}
mkdir -p $PROJECT_NAME/tests
mkdir -p $PROJECT_NAME/migrations
mkdir -p $PROJECT_NAME/static/{images,css,js}

# Create files with minimal content
touch $PROJECT_NAME/app/__init__.py
touch $PROJECT_NAME/app/controllers/{__init__.py,campaigns.py,users.py}
touch $PROJECT_NAME/app/models/{__init__.py,campaign.py,user.py}
touch $PROJECT_NAME/app/views/{__init__.py,campaigns.py,users.py}
touch $PROJECT_NAME/app/core/{__init__.py,config.py,security.py,logging.py}
touch $PROJECT_NAME/app/db/{__init__.py,sql.py,nosql.py}
touch $PROJECT_NAME/app/services/{__init__.py,campaign_service.py,user_service.py}
touch $PROJECT_NAME/app/api/v1/{__init__.py,users.py,campaigns.py}
touch $PROJECT_NAME/app/tasks/{__init__.py,email_tasks.py}
touch $PROJECT_NAME/app/utils/{__init__.py,helpers.py}
touch $PROJECT_NAME/tests/{__init__.py,test_users.py,test_campaigns.py}
touch $PROJECT_NAME/.env
touch $PROJECT_NAME/Dockerfile
touch $PROJECT_NAME/docker-compose.yml
touch $PROJECT_NAME/requirements.txt

# Write minimal Dockerfile
cat <<EOF > $PROJECT_NAME/Dockerfile
FROM python:3.10

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOF

# Write minimal requirements.txt
cat <<EOF > $PROJECT_NAME/requirements.txt
fastapi
uvicorn
sqlalchemy
pydantic
motor
EOF

# Write minimal .env
cat <<EOF > $PROJECT_NAME/.env
SQL_DATABASE_URL=sqlite:///./test.db
NOSQL_DATABASE_URL=mongodb://localhost:27017
SECRET_KEY=supersecretkey
DEBUG=True
EOF

echo "Project $PROJECT_NAME created successfully!"
