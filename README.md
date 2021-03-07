# NOTAM download

Retrieve NOTAMs from ICAO API.

## Instructions

1. Download [`get-notams.ps1`](get-notams.ps1) in `C:\whatever\you\want\get-notams.ps1`
2. Retrieve an API key from [ICAO API Data Service](https://www.icao.int/safety/iStars/Pages/API-Data-Service-new.aspx)
3. Create a `C:\wherever\you\want\config.json` with config inside (use [`config.sample.json`](config.sample.json) as a model)
4. Open PowerShell
5. Execute `Unblock-File -Path C:\whatever\you\want\get-notams.ps1`
6. Execute `C:\whatever\you\want\get-notams.ps1 C:\wherever\you\want\config.json`
