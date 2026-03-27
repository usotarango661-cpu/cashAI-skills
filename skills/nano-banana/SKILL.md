# Nano Banana Skill

> AI image generation skill powered by Google Gemini via nano-banana.ai

## Description
Use when: user asks to generate an image, create AI art, or make a visual using Nano Banana.

## Setup

Store your API key in TOOLS.md:
```
NANO_BANANA_API_KEY=your-key-here
```

## Usage

Call the Nano Banana API to generate images from text prompts.

### API Endpoint
```
POST https://api.nano-banana.ai/generate
Authorization: Bearer <NANO_BANANA_API_KEY>
Content-Type: application/json

{
  "prompt": "your image description here",
  "model": "nano-banana-2"
}
```

### Steps
1. Read NANO_BANANA_API_KEY from TOOLS.md
2. Send POST request with user's prompt
3. Download generated image
4. Save to workspace or send to Discord

## Examples
- "generate an image of an oil rig at sunset"
- "create an infographic of what a skill is"
- "make a product photo for eBay listing"

## Notes
- Powered by Google Gemini image generation
- Free tier available at nano-banana.ai
- High quality output suitable for eBay listings, social media, Discord

*CashAI skill - $100 to $1000 mission* 🤙💰
