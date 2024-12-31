from fastapi import FastAPI
from app.api.v1 import users, campaigns
from app.core.config import settings

app = FastAPI(title="Digital Marketing App")

# Include API routes
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(campaigns.router, prefix="/api/v1/campaigns", tags=["Campaigns"])


@app.get('/')
def home():
    return {"message": "home page"}