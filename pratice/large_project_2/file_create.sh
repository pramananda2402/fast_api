#!/bin/bash

# Define project structure
PROJECT_NAME="digital_marketing_app"

echo "Creating project: $PROJECT_NAME"

mkdir -p $PROJECT_NAME/app/{controllers,models,views,core,services,api/{v1,v2},tasks,utils,static/{css,js,images}}
mkdir -p $PROJECT_NAME/tests
touch $PROJECT_NAME/.env
touch $PROJECT_NAME/Dockerfile
touch $PROJECT_NAME/requirements.txt

# Create __init__.py files
find $PROJECT_NAME/app -type d -exec touch {}/__init__.py \;
touch $PROJECT_NAME/tests/__init__.py

# Create essential files
cat <<EOF > $PROJECT_NAME/app/main.py
from fastapi import FastAPI
from app.api.v1 import users, campaigns
from app.core.config import settings

app = FastAPI(title="Digital Marketing App")

# Include API routes
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(campaigns.router, prefix="/api/v1/campaigns", tags=["Campaigns"])
EOF

cat <<EOF > $PROJECT_NAME/app/core/config.py
from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Digital Marketing App"
    secret_key: str = "supersecretkey"
    debug: bool = True

    class Config:
        env_file = ".env"

settings = Settings()
EOF

cat <<EOF > $PROJECT_NAME/app/api/v1/users.py
from fastapi import APIRouter
from app.controllers.users import get_users

router = APIRouter()

@router.get("/")
async def list_users():
    return get_users()
EOF

cat <<EOF > $PROJECT_NAME/app/api/v1/campaigns.py
from fastapi import APIRouter
from app.controllers.campaigns import get_campaigns

router = APIRouter()

@router.get("/")
async def list_campaigns():
    return get_campaigns()
EOF

cat <<EOF > $PROJECT_NAME/app/controllers/users.py
def get_users():
    return {"users": [{"id": 1, "name": "John Doe"}, {"id": 2, "name": "Jane Doe"}]}
EOF

cat <<EOF > $PROJECT_NAME/app/controllers/campaigns.py
def get_campaigns():
    return {"campaigns": [{"id": 1, "name": "Summer Sale"}, {"id": 2, "name": "Winter Fest"}]}
EOF

cat <<EOF > $PROJECT_NAME/app/views/users.py
def format_user_response(users):
    return {"total_users": len(users), "data": users}
EOF

cat <<EOF > $PROJECT_NAME/app/views/campaigns.py
def format_campaign_response(campaigns):
    return {"total_campaigns": len(campaigns), "data": campaigns}
EOF

cat <<EOF > $PROJECT_NAME/app/services/user_service.py
from app.controllers.users import get_users
from app.views.users import format_user_response

def fetch_users():
    users = get_users()
    return format_user_response(users)
EOF

cat <<EOF > $PROJECT_NAME/app/services/campaign_service.py
from app.controllers.campaigns import get_campaigns
from app.views.campaigns import format_campaign_response

def fetch_campaigns():
    campaigns = get_campaigns()
    return format_campaign_response(campaigns)
EOF

cat <<EOF > $PROJECT_NAME/Dockerfile
FROM python:3.10

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOF

cat <<EOF > $PROJECT_NAME/requirements.txt
fastapi
uvicorn
EOF

echo "Project $PROJECT_NAME created successfully!"
