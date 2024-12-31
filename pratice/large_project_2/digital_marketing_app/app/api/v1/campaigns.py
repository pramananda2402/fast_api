from fastapi import APIRouter
from app.controllers.campaigns import get_campaigns

router = APIRouter()

@router.get("/")
async def list_campaigns():
    return get_campaigns()
