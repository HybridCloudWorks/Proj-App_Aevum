import { readFileSync } from 'fs';
const content = readFileSync('apps/web/src/hooks/useMemories.js', 'utf8');
const lines = content.split('\n');
lines.slice(0, 15).forEach(line => console.log(line));
