import { existsSync, mkdirSync, writeFileSync } from 'fs';
import { dirname } from 'path';

// Specify the path where you want to check and potentially create a file
const filePath = '~/vault/Personal/todos/';

// Check if the directory exists, if not, create it
const dirName = dirname(filePath);
if (!existsSync(dirName)) {
  mkdirSync(dirName, { recursive: true });
}

// Check if the file exists
if (existsSync(filePath)) {
  // If the file exists, just log a message or perform any action you need
  console.log('File already exists.');
} else {
  // If the file does not exist, create it with the specified content
  const content = "\n\Here is text for the context:\n";
  writeFileSync(filePath, content, 'utf8');
  console.log('File created with default content.');
}
