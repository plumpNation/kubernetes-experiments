import express from 'express';
import os from 'os';

const app = express();

const PORT = process.env.PORT || 3000;
// If we are running in docker, we want to supply the HOST_PORT
// environment variable to the container, so that we can log
// the correct port to the console.
const HOST_PORT = process.env.HOST_PORT || PORT;

console.log(`Running application process as user ${os.userInfo().username}`);

app.get('/', (_, res) => {
  res.send('Hello World!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${HOST_PORT}`);
});

process.on('SIGINT', () => {
  console.log('Server is shutting down');
  process.exit(0);
});