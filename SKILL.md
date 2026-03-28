---
name: gemini-image-gen
description: Generate images using Google Gemini's Nano Banana (gemini-2.5-flash-image) or Nano Banana 2 (gemini-3.1-flash-image-preview) models via the Gemini REST API. Use when the user asks to generate, create, or make an image using Gemini, Nano Banana, or Google's image generation models. Requires GEMINI_API_KEY in TOOLS.md. Saves images to the workspace images/ folder.
---

# Gemini Image Generation (Nano Banana)

Generate images using Google's Nano Banana models via the Gemini REST API.

## Prerequisites

- `GEMINI_API_KEY` must be set in `TOOLS.md`
- Billing must be enabled on the Google Cloud project tied to the key (free tier quota = 0 for image models)
- PowerShell available (Windows)

## Available Models

| Display Name    | Model ID                              | Notes                  |
|----------------|---------------------------------------|------------------------|
| Nano Banana    | `models/gemini-2.5-flash-image`       | Stable, fast           |
| Nano Banana 2  | `models/gemini-3.1-flash-image-preview` | Higher quality preview |
| Nano Banana Pro| `models/gemini-3-pro-image-preview`   | 4K quality             |
| Imagen 4       | `models/imagen-4.0-generate-001`      | Professional grade     |

**Default model:** `models/gemini-2.5-flash-image` (Nano Banana)

## Workflow

1. Read `GEMINI_API_KEY` from `TOOLS.md`
2. Determine output path (default: `workspace/images/`)
3. Run `scripts/generate_image.ps1` with prompt and filename
4. Confirm the image was saved and show the path

## Usage

Run the PowerShell script directly:

```powershell
.\scripts\generate_image.ps1 `
  -ApiKey "YOUR_KEY" `
  -Prompt "A glowing skill card floating in a futuristic digital space" `
  -OutFile "C:\path\to\output.png" `
  -Model "models/gemini-2.5-flash-image"
```

Or call it via exec from the agent — see `scripts/generate_image.ps1` for full parameter reference.

## Multiple Images

To generate multiple images, call the script once per image with a delay between calls:

```powershell
.\scripts\generate_image.ps1 -ApiKey $key -Prompt "..." -OutFile "img1.png"
Start-Sleep -Seconds 5
.\scripts\generate_image.ps1 -ApiKey $key -Prompt "..." -OutFile "img2.png"
```

## Error Handling

- **429 / free tier limit = 0**: Billing not enabled. Direct user to enable billing at https://console.cloud.google.com/billing
- **429 / rate limited**: Add `Start-Sleep -Seconds 15` between calls
- **400 / safety block**: Rephrase the prompt to remove policy-violating content

## Notes

- Images are returned as base64 PNG inline data and saved to disk
- `responseModalities` must include both `"TEXT"` and `"IMAGE"` for Nano Banana models
- See `references/models.md` for full model comparison and pricing
