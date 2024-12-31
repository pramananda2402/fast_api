from fastapi import APIRouter
from app.controllers.users import get_users

router = APIRouter()

@router.get("/")
async def list_users():
    return get_users()
