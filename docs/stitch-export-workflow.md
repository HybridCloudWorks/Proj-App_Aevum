# Stitch Code Export Workflow

Since direct authenticated download URLs for Stitch HTML/CSS are currently restricted in this environment, use the following "Proxy Prompt" method with the Stitch MCP server to retrieve raw code.

## Automated Export (System Agent)

If the AI agent is available, use this command:

1. Call `mcp_stitch_edit_screens` on the target screen.
2. Use a specific prompt: `"Please provide the full HTML and CSS source code for the '{Screen Title}' screen (screen_id: {ID}) so I can copy it into my codebase. I need the full component source."`
3. The Stitch model will output the code in the `text` field of the response.

## Manual Export (Web UI)

If you have access to the Stitch web interface:

1. Open the desired screen.
2. Click the **"Code"** or **"Export"** tab.
3. Select **"Tailwind/HTML"**.
4. Copy the raw HTML/CSS into your React components.

## Integration Steps

1.  **Extract Styles**: Move `<style>` blocks to a dedicated `.css` file or convert them to Tailwind classes.
2.  **JSX Conversion**:
    - `class` -> `className`
    - `style="color: red"` -> `style={{color: "red"}}`
    - Rename self-closing tags (e.g., `<img ... />`).
3.  **Variable Replacement**: Replace hardcoded text/paths with React dynamic props ($user, $data).
