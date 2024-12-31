from app.controllers.campaigns import get_campaigns
from app.views.campaigns import format_campaign_response

def fetch_campaigns():
    campaigns = get_campaigns()
    return format_campaign_response(campaigns)
