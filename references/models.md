# Gemini Image Models Reference

## Nano Banana Model Family

These are Gemini's native image generation models (multimodal, not Imagen).

| Name           | Model ID                                  | Speed   | Quality | Notes                     |
|---------------|-------------------------------------------|---------|---------|---------------------------|
| Nano Banana   | `models/gemini-2.5-flash-image`           | Fast    | Good    | Stable, default choice    |
| Nano Banana 2 | `models/gemini-3.1-flash-image-preview`   | Medium  | Better  | Preview, may change       |
| Nano Banana Pro | `models/gemini-3-pro-image-preview`     | Slow    | Best    | 4K output, expensive      |

## Imagen Models (separate, professional grade)

| Name         | Model ID                            | Use Case                    |
|-------------|-------------------------------------|-----------------------------|
| Imagen 4    | `models/imagen-4.0-generate-001`    | General high quality        |
| Imagen 4 Ultra | `models/imagen-4.0-ultra-generate-001` | Premium photorealism   |
| Imagen 4 Fast | `models/imagen-4.0-fast-generate-001` | Speed-optimized          |

Imagen models use a different API endpoint (`generateImages` not `generateContent`) and do NOT use `responseModalities`.

## API Notes

- Nano Banana models: use `generateContent` with `responseModalities: ["TEXT", "IMAGE"]`
- Imagen models: use `models/<id>:generateImages` with `instances[].prompt`
- All require billing enabled — free tier quota for image models is 0

## Rate Limits (approximate, paid tier)

- ~2 requests/minute for preview models
- ~10 requests/minute for stable models
- Always add 5s delay between sequential image generations

## Pricing (approximate)

- Nano Banana: ~$0.04/image
- Imagen 4: ~$0.04/image
- Imagen 4 Ultra: ~$0.08/image
