---
name: imagen
description: "Generate images using Google Imagen 4 via the Gemini API. Use when: user asks to generate, create, or make an image, photo, picture, or visual. Supports any creative prompt."
metadata: { "openclaw": { "emoji": "ðŸŽ¨" } }
---

# Imagen 4 â€” AI Image Generation

Generate high-quality images using Google's Imagen 4 model via the Gemini API.

## Setup

Read `GEMINI_API_KEY` from `TOOLS.md` before calling the API.

## How to Generate an Image

### Step 1 â€” Call the API

```powershell
$apiKey = "<GEMINI_API_KEY from TOOLS.md>"
$body = @{
  instances = @(@{prompt = "<YOUR PROMPT HERE>"})
  parameters = @{sampleCount = 1}
} | ConvertTo-Json -Depth 5

$response = Invoke-RestMethod `
  -Uri "https://generativelanguage.googleapis.com/v1beta/models/imagen-4.0-generate-001:predict?key=$apiKey" `
  -Method POST `
  -Headers @{"Content-Type"="application/json"} `
  -Body $body

$imgData = $response.predictions[0].bytesBase64Encoded
$bytes = [Convert]::FromBase64String($imgData)
$outPath = "$env:USERPROFILE\.openclaw\workspace\generated_image.png"
[System.IO.File]::WriteAllBytes($outPath, $bytes)
Write-Output "Saved: $outPath"
```

### Step 2 â€” Send to Discord

```powershell
openclaw message send --channel discord --target "<CHANNEL_ID>" --message "<caption>" --media "<path_to_image>"
```

## Available Models

| Model | Name | Best For |
|-------|------|----------|
| `imagen-4.0-generate-001` | Imagen 4 | General use, photorealistic |
| `imagen-4.0-ultra-generate-001` | Imagen 4 Ultra | Highest quality |
| `imagen-4.0-fast-generate-001` | Imagen 4 Fast | Speed over quality |
| `gemini-2.5-flash-image` | Nano Banana | Fast, conversational edits |
| `gemini-3-pro-image-preview` | Nano Banana Pro | Character consistency |

## Prompt Tips

- Be descriptive: lighting, angle, style, mood
- Add "photorealistic", "cinematic", "4K", "detailed" for better results
- Specify style: "oil painting", "watercolor", "digital art", "concept art"

## Examples

- `"A drilling rig surrounded by a massive tornado, lightning, cinematic"`
- `"Product photo of used iPhone 13, white background, eBay listing style"`
- `"CashAI logo, money symbol with robot, modern flat design"`
- `"Infographic showing how AI skills work, clean minimal design"`

## Notes

- Images saved to workspace as `.png`
- Always send to Discord using `openclaw message send --media`
- API key stored in `TOOLS.md` as `GEMINI_API_KEY`

---
*CashAI skill â€” $100 â†’ $1000 mission* ðŸ¤™ðŸ’°
